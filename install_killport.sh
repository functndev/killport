#!/bin/bash

KILLPORT_FUNCTION='https://raw.githubusercontent.com/functndev/killport/main/killport.sh'

echo -e "🛠️ Installing killport function..."

download_and_append() {
    if [ "$1" == "bash" ]; then
        config_file="~/.bashrc"
    elif [ "$1" == "zsh" ]; then
        config_file="~/.zshrc"
    fi

    if command -v curl > /dev/null; then
        curl -s "$KILLPORT_FUNCTION" >> $config_file
        echo -e "✅ Successfully installed to $config_file using curl!"
    elif command -v wget > /dev/null; then
        wget -qO- "$KILLPORT_FUNCTION" >> $config_file
        echo -e "✅  Successfully installed to $config_file using wget!"
    else
        echo -e "🚨 Error: You need curl or wget installed to download the function."
        exit 1
    fi
}

if [[ "$SHELL" == *"zsh"* ]]; then
    download_and_append "zsh"
elif [[ "$SHELL" == *"bash"* ]]; then
    download_and_append "bash"
else
    echo -e "🚨 Error: Unsupported shell detected. Only bash and zsh are supported."
    exit 1
fi

echo -e "🎉 Installation complete. Please restart your terminal or source your shell configuration."

