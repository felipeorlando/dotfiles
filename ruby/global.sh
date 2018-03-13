source common/functions.sh

# update gems
if which gem &> /dev/null; then
    msg_checking "gem"
    sudo gem update --system
    echo "gem"
fi

# jekyll
if which jekyll &> /dev/null; then
    msg_checking "jekyll"
else
    msg_install "jekyll" "gem install jekyll"
    sudo gem install jekyll
    msg_ok "jekyll"
fi

# rails
if which rails &> /dev/null; then
    msg_checking "rails"
else
    msg_install "rails" "gem install rails"
    sudo gem install rails
    msg_ok "rails"
fi
