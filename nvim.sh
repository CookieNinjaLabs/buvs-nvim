#!/bin/bash

# Update Ubuntu
apt update && apt upgrade -y
apt install xsel ripgrep gcc make node npm -y

# Download and untar nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
rm -rf /opt/nvim
tar -C /opt -xzf nvim-linux64.tar.gz

# Delete the downloaded tar file
rm nvim-linux64.tar.gz

# Path to be added
NEW_PATH="/opt/nvim-linux64/bin"
BASHRC_FILE="/home/$SUDO_USER/.bashrc"

# Check if the path is already in the .bashrc file
if ! grep -q "$NEW_PATH" "$BASHRC_FILE"; then
  # Append the path to the .bashrc file
  echo "export PATH=\"\$PATH:$NEW_PATH\"" >>"$BASHRC_FILE"
  echo "Path added to $BASHRC_FILE."
else
  echo "Path is already in $BASHRC_FILE."
fi

# Reload the .bashrc
source "$BASHRC_FILE"

# Download and install JetBrains Mono Nerd Font
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip"
FONT_DIR="/home/$SUDO_USER/.local/share/fonts"

# Create the font directory if it doesn't exist
mkdir -p "$FONT_DIR"

# Download the font zip file
curl -Lo JetBrainsMono.zip "$FONT_URL"

# Unzip the font files
unzip -o JetBrainsMono.zip -d "$FONT_DIR"

# Delete the downloaded font zip file
rm JetBrainsMono.zip

# Refresh the font cache
fc-cache -fv

echo "JetBrains Mono Nerd Font installed successfully."

# Add nvchad
CONFIG_DIR="/home/$SUDO_USER/.config"

# Check if the config directory exists, create it if it doesn't
if [ ! -d "$CONFIG_DIR" ]; then
  mkdir -p "$CONFIG_DIR"
  echo "Created config directory at $CONFIG_DIR."
else
  echo "Config directory already exists at $CONFIG_DIR."
fi

if git clone https://github.com/NvChad/starter /home/$SUDO_USER/.config/nvim; then
  nvim
else
  echo "Failed to clone nvchad repository."
fi

chown -R $SUDO_USER $CONFIG_DIR/nvim/
chmod +w $CONFIG_DIR/nvim/

# git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
echo "Run :MasonInstallAll in nvim"
# install gnome-terminal-one theme
echo "bash -c '$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh)'"
