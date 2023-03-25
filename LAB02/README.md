# LAB 02 – Hybrid network with Azure Virtual Network Gateway

## Arquitetura

![Arquitetura](https://user-images.githubusercontent.com/25647623/227725284-61d330a3-fa46-4060-8540-ee181ac96f6b.png)

## Criar um Virtual Network Gateway.

* VNG-01

![030-create-vng-01](https://user-images.githubusercontent.com/25647623/227722448-cd8e88f2-50db-467b-9a40-b12938d23678.png)

## Criar uma estrutura de rede para simular um ambiente On-Premises.

### Azure Portal

* Criar VNET-Onpremises

![031-create-vnet-onpremises](https://user-images.githubusercontent.com/25647623/227722417-d2da87c3-f4bc-4a6b-9a85-c4bd723ff74c.png)

* Criar SUB-Onpremises

![032-create-SUB-Onpremises](https://user-images.githubusercontent.com/25647623/227722472-b23ede53-7000-429c-bc67-bddb72f6a0ad.png)

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

![033-create-VM-FW-Onpremises](https://user-images.githubusercontent.com/25647623/227722503-a0121bc8-b7c6-4a11-96ce-739ac1e09b76.png)

![034-create-VM-FW-Onpremises](https://user-images.githubusercontent.com/25647623/227722504-e1ea801e-2490-4e7a-a43d-0c182f1849b9.png)

* Habilitar Forwarding na placa de rede da VM-FW-Onpremises

![035-enable-forwarding-vm-fw-onpremises](https://user-images.githubusercontent.com/25647623/227722550-cc67aed0-1548-42d5-bb89-81e01f20ee67.png)

* Configurar DirectAccess and VPN na VM-FW-Onpremises

<img src="https://user-images.githubusercontent.com/25647623/227723158-eb0e6da6-227e-4723-8c6d-a197019461d9.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227723167-c1a706c6-acdf-4543-bbf3-f3020e94b64b.png" width="500px"></img>


<img src="https://user-images.githubusercontent.com/25647623/227723168-c1260679-81b0-4228-8388-37f34fa4afc6.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227723170-894fbd04-4f3e-4a14-950e-29ee423381d4.png" width="500px"></img>


<img src="https://user-images.githubusercontent.com/25647623/227723174-05b71512-306c-4d49-a74e-d7b99edf7c51.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227723178-c7eab87d-6b72-4e79-8a79-e3f4a9cc4e44.png" width="500px"></img>


<img src="https://user-images.githubusercontent.com/25647623/227723179-7c842fc6-1e17-4d2f-a3d9-e826eba01b7c.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227723180-12ef0dd2-6c8c-45a2-9bff-48623fbf0b18.png" width="500px"></img>


<img src="https://user-images.githubusercontent.com/25647623/227723181-08ec3aeb-9bb5-46d1-8afe-046b8fca3142.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227723182-c2da93a9-1ac9-464a-8e4f-b29267807fd5.png" width="500px"></img>


<img src="https://user-images.githubusercontent.com/25647623/227723184-dce22fe1-3f57-401e-98fb-af998eb663bb.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227723185-8269c4d2-2149-47a9-9b91-98b03a0e2721.png" width="500px"></img>


<img src="https://user-images.githubusercontent.com/25647623/227723187-cb1ccea8-69ec-4095-999e-2ca5002e8cf5.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227723188-4daa15b6-f908-4127-aa34-0cb4fe2b6d25.png" width="500px"></img>

<img src="https://user-images.githubusercontent.com/25647623/227723190-cb695a0d-c141-453a-bd0b-4131e50d52f7.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227723192-275ee987-7db7-49bc-a151-a8a1e58c7f8e.png" width="500px"></img>


<img src="https://user-images.githubusercontent.com/25647623/227723193-4ed32edd-8113-4ddd-b14f-63b68a4bff48.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227723194-115b6a67-477f-49ca-93e8-c0d69cd7805f.png" width="500px"></img>


<img src="https://user-images.githubusercontent.com/25647623/227723197-b0840936-6a34-4558-b179-8ead2e175301.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227723199-22e344c3-d86c-4f99-9ac2-8fab100c5fcf.png" width="500px"></img>


<img src="https://user-images.githubusercontent.com/25647623/227723201-13a13105-2320-4bf4-900c-fb525780ef7c.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227723203-63ae7a3a-970a-444e-9890-1fe77403f639.png" width="500px"></img>

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

![036-create-LNG-01](https://user-images.githubusercontent.com/25647623/227723842-2f76be5a-1fc8-4aed-a739-ae4852ad4fe4.png)

## Configurar VPN Site-to-Site

![037-connect-VPN-Onpremises](https://user-images.githubusercontent.com/25647623/227724120-ef67e709-7d10-4066-8740-c49c47f0697b.png)

* Habilitar virtual network gateway ou route server no Peering USA01-to-BRA01

<img src="https://user-images.githubusercontent.com/25647623/227724291-515b998a-af8c-4100-9dfd-4e619af5dbc8.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227724292-65dfce58-17fd-4320-978c-57e0c8781c4c.png" width="500px"></img>

* Estabelecer conexão VPN Site-to-Site

![Screenshot (24)](https://user-images.githubusercontent.com/25647623/227727270-c2e70b0b-243c-43cd-8076-54017e0d9b70.png)

* Testar conexão VPN Site-to-Site

![Screenshot (25)](https://user-images.githubusercontent.com/25647623/227727271-f417797a-c4da-48aa-b6b4-c452e384ce35.png)

## Configurar VPN Point-to-Site

* Configurar conexão Point-to-Site no Virtual Network Gateway (VNG-01)

![040-config-vpn-p2p](https://user-images.githubusercontent.com/25647623/227726558-492f64a3-bf99-447e-81fe-e7afd73f3cf4.png)

* Configurar acesso de usuários à VPN Point-to-Site

![041-config-vpn-p2p](https://user-images.githubusercontent.com/25647623/227726612-21749255-c7f0-4711-865f-443bee4a6323.png)

* Baixar e configurar VPN Client

![042-config-vpn-p2p](https://user-images.githubusercontent.com/25647623/227726677-55d6628b-fa9b-44c1-99a0-a66ef3fe3b91.png)

* Estabelecer conexão VPN Point-to-Site e testar conexão com VMs

![043-connect-vpn-p2p](https://user-images.githubusercontent.com/25647623/227726721-e8a1de7f-ef9c-4f70-9e06-ec5370b50f8c.png)
