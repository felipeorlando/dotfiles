# cask
brew install caskroom/cask/brew-cask

# add formulae to homebrew
brew tap homebrew/science # science
brew tap caskroom/fonts # fonts
brew tap caskroom/versions

# langs
brew install python # python

# remove outdated versions from the cellar
brew cleanup

# browsers
brew cask install firefox 2> /dev/null
brew cask install google-chrome 2> /dev/null
brew cask install caskroom/versions/firefoxdeveloperedition 2> /dev/null

# dev apps
brew cask install imageoptim 2> /dev/null
brew cask install iterm2 2> /dev/null
brew cask install visual-studio-code 2> /dev/null
brew cask install sequel-pro 2> /dev/null
brew cask install psequel 2> /dev/null
brew cask install postgres 2> /dev/null
brew cask install graphql-playground 2> /dev/null
brew cask install postman 2> /dev/null

# apps
brew cask install vlc 2> /dev/null
brew cask install transmission 2> /dev/null
brew cask install spotify 2> /dev/null
brew cask install slack 2> /dev/null
brew cask install telegram 2> /dev/null
brew cask install skype 2> /dev/null
brew cask install coconutbattery 2> /dev/null
brew cask install stremio 2> /dev/null
brew cask install spectacle 2> /dev/null
brew cask install beardedspice 2> /dev/null
