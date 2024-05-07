#!/bin/bash

display_help() {
    echo "Usage: $(basename "$0") [OPTIONS]"
    echo "Options:"
    echo "  -h, --help       Display this help message"
    echo "  -u, --url URL    Specify the share URL of the video"
    echo ""
    echo "down v1.0.5 Made by Arkapravo Ghosh"
}

download_video() {
    video_url="$1"
    download_dir="$HOME/downloads"
    mkdir -p "$download_dir"

    if [[ $video_url == *"instagram.com"* ]]; then
        video_url=$(yt-dlp --no-playlist --get-url "$1")
        if [[ -n $video_url ]]; then
            filename=$(basename "$video_url" | cut -d'?' -f1)
            wget -O "$download_dir/$filename" "$video_url"
            if command -v exiftool &>/dev/null; then
                exiftool -overwrite_original -FileModifyDate="$(date +"%Y:%m:%d %H:%M:%S")" "$download_dir/$filename"
            fi
            echo "Video downloaded successfully: $download_dir/$filename"
        else
            echo "Failed to retrieve video URL."
            exit 1
        fi
    elif [[ $video_url == *"youtube.com"* ]] || [[ $video_url == *"youtu.be"* ]]; then
        yt-dlp --merge-output-format mp4 -f "bestvideo+bestaudio[ext=m4a]/best" -o "$download_dir/%(title)s.%(ext)s" "$1"
        echo "Video downloaded successfully to $download_dir"
    else
        echo "Unsupported URL domain."
        exit 1
    fi
}

check_dependency() {
    if ! command -v "$1" &>/dev/null; then
        echo "$1 is not installed. Please install it and try again."
        exit 1
    fi
}

if [[ $1 == "-h" || $1 == "--help" ]]; then
    display_help
    exit 0
fi

# Check for dependencies
check_dependency yt-dlp
check_dependency wget

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -u|--url)
            share_url="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            display_help
            exit 1
            ;;
    esac
done

if [[ -z $share_url ]]; then
    read -p "Enter URL: " share_url
fi

download_video "$share_url"