' VBScript to re-enable Task Manager and Registry Tools

Set WshShell = CreateObject("WScript.Shell")

On Error Resume Next

' Re-enable Task Manager
WshShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System\DisableTaskMgr", 0, "REG_DWORD"

' Re-enable Registry Editor and reg.exe
WshShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System\DisableRegistryTools", 0, "REG_DWORD"

On Error Goto 0

WScript.Echo "✅ Task Manager and Registry Editor have been re-enabled. Restart Explorer or reboot for changes to take effect."