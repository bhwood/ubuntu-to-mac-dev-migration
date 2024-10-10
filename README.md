# Comprehensive Guide: Ubuntu to MacBook Pro Developer Transition

This guide provides a detailed, step-by-step process for transitioning from an Ubuntu development environment to a new MacBook Pro, including data transfer and new system setup.

## Table of Contents
1. [Preparation on Ubuntu Machine](#1-preparation-on-ubuntu-machine)
2. [Data Transfer](#2-data-transfer)
3. [Initial MacBook Pro Setup](#3-initial-macbook-pro-setup)
4. [Core Development Environment Setup](#4-core-development-environment-setup)
5. [Language-Specific Setup](#5-language-specific-setup)
6. [Cloud and Infrastructure Tools Setup](#6-cloud-and-infrastructure-tools-setup)
7. [IDE and Text Editor Setup](#7-ide-and-text-editor-setup)
8. [Terminal and Shell Configuration](#8-terminal-and-shell-configuration)
9. [Productivity Tools Setup](#9-productivity-tools-setup)
10. [Final Configurations and Optimizations](#10-final-configurations-and-optimizations)

## 1. Preparation on Ubuntu Machine

- [ ] Perform a full system backup
  ```bash
  sudo tar -cvpzf backup.tar.gz --exclude=/backup.tar.gz --exclude=/proc --exclude=/tmp --exclude=/mnt --exclude=/dev --exclude=/sys --exclude=/run --exclude=/media --exclude=/var/log --exclude=/var/cache/apt/archives --exclude=/usr/src/linux-headers* --exclude=/home/*/.cache --exclude=/home/*/.local/share/Trash /
  ```

- [ ] Create a list of installed software
  ```bash
  dpkg --get-selections > installed_software.txt
  ```

- [ ] Export crontabs
  ```bash
  crontab -l > my_crontab.txt
  ```

- [ ] List all PPAs
  ```bash
  grep -RoPish "ppa.launchpad.net/[^/]+/[^/ ]+" /etc/apt | sort -u > my_ppas.txt
  ```

- [ ] Export a list of manually installed packages
  ```bash
  comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u) > manually_installed_packages.txt
  ```

## 2. Data Transfer

- [ ] Create a directory for files to transfer
  ```bash
  mkdir ~/transfer
  ```

- [ ] Copy personal files
  ```bash
  cp -R ~/Documents ~/Pictures ~/Videos ~/Music ~/Downloads ~/transfer/
  ```

- [ ] Copy development files
  ```bash
  cp -R ~/projects ~/repositories ~/transfer/
  ```

- [ ] Copy dotfiles and configurations
  ```bash
  cp ~/.bashrc ~/.zshrc ~/.gitconfig ~/.ssh ~/.aws ~/transfer/
  ```

- [ ] Export database dumps (example for PostgreSQL)
  ```bash
  pg_dumpall > ~/transfer/database_dump.sql
  ```

- [ ] Copy VS Code settings
  ```bash
  cp -R ~/.config/Code/User ~/transfer/vscode_settings
  ```

- [ ] Archive the transfer directory
  ```bash
  tar -czf transfer.tar.gz ~/transfer
  ```

- [ ] Transfer the archive to an external drive or cloud storage
  ```bash
  # For external drive
  cp transfer.tar.gz /media/external_drive/
  # For cloud storage (example with rclone)
  rclone copy transfer.tar.gz remote:backup/
  ```

## 3. Initial MacBook Pro Setup

- [ ] Complete initial macOS setup wizard

- [ ] Update macOS
  - Apple menu > System Preferences > Software Update

- [ ] Install Xcode Command Line Tools
  ```bash
  xcode-select --install
  ```

- [ ] Install Homebrew
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

- [ ] Add Homebrew to PATH
  ```bash
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  ```

## 4. Core Development Environment Setup

- [ ] Install Git
  ```bash
  brew install git
  ```

- [ ] Configure Git
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "your.email@example.com"
  ```

- [ ] Install essential command-line tools
  ```bash
  brew install curl wget tree jq
  ```

- [ ] Install Docker
  ```bash
  brew install --cask docker
  ```

## 5. Language-Specific Setup

### Python

- [ ] Install Python
  ```bash
  brew install python
  ```

- [ ] Install pyenv
  ```bash
  brew install pyenv
  echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
  echo 'eval "$(pyenv init -)"' >> ~/.zshrc
  ```

- [ ] Install dependency management tools
  ```bash
  pip install pipenv poetry
  ```

### JavaScript and React

- [ ] Install Node.js and npm
  ```bash
  brew install node
  ```

- [ ] Install Yarn
  ```bash
  brew install yarn
  ```

- [ ] Install create-react-app
  ```bash
  npm install -g create-react-app
  ```

## 6. Cloud and Infrastructure Tools Setup

### AWS

- [ ] Install AWS CLI
  ```bash
  brew install awscli
  ```

- [ ] Configure AWS CLI
  ```bash
  aws configure
  ```

- [ ] Install AWS SAM CLI
  ```bash
  brew install aws-sam-cli
  ```

- [ ] Install AWS CDK
  ```bash
  npm install -g aws-cdk
  ```

- [ ] Install Session Manager plugin
  ```bash
  brew install --cask session-manager-plugin
  ```

- [ ] Install aws-vault
  ```bash
  brew install aws-vault
  ```

### Terraform

- [ ] Install Terraform
  ```bash
  brew install terraform
  ```

- [ ] Install Terraform Language Server
  ```bash
  brew install hashicorp/tap/terraform-ls
  ```

- [ ] Install Terragrunt
  ```bash
  brew install terragrunt
  ```

- [ ] Install tflint
  ```bash
  brew install tflint
  ```

- [ ] Install tfenv
  ```bash
  brew install tfenv
  ```

## 7. IDE and Text Editor Setup

- [ ] Install Visual Studio Code
  ```bash
  brew install --cask visual-studio-code
  ```

- [ ] Install VS Code extensions
  ```bash
  code --install-extension ms-python.python
  code --install-extension ms-python.vscode-pylance
  code --install-extension dbaeumer.vscode-eslint
  code --install-extension esbenp.prettier-vscode
  code --install-extension dsznajder.es7-react-js-snippets
  code --install-extension eamodio.gitlens
  code --install-extension amazonwebservices.aws-toolkit-vscode
  code --install-extension kddejong.vscode-cfn-lint
  code --install-extension hashicorp.terraform
  code --install-extension mindginative.terraform-snippets
  ```

- [ ] Set up VS Code settings (create or edit ~/.config/Code/User/settings.json)
  ```json
  {
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.organizeImports": true
    },
    "python.linting.pylintEnabled": true,
    "python.linting.enabled": true,
    "python.formatting.provider": "black",
    "python.linting.flake8Enabled": true,
    "python.testing.pytestEnabled": true,
    "[python]": {
      "editor.formatOnSave": true,
      "editor.defaultFormatter": "ms-python.python"
    },
    "[javascript]": {
      "editor.formatOnSave": true,
      "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[javascriptreact]": {
      "editor.formatOnSave": true,
      "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "javascript.updateImportsOnFileMove.enabled": "always",
    "typescript.updateImportsOnFileMove.enabled": "always",
    "eslint.validate": [
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact"
    ],
    "aws.telemetry": false,
    "aws.profile": "your-sso-profile",
    "[terraform]": {
      "editor.formatOnSave": true,
      "editor.defaultFormatter": "hashicorp.terraform"
    },
    "terraform.languageServer": {
      "external": true,
      "args": [
        "serve"
      ]
    },
    "terraform.experimentalFeatures.validateOnSave": true
  }
  ```

### 8. Terminal and Shell Configuration

- [ ] Install iTerm2
  ```bash
  brew install --cask iterm2
  ```

- [ ] Install Zsh plugins and tools
  ```bash
  brew install zsh-autosuggestions zsh-syntax-highlighting
  git clone https://github.com/marlonrichert/zsh-autocomplete.git ~/.zsh/zsh-autocomplete
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.zsh/fast-syntax-highlighting
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
  ```

- [ ] Install colorls
  ```bash
  gem install colorls
  ```

- [ ] Install fzf
  ```bash
  brew install fzf
  $(brew --prefix)/opt/fzf/install
  ```

- [ ] Create a new ~/.zshrc file with the following content:

  ```zsh
  # Load plugins
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
  source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

  # Override default config variables
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=grey'

  # Enable Powerlevel10k instant prompt
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

  # Set up the prompt
  autoload -Uz promptinit
  promptinit
  prompt adam1

  setopt histignorealldups sharehistory

  # Lazy load NVM using custom script
  source ~/lazy_nvm.sh

  # Pyenv setup
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"

  # History settings
  HISTSIZE=1000
  SAVEHIST=1000
  HISTFILE=~/.zsh_history

  # Completion settings
  zstyle ':completion:*' auto-description 'specify: %d'
  zstyle ':completion:*' completer _expand _complete _correct _approximate
  zstyle ':completion:*' format 'Completing %d'
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*' menu select=2
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*' list-colors ''
  zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
  zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
  zstyle ':completion:*' menu select=long
  zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
  zstyle ':completion:*' use-compctl false
  zstyle ':completion:*' verbose true
  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
  zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

  # Load Powerlevel10k theme
  source ~/.powerlevel10k/powerlevel10k.zsh-theme

  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

  export PATH="$HOME/.local/bin:$PATH"

  # NVM setup
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # Go path
  export PATH=$PATH:/usr/local/go/bin

  # Aliases
  alias ls="colorls --sd"
  alias reload='source ~/.zshrc'
  alias zsconfig="open -a 'Sublime Text' ~/.zshrc"
  alias myip="curl http://ipecho.net/plain; echo"
  alias ppwd="export PYTHONPATH=$(pwd)"
  alias pynewenv='python -m venv venv'
  alias pystart='source venv/bin/activate'
  alias awslogin='aws sso login --profile your-sso-profile'
  alias awswhoami='aws sts get-caller-identity'
  alias tf='terraform'
  alias tfi='terraform init'
  alias tfp='terraform plan'
  alias tfa='terraform apply'
  alias tfd='terraform destroy'
  alias tff='terraform fmt'
  alias tfv='terraform validate'
  alias gmail="open https://mail.google.com"
  alias gcal="open https://calendar.google.com"
  alias gdrive="open https://drive.google.com"
  alias gdocs="open https://docs.google.com"
  alias gsheets="open https://sheets.google.com"
  alias gslides="open https://slides.google.com"

  # Functions
  ffs() {
      sudo $(fc -ln -1)
  }

  # Load fzf
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  # Ruby setup
  export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
  ```

- [ ] Create the lazy_nvm.sh script:
  ```bash
  cat << EOF > ~/lazy_nvm.sh
  lazy_load_nvm() {
    unset -f node npm nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  }

  node() {
    lazy_load_nvm
    node "$@"
  }

  npm() {
    lazy_load_nvm
    npm "$@"
  }

  nvm() {
    lazy_load_nvm
    nvm "$@"
  }
  EOF
  ```

- [ ] Set up Powerlevel10k
  ```bash
  p10k configure
  ```

- [ ] Ensure proper permissions for the .zshrc file
  ```bash
  chmod 644 ~/.zshrc
  ```

## 9. Productivity Tools Setup

- [ ] Install Slack
  ```bash
  brew install --cask slack
  ```

- [ ] Install Google Chrome
  ```bash
  brew install --cask google-chrome
  ```

- [ ] Install Google Drive
  ```bash
  brew install --cask google-drive
  ```

## 10. Final Configurations and Optimizations

- [ ] Set up Terraform autocomplete
  ```bash
  terraform -install-autocomplete
  ```

- [ ] Set up pre-commit hooks for Terraform (create .pre-commit-config.yaml in your project root)
  ```yaml
  repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.64.0
    hooks:
      - id: terraform_fmt
      - id: terraform_docs
      - id: terraform_tflint
      - id: terraform_validate
  ```

- [ ] Install and set up pre-commit
  ```bash
  brew install pre-commit
  pre-commit install
  ```

- [ ] Restore data from backup
  ```bash
  # If using external drive
  cp /Volumes/ExternalDrive/transfer.tar.gz ~/
  # If using cloud storage (example with rclone)
  rclone copy remote:backup/transfer.tar.gz ~/

  tar -xzf transfer.tar.gz
  ```

- [ ] Restore dotfiles and configurations
  ```bash
  cp -R ~/transfer/.bashrc ~/transfer/.zshrc ~/transfer/.gitconfig ~/
  cp -R ~/transfer/.ssh ~/transfer/.aws ~/
  ```

- [ ] Restore VS Code settings
  ```bash
  cp -R ~/transfer/vscode_settings ~/.config/Code/User
  ```

- [ ] Import database dumps (example for PostgreSQL)
  ```bash
  psql -f ~/transfer/database_dump.sql
  ```

- [ ] Review and adapt crontabs for macOS (using launchd)
  - Open and review ~/transfer/my_crontab.txt
  - Create appropriate .plist files in ~/Library/LaunchAgents/

- [ ] Review installed software list and install necessary applications
  - Open and review ~/transfer/installed_software.txt
  - Install macOS equivalents using Homebrew or the App Store

- [ ] Set up SSH keys
  ```bash
  chmod 600 ~/.ssh/id_rsa
  chmod 644 ~/.ssh/id_rsa.pub
  ssh-add ~/.ssh/id_rsa
  ```

- [ ] Clean up transfer files
  ```bash
  rm -rf ~/transfer ~/transfer.tar.gz
  ```

Remember to restart your terminal or run `source ~/.zshrc` after making changes to your shell configuration. This guide provides a comprehensive setup for your new MacBook Pro development environment while ensuring a smooth transition from your Ubuntu machine. Adjust steps as necessary based on your specific needs and preferences.
