# Set terminal (TTY) matrix width/height
export COLUMNS=1024
export LINES=50

shopt -s expand_aliases

# PHP artisan command aliases
alias quelis='php /opt/artisan queue:listen database --tries=1';
alias quelisb='echo "laravel queue listen is running as a background process. Press enter to continue..." && quelis &';
alias cronsim='watch -n 60 php /opt/artisan schedule:run 2>/dev/null || echo "watch command nonexistant (deb package procps)"';

# play sound aliases (you must have these audio files in 'files' directory)
alias success_sound='aplay /home/localuser/files/audio/job_finished.wav';
alias error_sound='aplay /home/localuser/files/audio/cant_build.wav';
