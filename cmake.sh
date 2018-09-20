# Load module and cmake

ssh \
  username@coc-ice.pace.gatech.edu \
  "zsh -l -c 'module load gcc/7.3.0 && module load cmake/3.9.1 && cd project1/build && cmake ..'"