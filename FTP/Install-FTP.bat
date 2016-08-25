REM Variables.  
SETLOCAL EnableDelayedExpansion  
SET FtpSiteName=%1%
SET StorageName=%2%
SET StorageKey=%3%
SET ShareName=%4%
SET PublicPort=%5%
SET DynamicPortFirst=%6%
SET DynamicPortLast=%7%
SET PublicIP=%8%

REM Install FTP.
START /w pkgmgr /iu:IIS-WebServerRole;IIS-FTPSvc;IIS-FTPServer;IIS-ManagementConsole

REM Add user.
net user %StorageName% /delete
net user %StorageName% %StorageKey%== /add

REM Configuring FTP site.
pushd %windir%\system32\inetsrv
appcmd add site /name:%FtpSiteName% /bindings:ftp://*:%PublicPort% /physicalpath:"\\%StorageName%.file.core.windows.net\%ShareName%"
appcmd set vdir /vdir.name:"%FtpSiteName%/" /userName:%StorageName% /password:%StorageKey%==
appcmd set config -section:system.applicationHost/sites /[name='%FtpSiteName%'].ftpServer.security.ssl.controlChannelPolicy:"SslAllow"
appcmd set config -section:system.applicationHost/sites /[name='%FtpSiteName%'].ftpServer.security.ssl.dataChannelPolicy:"SslAllow"
appcmd set config -section:system.applicationHost/sites /[name='%FtpSiteName%'].ftpServer.security.authentication.basicAuthentication.enabled:true
appcmd set config %FtpSiteName% /section:system.ftpserver/security/authorization /-[users='*'] /commit:apphost
appcmd set config %FtpSiteName% /section:system.ftpserver/security/authorization /+[accessType='Allow',permissions='Read,Write',roles='',users='*'] /commit:apphost
appcmd set config /section:system.ftpServer/firewallSupport /lowDataChannelPort:%DynamicPortFirst% /highDataChannelPort:%DynamicPortLast%
appcmd set config -section:system.applicationHost/sites /siteDefaults.ftpServer.firewallSupport.externalIp4Address:"%PublicIP%" /commit:apphost

REM Configure firewall.
netsh advfirewall firewall add rule name="FTP Public Port" dir=in action=allow protocol=TCP localport=%PublicPort%
netsh advfirewall firewall add rule name="FTP Passive Dynamic Ports" dir=in action=allow protocol=TCP localport=%DynamicPortFirst%-%DynamicPortLast%

REM Restart the FTP service.
net stop ftpsvc

net start ftpsvc