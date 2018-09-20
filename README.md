# pace-vscode
This is a guide to help you set up a remote development environment for CPP programs on Pace.
I've only tried this on a macOS High Sierra. You can loosely follow this guide if you have a different OS.
## GDB
If you have GDB set up then skip this part.

I got LLDB to remote debug fine on the command line but haven't got it to work with VSCode yet. [This](https://github.com/vadimcn/vscode-lldb) seemed promissing though.

 1. Install GDB 8.0.1 with Homebrew

	`brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/9ec9fb27a33698fc7636afce5c1c16787e9ce3f3/Formula/gdb.rb --with-all-targets`

	*Very important to add the `--with-all-targets` tag here so that GDB can attach to different systems (e.g. GNU linux for pace). This took ~11 min on my machine so be patient.*

	*Do not use the most recent GDB as it is still not compatiple with High Sierra as of the time of this post.*
 2. Codesign it. [Instructions](https://gist.github.com/hlissner/898b7dfc0a3b63824a70e15cd0180154)
 3. Update `.gdbinit`

	`` echo "set startup-with-shell off" >> ~/.gdbinit``

## VSCode
1. Install extension `C/C++`

## PACE
1. Mount your workspace(e.g. project1) on Pace locally somewhere(e.g. pace)
`sshfs username@coc-ice.pace.gatech.edu:project1 ./pace`
2. Open the mounted folder locally using VSCode. `code pace` if you've added VSCode to your path
3. Create folders and files using VSCode. Follow the folder structure in this repo and write some code
4. Put the `launch.json` and `tasks.json` under you `.vscode` folder. Change `executable` to the path of your shell (e.g. `which bash` or `which zsh`) 

## Build and Run
1. Once you've configured the build with Cmake, modify the `cmake.sh` to load the desired modules. Then hit `shift-cmd-B` to generate a build.
    *Put `set(CMAKE_BUILD_TYPE Debug)` in your `CMakeLists.txt` during debug.*

2.  Set a break point. Start debugging(`F5`) and ignore the pop-up saying the task cannot be tracked and hit debug anyway. The debug console should start writing out messages. Wait for it to finish and voila!

	`pace.sh` will use ssh to port forward 9091 on pace to your local 9091, compile your executable and start GDBServer. If you don't have ssh key set up, it will prompt for your password in the built-in terminal. Change to an external one by modifying `"externalConsole": false` in `launch.json`. Also you should [make an ssh key](https://serverfault.com/questions/241588/how-to-automate-ssh-login-with-password).

3. Don't forget to terminate the debug process at the end

## Ackowledgement
This guide is largely based on the very detailed [post by Spencer Elliot.](https://medium.com/@spe_/debugging-c-c-programs-remotely-using-visual-studio-code-and-gdbserver-559d3434fb78)
