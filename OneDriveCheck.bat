@echo OFF

setlocal ENABLEEXTENSIONS
set keyName="HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
set valueDesktop=Startup
set valueDocuments=Personal

FOR /F "usebackq tokens=1-3" %%A IN (`REG QUERY %keyName% /v %valueDesktop% 2^>nul`) DO (
    set DesktopName=%%A
    set DesktopType=%%B
    set DesktopValue=%%C
)

FOR /F "usebackq tokens=1-3" %%A IN (`REG QUERY %keyName% /v %valueDocuments% 2^>nul`) DO (
    set DocumentsName=%%A
    set DocumentsType=%%B
    set DocumentsValue=%%C
)

if defined DesktopName (
    if x%DesktopValue:OneDrive=%==x%DesktopValue% echo Desktop redirect for OneDrive is not setup correctly for user %USERNAME% on Computer %COMPUTERNAME% >> \\corpmanagement1\OneDriveCheck$\OneDriveUsers.txt
) else (
    @echo %keyName%\%valueDesktop% not found.
)

if defined DocumentsName (
    if x%DocumentsValue:OneDrive=%==x%DocumentsValue% echo Documents redirect for OneDrive is not setup correctly for user %USERNAME% on Computer %COMPUTERNAME% >> \\corpmanagement1\OneDriveCheck$\OneDriveUsers.txt
) else (
    @echo %keyName%\%valueDocuments% not found.
)