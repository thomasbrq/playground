#!/bin/sh

shopt -s expand_aliases

case "$OSTYPE" in
  darwin*)  alias love="love/macos/love.app/Contents/MacOS/love" ;; 
  msys*)    alias love="love/win/love.exe" ;;
  cygwin*)  alias love="love/win/love.exe" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

love .