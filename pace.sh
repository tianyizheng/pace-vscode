# Kill gdbserver if it's running
ssh username@coc-ice.pace.gatech.edu killall gdbserver &> /dev/null

# Compile se1 and launch gdbserver, listening on port 9091
ssh \
  -L9091:localhost:9091 \
  username@coc-ice.pace.gatech.edu \
  "zsh -l -c 'cd project1/build && make && cd .. && gdbserver :9091 ./build/executable1'"