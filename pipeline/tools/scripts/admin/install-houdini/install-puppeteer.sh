#!/bin/bash

CD=$(dirname $(readlink -f $0))
export HOME=/dev/shm/

if [ ! -e $CD/nodejs/package.json ] ; then
    mkdir -p $CD/nodejs/
    cd $CD/nodejs/

    # http_proxy=$(ppython -c 'import os;print(os.environ["PIPE_PROXY_SERVER"])')
    # https_proxy=$http_proxy
    # ftp_proxy=$http_proxy
    # extra=" --proxy '$https_proxy' "

    curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    export PATH=$CD:$PATH

    nvm install node
    npm $extra init -y
    npm $extra install puppeteer
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=$CD:$PATH
