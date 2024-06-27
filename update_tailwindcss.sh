#!/bin/bash
CURRENT_TAILWINDCSS_VERSION=$(ls 2>/dev/null tailwindcss-v* | head -1)
LASTEST_TAILWINDCSS_VERSION=$(curl -s "https://api.github.com/repos/tailwindlabs/tailwindcss/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
if [ "$CURRENT_TAILWINDCSS_VERSION" == "tailwindcss-v$LASTEST_TAILWINDCSS_VERSION" ]; then
   echo -e "\033[0;33mNothing to do!"
else
  curl -sLo tailwindcss-v$LASTEST_TAILWINDCSS_VERSION https://github.com/tailwindlabs/tailwindcss/releases/download/v$LASTEST_TAILWINDCSS_VERSION/tailwindcss-linux-x64
  chmod u+x tailwindcss-v$LASTEST_TAILWINDCSS_VERSION
  [ ! -z "$CURRENT_TAILWINDCSS_VERSION" ] && rm $CURRENT_TAILWINDCSS_VERSION
  echo -e "\033[0;32mSay hello to Tailwind CSS v$LASTEST_TAILWINDCSS_VERSION!"
fi
