## Azure VM을 FTP 서버로 활용하고 Azure File에 파일 저장하는 방법

장점 : 
- 여러 대의 FTP 서버를 운영하면서 단일 위치를 공용 저장소로 활용할 수 있다.
- 각 FTP 서버마다 데이터 디스크를 보유할 필요가 없다.

단점 : 
- Azure File은 저장소 계정 당 최대 5 TB 까지만 지원한다. 

구성 예

![Ftp-Arch](https://github.com/taeyo/AzureIaaS/blob/master/images/ftp-arch.png)

구성 순서   

1. Azure VM을 만들고 Windows 서버 설치
2. RDP로 서버에 접속하여 [Add Role]에서 Web Server 및 FTP 서버 설치
    - 참고 문서 : [Installing a Secure FTP Server on Windows using IIS](https://winscp.net/eng/docs/guide_windows_ftps_server)
    
    ![iis_install_win2012](https://github.com/taeyo/AzureIaaS/blob/master/images/iis_install_win2012.png)

3. Azure VM의 NSG에 inbound Ruls 추가 (FTP, 21 포트 개방)
4. Azure VM의 NSG에 inbound Ruls 추가 (FTP 데이터 포트로 사용할 포트들 개방)  

    ![ftp-data-port-open.png](https://github.com/taeyo/AzureIaaS/blob/master/images/ftp-data-port-open.png)

    - 참고 : [VM의 NSG에 규칙 추가 스크립트(ps)](https://github.com/taeyo/TaeyoAzurePowerShell/blob/master/VM%EC%9D%98%20NSG%EC%97%90%20%EA%B7%9C%EC%B9%99%20%EC%B6%94%EA%B0%80%ED%95%98%EA%B8%B0.ps1)
5. RDP로 서버 VM에서 접속하고, [Install-FTP.bat](https://github.com/taeyo/AzureIaaS/blob/master/FTP/Install-FTP.bat) 파일을 실행하여 다음의 작업들을 한번에 수행
    - 이 bat 파일을 사용하지 않는다면 다음의 작업을 수동으로 직접 해주어야 한다.
        - FTP 사이트를 새롭게 생성하고, 
        - 필요한 데이터 포트들을 개방하고, 
        - 방화벽을 조정하고, 
        - FTP 사이트의 파일 저장경로를 Azure File 저장소로 연결 등
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
6. 인터넷 서비스 관리자(inetmgr)을 실행해서 FTP 설정들을 확인
    - 데이터 포트와 IP 설정 확인

    ![ftp-set1](https://github.com/taeyo/AzureIaaS/blob/master/images/ftp-set1.png)

    - Azure File과의 매핑이 잘 되어 있는지 확인  

    ![ftp-set2](https://github.com/taeyo/AzureIaaS/blob/master/images/ftp-set2.png)

6. FTP Client([WinSCP](https://winscp.net/eng/docs/lang:ko) 등)으로 접근.

### Tip

2대 이상의 VM으로 FTP 서버들의 부하분산을 구성하려는 경우에는 Passive FTP의 상태로는 이를 부하 분산시키면서 올바르게 동작시킬 명확한 해법이 없기 때문에, 일종의 편법으로 반드시 데이터 포트 범위를 각기 달리 줘야 한다.

예 >
> ftpSvr1: port 21, port range 10000-10020  
> ftpSvr2: port 21, port range 20000-20020

### 참고 문서
- [Deploying a load-balanced, high-available FTP Server with Azure Files](http://fabriccontroller.net/deploying-a-load-balanced-high-available-ftp-server-with-azure-files/)  
- [Installing Secure FTP Server on Microsoft Azure using IIS](https://winscp.net/eng/docs/guide_azure_ftps_server)    
- [Step-By-Step: Creating a File Share in Azure](https://blogs.technet.microsoft.com/canitpro/2014/09/22/step-by-step-creating-a-file-share-in-azure/)    


