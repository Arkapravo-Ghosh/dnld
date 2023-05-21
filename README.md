# down
down is an Instagram Video Downloader for Termux
> Source Code: [Click Here](src/main.sh)
## Prerequisites
- Termux
- Python 3.7 or higher with pip
- yt-dlp
- exiftool
- ffmpeg
- termux-tools
## Installation
### Install Dependencies
```bash
apt update && apt full-upgrade -y && apt install -y python ffmpeg exiftool termux-tools && pip install -U pip && pip install yt-dlp
```
### Setup storage
```bash
termux-setup-storage
```
### Install down
```bash
curl -sSL https://raw.githubusercontent.com/Arkapravo-Ghosh/down/main/install.sh | bash
```
## Usage
```bash
down -h
```
> NOTE: You can simply run `down` to download a video from Instagram or YouTube. It'll automatically prompt you to enter the URL of the video you want to download.
