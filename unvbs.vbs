' EnableRegedit.vbs
' This script re-enables the Registry Editor by changing the DisableRegistryTools value in the registry.

On Error Resume Next

Dim WshShell
Set WshShell = CreateObject("WScript.Shell")

' Path to the policy key
Dim regPath
regPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System\"

' Delete the value that disables regedit (if it exists)
WshShell.RegDelete regPath & "DisableRegistryTools"

If Err.Number = 0 Then
    MsgBox "Registry Editor has been re-enabled.", vbInformation, "Success"
Else
    MsgBox "Failed to re-enable Registry Editor. You may need to run this script as administrator.", vbCritical, "Error"
End If

Set WshShell = Nothing
