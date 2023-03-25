# LAB 02 – Deploy Virtual Network Gateway

## Arquitetura



## Criar um Virtual Network Gateway.

* VNG-01

## Criar uma estrutura de rede para simular um ambiente On-Premises.

### Azure Portal

* Criar VNET-Onpremises

* Criar SUB-Onpremises


### Azure Powershell

```powershell

# Definir as informações da VNET
$rgName = "RG-Onpremises"
$location = "eastus2"
$vnetName = "VNET-Onpremises"
$vnetAddressPrefix = "192.168.0.0/16"
$subnetName = "SUB-Onpremises"
$subnetAddressPrefix = "192.168.0.0/24"

# Criar um grupo de recursos
New-AzResourceGroup -Name $rgName -Location $location

# Criar a VNET e a sub-rede
$vnet = New-AzVirtualNetwork `
    -Name $vnetName `
    -ResourceGroupName $rgName `
    -Location $location `
    -AddressPrefix $vnetAddressPrefix

$subNet = Add-AzVirtualNetworkSubnetConfig `
    -Name $subnetName `
    -AddressPrefix $subnetAddressPrefix `
    -VirtualNetwork $vnet

Set-AzVirtualNetwork -VirtualNetwork $vnet

```

## Deploy VM para similar firewall onpremises

### Azure Portal

* Criar VM-FW-Onpremises


* Habilitar Forwarding na placa de rede da VM-FW-Onpremises


* Configurar DirectAccess and VPN na VM-FW-Onpremises



### Azure Powershell

```powershell

# Definir as informações da VM
$virtualMachineName = "VM-FW-Onpremises"
$networkInterfaceName = "vm-fw-onpremises683"
$publicIpAddressName = "VM-FW-Onpremises-ip"
$networkSecurityGroupName = "VM-FW-Onpremises-nsg"

# Criar recurso de endereço IP público
New-AzPublicIpAddress -Name $publicIpAddressName -ResourceGroupName "RG-Onpremises" -Location "eastus2" -AllocationMethod Static -Sku Standard -Tag @{ VM = "LAB-AZ-700" }

# Criar recurso de Máquina virtual
$vm = New-AzVMConfig -VMName $virtualMachineName -VMSize "Standard_B2s"
$vm = Set-AzVMOperatingSystem -VM $vm -Windows -ComputerName "VM-FW-Onpremise" -Credential (Get-Credential -Message "Enter a username and password for the virtual machine.")
$vm = Set-AzVMSourceImage -VM $vm -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2022-datacenter-azure-edition" -Version "latest"
$vm = Add-AzVMNetworkInterface -VM $vm -Id (Get-AzNetworkInterface -Name $networkInterfaceName -ResourceGroupName "RG-Onpremises").Id
$vm = Set-AzVMOSDisk -VM $vm -Name "$virtualMachineName-OsDisk" -CreateOption FromImage -ManagedDiskId (New-AzDiskConfig -DiskName "$virtualMachineName-OsDisk" -DiskSizeGB 127 -Location "eastus2" -SkuName "Premium_LRS" -CreateOption Empty).Id -Caching ReadWrite -OsType Windows -DiskSizeGB 127
New-AzVM -ResourceGroupName "RG-Onpremises" -Location "eastus2" -VM $vm -Tag @{ VM = "LAB-AZ-700" }

# Criar recurso de Grupo de Segurança de Rede
$rdpRule = New-AzNetworkSecurityRuleConfig -Name "RDP" -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389 -Access Allow
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName "RG-Onpremises" -Location "eastus2" -Name $networkSecurityGroupName -SecurityRules $rdpRule -Tag @{ VM = "LAB-AZ-700" }

# Associa o grupo de segurança de rede à placa de rede virtual
$networkInterface = Get-AzNetworkInterface -Name $networkInterfaceName -ResourceGroupName "RG-Onpremises"
$networkInterface.NetworkSecurityGroup = $nsg
Set-AzNetworkInterface -NetworkInterface $networkInterface

```

## Criar um Local Network Gateway



## Deploy VPN Point to Site

### Configurar VPN Point to Site



### Estabelecer conexão VPN P2P



