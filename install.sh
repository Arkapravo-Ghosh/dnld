#!/bin/bash

dnld_url="https://raw.githubusercontent.com/Arkapravo-Ghosh/down/main/src/main.sh"
install_file="down"

# Function to download file using curl or wget
download_file() {
    if command -v curl &> /dev/null; then
        curl -sSL "$dnld_url" -o "$1"
    elif command -v wget &> /dev/null; then
        wget -q -O "$1" "$dnld_url"
    else
        echo "Error: curl or wget is required to download files."
        exit 1
    fi
}

# Determine the installation directory
case "$OSTYPE" in
    "linux-gnu"*)
        install_dir="/usr/local/bin"
        [[ -w "$install_dir" ]] || { echo "Requires sudo to install to $install_dir"; exit 1; }
        ;;
    "darwin"*)
        install_dir="/usr/local/bin"
        ;;
    "msys" | "cygwin" | "win32")
        install_dir="$HOME/bin"
        mkdir -p "$install_dir"
        ;;
    *)
        echo "Unsupported OS: $OSTYPE"
        exit 1
        ;;
esac

# Download and install
download_file "$install_file"
chmod +x "$install_file"
mv "$install_file" "$install_dir"

echo "The 'down' command has been installed in $install_dir"
echo "You can start using the 'down' command immediately."
