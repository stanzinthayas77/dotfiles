#!/bin/bash

echo "🚀 Setting up your dotfiles..."

FILES=(zshrc gitconfig aliases exports functions)

for file in "${FILES[@]}"; do
  src="$HOME/.dotfiles/$file"
  dest="$HOME/.$file"

  if [ -f "$dest" ] || [ -L "$dest" ]; then
    echo "🔁 Backing up $dest to $dest.backup"
    mv "$dest" "$dest.backup"
  fi

  echo "🔗 Symlinking $src → $dest"
  ln -s "$src" "$dest"
done

# Install Powerlevel10k
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "🎨 Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Install CLI tools
echo "🔧 Installing CLI tools..."
sudo apt update
sudo apt install -y bat fzf ripgrep fd-find

# Link batcat to bat if needed
if ! command -v bat &> /dev/null && command -v batcat &> /dev/null; then
  sudo ln -s /usr/bin/batcat /usr/local/bin/bat
fi

echo "✅ All done! Restart terminal or run: source ~/.zshrc"
#!/bin/bash

# Symlink dotfiles
ln -sf ~/.dotfiles/zshrc ~/.zshrc
ln -sf ~/.dotfiles/p10k.zsh ~/.p10k.zsh
ln -sf ~/.dotfiles/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/aliases ~/.aliases
ln -sf ~/.dotfiles/aliases.zsh ~/.aliases.zsh
ln -sf ~/.dotfiles/exports ~/.exports
ln -sf ~/.dotfiles/functions ~/.functions

echo "✅ Dotfiles linked!"
