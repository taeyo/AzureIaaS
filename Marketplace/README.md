# VM을 마켓플레이스에 올리기 전에 점검해야 할 사항들

대외 판매용으로 자사의 솔루션이 탑재된 VM을 Azure 마켓플레이스에 등록하려면, 우선 적절한 과정을 거쳐서 VM을 만들고 이미지화 해야할 뿐만 아니라
Azure에 구성해 둔 VM이 올바로 구성되었는 지를 검증하기 위해서 테스트 도구를 사용하여 검사를 수행해야 한다. 테스트 도구는 다음 경로에서 다운로드 할 수 있다.

[Certification Test Tool for Azure Certified](https://www.microsoft.com/en-us/download/details.aspx?id=44299&wa=wsignin1.0)

테스트 도구는 중간 점검 중에 다음과 같은 부분을 준수했는지 물어오는데 모든 부분에 Yes를 선택하지 않으면 검사를 통과할 수 없다.
그러므로, 하단의 내용은 반드시 사전에 점검해 두어야 하는 필수 조건이라 할 수 있다.

## Windows 서버의 사전 조건

> 1. The application to be described in the Publisher Portal matches the application included in the Virtual Machine and was tested for primary functionality after deployment of the VM image in Microsoft Azure. 
> 2. The application does not include third party software. If it does, publisher is in compliance with its redistribution licensing. 
> 3. The application does not have dependency on software not included in the virtual machine. If it does, proper information should be available for customer to complete the deployment. 
> 4. The VHD image was prepared with the SYSPREP command. 
> 5. If the VM image includes SQL Server a) ‘NT AUTHORITY\SYSTEM’ is added to SQL sysadmin role. b) Before creating the VM image, it is Verified that all Organization\Personal login accounts present in the SQL image has been removed. 
> 6. While additional configuration steps may be required by the application, deployment of the VM image allows the VM to fully be provisionned and the OS to start properly. 
> 7. The application minimum requirement for number of virtual cores can be met by Azure Virtual Machines options. 
> 8. The application minimum requirement for RAM can be met by Azure Virtual Machines options. 
> 9. All the latest security patches are installed. 
> 10. The VHD image only includes necessary locked accounts, that do not have default password that would allow interactive login, no back door. 
> 11. Azure virtual machines may have different Input/Output Operations per Second (IOPS) capabilities than on-premises implementations and can vary with VM size and number of disks.The application was tested to perform well in an Azure VM. 
> 12. The Application Deployment Guide includes recommendation for deployment in high availability and Disaster recovery scenarios. 
> 13. Application does not have dependency on D: drive for persistent data. Azure offers D: drive as temporary storage only and data could be lost. 
> 14. Application usage of data drive does not have dependency on C: or D: drive letter designations. Azure reserves C: and D: drive letter designations. 
> 15. The application does not require SSD based drives. Azure Virtual machines currently does not offer VM with Solid State Drives (SSD). 
> 16. Application does not have dependency on BitLocker Encryption on the operating system hard disk, may be used on data disks. 
> 17. The application networking requirements of high bandwidth are documented as appropriate, if needed, including recommendation for usage of VM size A8 and A9 supporting high-bandwidth scenarios. 
> 18. The application is in compliance with Microsoft Software Licensing and Redistribution. Software Licensing compliance requires not to install the Microsoft applications such as Exchange, SQL Server, SharePoint, Lync, System Center and Dynamics CRM etc. 
> 19. Application does not have dependency to use more than one NIC, one IP address. Azure Virtual machines currently support a maximum of one Network Controller Card (NIC) and one IP address per NIC. 
> 20. Application does not require Multicast or Broadcast networking proptocols. Azure Virtual machines currently not support Multicast or Broadcast protocols. 
> 21. The application offer can be deployed in an environment where network throttling is enabled. 
> 22. The application offer uptime SLA is in accordance with Azure VM service SLA. Azure offers a an SLA of 99.95% that can be met with High Availability deployment options such as grouping virtual machines in an Availability Set. 
> 23. The application offer can be deployed in any Azure datacenter worldwide.  
     

## Linux 서버의 사전 조건

> 1. The application described in the Publisher Portal does match the application included in the Virtual Machine and was tested for primary functionality after deployment of the VM image in Microsoft Azure.
> 2. The application does not include third party software. If it does, publisher is in compliance with its redistribution licensing.
> 3. The VM image size is an exact multiple of 1 MB.
> 4. The VHD image is deprovisioned.
> 5. All the latest security patches for the Linux distribution are installed including recent major threats test warning.
> 6. All the latest guidelines to secure the VM image for the specific Linux distribution have been followed.
> 7. The VHD image only includes necessary locked accounts, that do not have default password that would allow interactive login, no back door.
> 8. Firewall rules are disabled or, firewall rules are not disabled because the application functionality relies on them, such as a firewall appliance.
> 9. The application's minimum requirement for number of virtual cores can be met by Azure Virtual Machines options.
> 10. The application's minimum requirement for RAM can be met by Azure Virtual Machines options.
> 11. The application's networking requirements of high bandwidth are documented as appropriate, if needed.
> 12. The application does not require a DHCP server enabled in the Virtual Machine. Dynamic Host Configuration Protocol Server is not a supported Server Role in Azure Virtual Machine. 
> 13. The application does not have dependency on software not included in the virtual machine. If it does, proper information should be available for customer to complete the deployment.
> 14. The virtual machine application works well in a dynamic IP address environment. If a static address is required, special configuration instructions are to be provided to customers.
> 15. Azure virtual machines may have different Input/Output Operations per Second (IOPS) capabilities than on-premises implementations and can vary with VM size and number of disks.The application is tested thoroughly to perform well in an Azure VM.
> 16. The Application Deployment Guide includes recommendations for deployment in high availability and Disaster recovery scenarios.
> 17. Application does not have dependency on /dev/sdb1 drive for persistent data. Azure offers /dev/sdb1 drive as temporary storage only and data could be lost.
> 18. The application does not require SSD based drives. Azure Virtual machines currently does not offer VM with Solid State Drives (SSD).
> 19. The application offer uptime SLA is in accordance with Azure VM service SLA. Azure offers SLA of 99.95% that can be met with High Availability deployment options such as grouping virtual machines in an Availability Set.
> 20. The application requires only one Network Interface Controller (NIC) and one IP address. Azure Virtual machines currently support only one Network Controller Card (NIC) and one IP address per NIC.
> 21. Application does not require Multicast or Broadcast networking protocols.Azure Virtual machines currently does not support Multicast or Broadcast protocols.
> 22. The application offer can be deployed in any Azure datacenter worldwide.
> 23. The application offer can be deployed in an environment where network throttling is enabled.
> 24. While additional configuration tasks may be required by the application, its deployment allows VM to fully provision and start OS.
> 25. Select true if you are enabling SSH for your end users with recommended ClientAliveInterval value (30-235) (or) SSH is not used for your end user scenarios.
> 26. LVM is not used on OS Disk. It is recommended to utilize standard partitions rather than LVM on OS Disk to avoid LVM name conflicts with cloned VMs.
> 27. Application does not have dependency on IPV6. IPV6 is not yet supported, it would be supported in near future.
    