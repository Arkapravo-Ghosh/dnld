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

# Function to install dependencies
install_dependencies() {
    case "$OSTYPE" in
        "linux-gnu"*)
            if command -v apt &> /dev/null; then
                sudo apt update && sudo apt full-upgrade -y
                sudo apt install -y python3 ffmpeg exiftool
                python3 -m pip install -U pip
                python3 -m pip install yt-dlp
            else
                echo "Error: Unsupported Linux package manager."
                exit 1
            fi
            ;;
        "darwin"*)
            if command -v brew &> /dev/null; then
                brew update
                brew install python ffmpeg exiftool
                pip3 install -U pip
                pip3 install yt-dlp
            else
                echo "Error: Homebrew (brew) is required on macOS."
                exit 1
            fi
            ;;
        "msys" | "cygwin" | "win32")
            echo "Error: Direct Windows support not implemented. Please use WSL."
            exit 1
            ;;
        *)
            echo "Unsupported OS: $OSTYPE"
            exit 1
            ;;
    esac
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

# Install dependencies
install_dependencies

# Download and install
download_file "$install_file"
chmod +x "$install_file"
mv "$install_file" "$install_dir"

echo "The 'down' command has been installed in $install_dir"
echo "You can start using the 'down' command immediately."