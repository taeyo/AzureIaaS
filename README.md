# Azure IaaS 설계 시에 참고할만한 사항들

## [고 가용성을 위해서 검토해야 할 사항들](/HighAvailibity/)
## [VM을 마켓플레이스에 올리기 전에 점검해야 할 사항들](/Marketplace/)

## Azure VM을 FTP 서버로 활용하고 Azure File에 파일 저장하는 방법
1. Azure VM을 만들고 Windows 서버 설치
2. [Add Role]에서 Web Server 및 FTP 서버 설치
    - 참고 문서 : [Installing a Secure FTP Server on Windows using IIS](https://winscp.net/eng/docs/guide_windows_ftps_server)
    - ![iis_install_win2012](https://github.com/taeyo/AzureIaaS/blob/master/images/iis_install_win2012.png)
3. Azure VM의 NSG에 inbound Ruls 추가 (FTP, 21 포트 개방)
4. Azure VM의 NSG에 inbound Ruls 추가 (FTP 데이터 포트로 사용할 포트들 개방) 
    - 참고 : [VM의 NSG에 규칙 추가 스크립트(ps)](https://github.com/taeyo/TaeyoAzurePowerShell/blob/master/VM%EC%9D%98%20NSG%EC%97%90%20%EA%B7%9C%EC%B9%99%20%EC%B6%94%EA%B0%80%ED%95%98%EA%B8%B0.ps1)
5. RDP로 서버 VM에서 접속하고, Install-FTP.bat 파일을 실행하여 다음의 작업들을 한번에 수행
    - FTP 사이트를 새롭게 생성하고, 필요한 데이터 포트들을 개방하고, 방화벽을 조정하고, FTP 사이트의 파일 저장경로를 Azure File 저장소로 연결.
    - 매개변수 정보
        - FtpSiteName : 생성할 FTP 사이트 이름
        - StorageName :  Azure 저장소 계정명
        - StorageKey : Azure 저장소 액세스 키
        - ShareName : Azure File의 대상 file share 명(대상 폴더)
        - PublicPort : FTP 포트(21)
        - DynamicPortFirst : 데이터 포트로 사용할 포트(시작포트)
        - DynamicPortLast : 데이터 포트로 사용할 포트(끝포트)
        - PublicIP : 현재 서버의 공용 IP 주소
    - 실행 예시 : Install-FTP.bat FtpSvr1 jw1storage1ftp oX+rwzY== files 21 10000 10020 138.91.26.53
6. FTP Client([WinSCP](https://winscp.net/eng/docs/lang:ko) 등)으로 접근.
    
- 참고 문서
    - [Deploying a load-balanced, high-available FTP Server with Azure Files](http://fabriccontroller.net/deploying-a-load-balanced-high-available-ftp-server-with-azure-files/)  
    - [Installing Secure FTP Server on Microsoft Azure using IIS](https://winscp.net/eng/docs/guide_azure_ftps_server)    
    - [Step-By-Step: Creating a File Share in Azure](https://blogs.technet.microsoft.com/canitpro/2014/09/22/step-by-step-creating-a-file-share-in-azure/)    


