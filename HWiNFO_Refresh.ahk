;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <[email protected]>
;
; Script Function:
; Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
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
			MsgBox, , SoFMeRight's HWiNFO64 Tool Requires Admin, Note this script may need to be ran as admin so that it can successfully stop HWiNFO64.exe., 5
			; Permissions escalation:
			RequestAdminSelf()
		}
;------------------------------------------------------------------------------------------
; First Run
HWiNFO64Start()
;------------------------------------------------------------------------------------------
Loop
	{
		If HWiNFO64PID() != 0
			{
				; MsgBox, , HWiNFO64 Process Found, HWiNFO64 is currently running with PID: %ErrorLevel%. Restarting HWiNFO64 to refresh Shared Memory Support., 2
				If HWiNFO64Kill() != 0
					{
						; MsgBox, % "HWiNFO64.exe was terminated. (PID: " . ErrorLevel . ")"
						HWiNFO64Start()
					}
					Else
					{
						MsgBox, , HWiNFO64 Termination Error, HWiNFO64 process refused to be terminated. Did you enable admin for this process?, 5
					}
			}
			Else
				{
					MsgBox, 4, SoFMeRight's HWiNFO64 Tool, HWiNFO64 is not running, user may have closed it manually. Would you like to restart HWiNFO64?
					IfMsgBox Yes
						HWiNFO64Start()
						else
							{
								; MsgBox SoFMeRight's HWiNFO64 Tool is paused. To resume dismiss this message.
								ExitApp
							}
				}
		; MsgBox, % "Sleeping for " . GetMillisecondsForHours(11) + GetMillisecondsForMins(58) . " ms."
		Sleep, % GetMillisecondsForHours(11) + GetMillisecondsForMins(58)
	}
Return

;------------------------------------------------------------------------------------------
; Functions Section:
;------------------------------------------------------------------------------------------
HWiNFO64PID()
	{
		Process, Exist, HWiNFO64.EXE
		Return %ErrorLevel%
	}
HWiNFO64Kill()
	{
		Process, Close, % HWiNFO64PID()
		Return %ErrorLevel%
	}
HWiNFO64Start()
	{
		Run *RunAs C:\Program Files\HWiNFO64\HWiNFO64.EXE
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
		return IsElevated, DllCall("CloseHandle", "ptr", hToken) && DllCall("CloseHandle", "ptr", hProcess)
	}
RequestAdminSelf()
	{
		if A_IsCompiled
			Run *RunAs "%A_ScriptFullPath%" /restart
			else
				Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
	}
GetMillisecondsForMins(minutes)
	{
		return minutes * 60000
	}
GetMillisecondsForHours(hours)
	{
		return hours * 60 * 60000
	}