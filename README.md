# pace-vscode
How to remote debug using VSCode, GDB on MacOS
## GDB
I got LLDB to remote debug fine on the command line but haven't got it to work with VSCode yet. [This](https://github.com/vadimcn/vscode-lldb) seemed promissing though.

 1. Install GDB 8.0.1 with Homebrew

	`brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/9ec9fb27a33698fc7636afce5c1c16787e9ce3f3/Formula/gdb.rb --with-all-targets`

	*Very important to add the `--with-all-targets` tag here so that GDB can attach to different systems (e.g. GNU linux for pace). This took ~11 min on my machine so be patient.*

	*Do not use the most recent GDB as it is still not compatiple with High Sierra as of the time of this post*
 2. Codesign it. [Instructions Here.](https://gist.github.com/hlissner/898b7dfc0a3b63824a70e15cd0180154)
 3. Update `.gdbinit`

	`` echo "set startup-with-shell off" >> ~/.gdbinit``

## VSCode
1. Install extension `C/C++`.
2. Put the `launch.json` and `tasks.json` under you `.vscode` folder
3. Put `pace.sh` in your workspace folder. Change the executable file paths(`~/se1/build/se1`) according to your folder structure.

This will use ssh to port forward 9091 on pace to your local 9091 and start GDBServer, which will listen for a conection. If you don't have ssh key set up, it will prompt for your password in the built-in terminal. Change to an external one by modifying `"externalConsole": false` in `launch.json`. Also you should [make an ssh key](https://serverfault.com/questions/241588/how-to-automate-ssh-login-with-password).
## Run
1. Assuming you have a executable file ready. Mount your workspace on Pace locally somewhere
`sshfs username@coc-ice.pace.gatech.edu:se1 ./pace`
2. Open your workspace in VSCode. Make sure you are outside the build folder. I've had problem with gdb saying cannot find main.cpp before because it wasn't inside the path. Start debugging and ignore the pop-up saying the task cannot be tracked and hit debug anyway. The debug console should start writing out messages. Wait for it to finish and voila!
3. Don't forget to terminate the debug process at the end.
