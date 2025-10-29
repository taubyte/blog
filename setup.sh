#!/bin/bash
# setup.sh - Automated Hugo installation script

set -e

HUGO_VERSION="0.152.2"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$SCRIPT_DIR/../bin"

echo "🚀 Setting up Hugo Blog..."

# Detect OS
detect_os() {
    case "$(uname -s)" in
        Linux*)     echo "linux";;
        Darwin*)    echo "macos";;
        CYGWIN*)    echo "windows";;
        MINGW*)     echo "windows";;
        *)          echo "unknown";;
    esac
}

# Detect architecture
detect_arch() {
    case "$(uname -m)" in
        x86_64)     echo "amd64";;
        arm64)      echo "arm64";;
        aarch64)    echo "arm64";;
        *)          echo "amd64";;
    esac
}

# Check if Hugo is already installed
check_hugo() {
    if command -v hugo &> /dev/null; then
        HUGO_VER=$(hugo version | grep -oP 'v\d+\.\d+\.\d+' | head -1)
        echo "✅ Hugo is already installed: $HUGO_VER"
        if [[ "$HUGO_VER" == "v${HUGO_VERSION}" ]]; then
            echo "✅ Version matches required version!"
            return 0
        else
            echo "⚠️  Version mismatch. Required: v${HUGO_VERSION}, Found: $HUGO_VER"
            echo "   Consider updating or installing locally."
        fi
    fi
    
    # Check local binary
    if [ -f "$BIN_DIR/hugo" ] || [ -f "$BIN_DIR/hugo.exe" ]; then
        echo "✅ Local Hugo binary found in bin/"
        return 0
    fi
    
    return 1
}

# Install Hugo locally
install_hugo_local() {
    OS=$(detect_os)
    ARCH=$(detect_arch)
    
    echo "📦 Installing Hugo Extended v${HUGO_VERSION} locally..."
    
    mkdir -p "$BIN_DIR"
    cd "$SCRIPT_DIR/.."
    
    case "$OS" in
        linux)
            URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${ARCH}.tar.gz"
            curl -L "$URL" -o /tmp/hugo.tar.gz
            tar -xzf /tmp/hugo.tar.gz -C "$BIN_DIR" hugo
            chmod +x "$BIN_DIR/hugo"
            rm /tmp/hugo.tar.gz
            ;;
        macos)
            if [ "$ARCH" = "arm64" ]; then
                URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_darwin-arm64.tar.gz"
            else
                URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_darwin-universal.tar.gz"
            fi
            curl -L "$URL" -o /tmp/hugo.tar.gz
            tar -xzf /tmp/hugo.tar.gz -C "$BIN_DIR" hugo
            chmod +x "$BIN_DIR/hugo"
            rm /tmp/hugo.tar.gz
            ;;
        windows)
            URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_windows-${ARCH}.zip"
            echo "⚠️  Windows detected. Please download manually:"
            echo "   $URL"
            echo "   Extract hugo.exe to: $BIN_DIR"
            return 1
            ;;
        *)
            echo "❌ Unsupported OS: $OS"
            return 1
            ;;
    esac
    
    echo "✅ Hugo installed successfully!"
    "$BIN_DIR/hugo" version
}

# Main setup
main() {
    cd "$SCRIPT_DIR"
    
    if check_hugo; then
        echo ""
        echo "✅ Setup complete! You can start the server with:"
        echo "   make server"
        echo "   or"
        echo "   ./scripts/server.sh"
        exit 0
    fi
    
    echo ""
    echo "📥 Installing Hugo..."
    if install_hugo_local; then
        echo ""
        echo "✅ Setup complete! You can start the server with:"
        echo "   make server"
        echo "   or"
        echo "   ./scripts/server.sh"
    else
        echo ""
        echo "❌ Setup failed. Please install Hugo manually."
        echo "   See README.md for manual installation instructions."
        exit 1
    fi
}

main

