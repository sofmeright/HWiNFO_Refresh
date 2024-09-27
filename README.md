Kai of <a href="https://precisionplanit.com">PrecisionPlanIT.com</a> presents:

# Virtual Here Client - Free Initializer
> A very simple script with the purpose of launching Virtual Here via CMD/CLI for use with Sunshine, Task Scheduler at boot, etc. When I tried to run Virtual Here directly from Sunshine commands in the Web UI, I was met with dissapointment that my Moonlight client would try to connect for a long time before failing. This could have easily been accomplished with a .bat file, yet I already had .ahk code written for another script.

### Features:
- Load Virtual Here at boot via Task Scheduler, on remote connection via Sunshine commands, or other methods; so you can bind usb devices directly to the client from the server. It's really simple!

### CMD/CLI Arguements:
Triggers Client_Start launched via script without arguments or executing directly.
> "C:\<pathto>\VH_Manage.ahk"[/.exe]
Exits the client.
> "C:\<pathto>\VH_Manage.ahk"[/.exe] Client_Exit
Starts the client. Filename is optional otherwise the client exe is expected to be in the same folder as the script.
> "C:\<pathto>\VH_Manage.ahk"[/.exe] Client_Start <filename>
Toggles the Server. Filename is optional otherwise the server exe is expected to be in the same folder as the script.
> "C:\<pathto>\VH_Manage.ahk"[/.exe] Server_Toggle <filename>

# Installation:
1. Unpack the .exe or the .ahk source file into the folder (optionally where you store the Virtual Here Client executable ~ vhui64.exe). Note: If you wish to use the ".ahk" file (plain-text source code), you must install [Autohotkey](https://www.autohotkey.com).
2. Set up a task in task scheduler or a command in the Sunshine WebUI to run the script.
> Extra Credit: To setup the VH Server as a service that runs at boot you can run "VH_Server-install_uninstall.exe" from the same folder that contains the server executable.

### Notes / Hints:
> This software is intended to make it a smoother experience while you are testing out Virtual Here as a solution for mounting USB devices on your machine to a different PC. The developer of Virtual Here deserves to get paid for their work, buying a license also will enable you to use up to 63 devices. This script is not a substitute for a license by any means. I encourage you to purchase a license if you like the product.

### Integrating the tool with Sunshine:

<img src="https://github.com/sofmeright/IDDSampleDriver_Wizard/blob/main/PPIT-IddSample_Wiz-SS_Sunshine_Integration.png" width="300" />

> # Example:
> cmd /C "C:\_Staging\_Staging\VirtualHere\VH_Client-FreeInit.ahk"

- For some strange reason its possible to execute the Virtual Here Client with a .bat but not directly from Sunshine and it is not a syntax issue as we are effectively doing the same thing with the script. I do not know the cause of this.
- Make sure to check the config.elevated option, admin is needed to launch Virtual Here, the tool will not run w/o elevation.
- Point the sunshine command to the "VH_Client-FreeInit.ahk", that's all.

### Current Issues / Workarounds:
- I don't think so.

### Planned Features:
> Nope.

### Dependencies / Requirements:
> This software seeks to launch Virtual Here as such you *obviously* would need Virtual Here. [Virtual Here Server](https://www.virtualhere.com/windows_server_software) & [Virtual Here Client](https://www.virtualhere.com/usb_client_software)

> This was written 100% with [Autohotkey](https://www.autohotkey.com), I first touched [Autohotkey](https://www.autohotkey.com) in 2010 or so. Why AutoHotkey? [Autohotkey](https://www.autohotkey.com) is super easy and efficient to carry out simple tasks programatically. I don't feel the need to pull out a more sophisticated language, honestly. In every release (I don't think there will ever be a new release of this 🤣) there is a ".ahk" plain-text source file, that you can inspect and even make changes. If you install [Autohotkey](https://www.autohotkey.com) you will be able to execute the source code directly.

 >If you do not like AutoHotkey... You are most entitled to that opinion, I encourage you to move right along and carry out this task however else you want. Otherwise as Deadpool said, MAXIMUM EFFORT!!! 🥴 AutoHotkey it is! 🤣

### Disclaimer: 
> The Software provided hereunder ("Software") is licensed "as-is," without warranties of any kind, express or implied. The Softwarer makes no representations regarding the functionality, performance, compatibility, security, or availability of the Software and no warranty. The developer should not be held responsible even if it blatantly be the cause of your dog running off and joining a circus, or your mother wins 5 tickets to Hawaii but you get stuck on a gaming bender and pass it up. The developer should not be held responsible if use of the Virual Display Driver causes you to spend longer hours on the PC and you muff up at your workplace. The developer should equally not be accredited with any responsibility for your experience using this software. All thanks is to those in development of the drivers and their forks, and the OpenSource communities! It's never been a better time than now to be a PC user!
