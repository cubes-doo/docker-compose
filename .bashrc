# Set terminal (TTY) matrix width/height
export COLUMNS=1024
export LINES=50

# PHP artisan command aliases
alias quelis='php /opt/artisan queue:listen database --tries=1';
alias quelisb='echo "laravel queue listen is running as a background process. Press enter to continue..." && quelis &';
alias cronsim='watch -n 60 php /opt/artisan schedule:run 2>/dev/null || echo "you must install watch command (apt install watch)" '
