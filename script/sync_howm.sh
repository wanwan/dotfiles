#!/bin/bash

HOWM_PASSWD=$HOME/dotfiles/private/sync

if [ -x $HOWM_PASSWD ]; then
  source $HOWM_PASSWD
fi

#PYTHONPATH=/usr/local/lib/python2.4/site-packages/:
COMMENTTAG="sync_howm.sh @ `hostname` (`date '+%Y-%m-%d_%T'`)"

pushd "$HOWM_DIR"

${REVISION_COMMAND} add .
${REVISION_COMMAND} commit -a -m "$COMMENTTAG"
#${REVISION_COMMAND} pull ${HOWM_BITBUCKET_URL} master
#${REVISION_COMMAND} push ${HOWM_BITBUCKET_URL}

${REVISION_COMMAND} pull ${HOWM_GITHUB_URL}
${REVISION_COMMAND} push ${HOWM_GITHUB_URL} master
#${REVISION_COMMAND} pull origin master
#${REVISION_COMMAND} push origin master

popd
