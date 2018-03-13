source common/functions.sh

# nodejs
if which node &> /dev/null; then
    msg_checking "node"
else
    msg_install "node" "npm install -g n"
    npm install -g n
    sudo n stable
    echo "OK"
fi

# yeoman
if which yo &> /dev/null; then
    msg_checking "yo"
else
    msg_install "yo" "npm install -g yo"
    npm install -g yo
    echo "OK"
fi

# gulp
if which gulp &> /dev/null; then
    msg_checking "gulp"
else
    msg_install "gulp" "npm install -g gulp"
    npm install -g gulp
    echo "OK"
fi

# sass
if which sass &> /dev/null; then
    msg_checking "sass"
else
    msg_install "sass" "npm install -g node-sass"
    npm install -g node-sass
    echo "OK"
fi

# browserify
if which browserify &> /dev/null; then
    msg_checking "browserify"
else
    msg_install "browserify" "npm install -g browserify"
    npm install -g browserify
    echo "OK"
fi
