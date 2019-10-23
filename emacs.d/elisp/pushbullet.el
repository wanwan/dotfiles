;;; pushbullet.el --- An emacs client for the pushbullet android app
;;; Using the pushbullet api at https://pushbullet.com/api 
;;; Uses grapnel for http requests https://github.com/leathekd/grapnel
;;; 
;;; Commentary: 
;;; 
;;; Code:

(require 'grapnel)
(require 'json)

;;(defvar pushbullet-api-key ""
;;  "API Key for your pushbullet account"
;;  )

(defun pb/get-devices ()
  "Get the devices available for pushing data"
  (let ((grapnel-options
        (concat "-u " pushbullet-api-key ":")))
    (grapnel-retrieve-url
     "https://www.pushbullet.com/api/devices"
     '((success . (lambda (res hdrs)
                    (setq pb/device-id-list (pb/extract-device-ids res)))) 
       (failure . (lambda (res hdrs) (message "Failure %s" res)))
       (error . (lambda (res err) (message "err %s" err))))
     "GET")))

(defun pb/extract-device-ids (devices-json)
  "Make a list of device ids from the received json response"
  (let* ((json-object-type 'alist)
         (pb-json-response (json-read-from-string devices-json))) 
    (mapcar (lambda (x) (cdr (assoc 'id  x)))
            (cdr (assoc 'devices pb-json-response)))))

(defun pb/push-item (text type title)
  "Pushes the item to your device"
  (unless (boundp 'pb/device-id-list)
    pb/get-devices)
  (dolist (device_id pb/device-id-list)
    (let ((grapnel-options
         (concat "-u " pushbullet-api-key ": ")
         ))
      (grapnel-retrieve-url
          "https://www.pushbullet.com/api/pushes"
          `((success . (lambda (res hdrs)
                         (message "success! pushed to device id:%s ")))
            (failure . (lambda (res hdrs) (message "failure! %s" hdrs)))
            (error . (lambda (res err) (message "err %s" err))))
          "POST"
            nil
            `(("device_id" . ,(number-to-string device_id))
              ("type" . ,type)
              ("title" . ,title)
              ("body" . ,text))
            ))))

(defun pb/send-region (title)
"Pushes a region as an note"
  (interactive "sEnter title for this push:" )
  (let ((selection 
          (buffer-substring-no-properties (region-beginning) (region-end))))
    (unless (= (length selection) 0)
      (pb/push-item selection "note" title))))

(provide 'pushbullet)
;;; pushbullet.el ends here
