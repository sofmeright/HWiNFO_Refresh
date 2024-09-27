;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <[email protected]>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;------------------------------------------------------------------------------------------
#SingleInstance Force
;------------------------------------------------------------------------------------------
; Admin Check:
;-------------
If IsProcessElevated(DllCall("GetCurrentProcessId")) 
	{
		; MsgBox, Congrats this script is running as admin.
	}
	Else 
		{
			MsgBox, , SoFMeRight's VirtualHere Tool Requires Admin, Note this script may need to be ran as admin so that it can successfully start VirtualHere.exe., 5
			; Permissions escalation:
			RequestAdminSelf()
		}
;------------------------------------------------------------------------------------------
; First Run
for n, param in A_Args  ; For each parameter:
	{
		if n = 1
			Exec_Inte := param
		else if n = 2
			Exec_Args := Exec_Args
		else if n = 3
			ExitApp
	}
	if A_Args.Length() = 0
		{
			; MsgBox % "This executable has been launched without arguements."
			VirtualHereStart()
			ExitApp
		}
		else if (A_Args.Length() = 1) or (A_Args.Length() = 2)
			{
				; "Client_Exit"
				; "Client_Start" <filename>
				; "Server_Toggle" <filename>
				; Filename is optional.
				if (Exec_Inte = "Client_Exit")
					{
						VirtualHereStop()
					}
				else if (Exec_Inte = "Client_Start")
					{
						VirtualHereStart(Exec_Args)
					}
				else if (Exec_Inte = "Server_Toggle")
					{
						VirtualHereServer(Exec_Args)
					}
				else ExitApp
			}
;------------------------------------------------------------------------------------------
ExitApp




;------------------------------------------------------------------------------------------
; Functions Section:
;------------------------------------------------------------------------------------------
VirtualHerePID()
	{
		Process, Exist, vhui64.exe
		Return %ErrorLevel%
	}
VirtualHereStop()
{
	Process, Close, % VirtualHerePID()
	Return %ErrorLevel%
}
VirtualHereStart(filename:="")
{
	if (filename = "")
		filename := A_WorkingDir . "\vhui64.exe"
	Run *RunAs %filename%
	Return %ErrorLevel%
}
VirtualHereServer(filename:="%A_WorkingDir%\vhui64.exe")
{
	if (filename = "")
		filename := A_WorkingDir . "\vhusbdwin64.exe -b"
	Run *RunAs %filename%
	Return %ErrorLevel%
}
IsProcessElevated(ProcessID)
{
    if !(hProcess := DllCall("OpenProcess", "uint", 0x1000, "int", 0, "uint", ProcessID, "ptr"))
        throw Exception("OpenProcess failed", -1)
    if !(DllCall("advapi32\OpenProcessToken", "ptr", hProcess, "uint", 0x0008, "ptr*", hToken))
        throw Exception("OpenProcessToken failed", -1), DllCall("CloseHandle", "ptr", hProcess)
    if !(DllCall("advapi32\GetTokenInformation", "ptr", hToken, "int", 20, "uint*", IsElevated, "uint", 4, "uint*", size))
        throw Exception("GetTokenInformation failed", -1), DllCall("CloseHandle", "ptr", hToken) && DllCall("CloseHandle", "ptr", hProcess)
	Sleep, 100
    return IsElevated, DllCall("CloseHandle", "ptr", hToken) && DllCall("CloseHandle", "ptr", hProcess)
			
}
RequestAdminSelf()
{
	if A_IsCompiled
			Run *RunAs "%A_ScriptFullPath%" /restart
	else
			Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
}