# Down
down is an Instagram Video Downloader for Termux
> Source Code: [Click Here](src/main.sh)

## Demo
<div align=center>
<img src="docs/images/demo.png" width="1000px" alt="Demo">
</div>

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
> NOTE: To update, use this command again.

## Usage
```bash
down -h
```
> NOTE: You can simply run `down` to download a video from Instagram or YouTube. It'll automatically prompt you to enter the URL of the video you want to download.