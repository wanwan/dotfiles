#!/bin/bash

WWAN_IF=wwp0s20f0u6i12

if [ `id -u` -ne 0 ]; then
  exec sudo -E $0 $@
fi

if [[ $1 == 'start' ]]; then

  # start modem manager service
  #/etc/init.d/modemmanager start

  # unblock the wwan device
  rfkill_device=$(rfkill list | grep tpacpi_wwan_sw | awk 'BEGIN { FS = ":" } ; { print $1 }')
  rfkill unblock ${rfkill_device}

  # send fcc authentication
  qmicli --device-open-mbim -d /dev/cdc-wdm0 --dms-set-fcc-authentication

  # start connection
  mbim-network /dev/cdc-wdm0 start

  # query ip
  query=$(mbimcli -d /dev/cdc-wdm0 -p  --query-ip-configuration)
  squery=($query) #split into array elements

  ipv4=$(echo ${squery[10]} | sed s/\'//g)
  gwv4=$(echo ${squery[12]} | sed s/\'//g)
  d1v4=$(echo ${squery[15]} | sed s/\'//g)
  d2v4=$(echo ${squery[18]} | sed s/\'//g)
  ipv6=$(echo ${squery[31]} | sed s/\'//g)
  gwv6=$(echo ${squery[33]} | sed s/\'//g)
  d1v6=$(echo ${squery[36]} | sed s/\'//g)
  d2v6=$(echo ${squery[39]} | sed s/\'//g)

  echo ""
  echo "IPv4 configuration"
  echo "IP:      " $ipv4
  echo "Gateway: " $gwv4
  echo "DNS 1:   " $d1v4
  echo "DNS 2:   " $d2v4
  echo ""
  echo "IPv6 configuration"
  echo "IPv6:    " $ipv6
  echo "Gateway: " $gwv6
  echo "DNS 1:   " $d1v6
  echo "DNS 2:   " $d2v6
  echo ""

  # deactivate all other devices
  # important cause it removes the default gateway and you dont want to have multiple
  ip link set enp0s31f6 down
  ip link set wlp58s0 down  
  
  if [[ $2 == '' || $2 == '4' ]]; then
    # ipv4
    ip addr add $ipv4 dev $WWAN_IF
    echo nameserver $d1v4 > /etc/resolv.conf
    echo nameserver $d2v4 >> /etc/resolv.conf
    # activate device
    ip link set $WWAN_IF up
    ip route add default via $gwv4

  
  elif [[ $2 == '6' ]]; then
    # ipv6
    ip addr add $ipv6 dev $WWAN_IF
    echo nameserver $d1v6 > /etc/resolv.conf
    echo nameserver $d2v6 >> /etc/resolv.conf
    # activate device
    ip link set $WWAN_IF up
    ip route add default via $gwv6
  fi  

elif [[ $1 == 'stop' ]]; then

  # stop connection
  mbim-network /dev/cdc-wdm0 stop

  # deactivate device
  ip link set $WWAN_IF down
  ip add flush dev $WWAN_IF

  # stop modem manager service
  #/etc/init.d/modemmanager stop

fi
