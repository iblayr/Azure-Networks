# Topologia de rede hub-spoke no Azure

## Arquitetura

![Arquitetura](https://user-images.githubusercontent.com/25647623/227696694-24803702-6e33-4026-8439-076dcd7959c5.png)
***
## Criar estrutura de rede usando 3 VNETs em regiões diferentes, com suas respectivas Subnets.

### Criar grupo de recursos

#### Azure Portal


![001-create-rg-azure](https://user-images.githubusercontent.com/25647623/227694692-b7629b8c-18d9-46e4-8155-f2f269d373f9.png)


#### Azure Powershell

```powershell 

# Definir variáveis para nome do grupo de recursos e região
$resourceGroupName = "rg-azure"
$location = "eastus"

# Verificar se o grupo de recursos já existe
if ((Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue) -eq $null) {
    # Se o grupo de recursos não existir, criar um novo
    New-AzResourceGroup -Name $resourceGroupName -Location $location
} else {
    # Se o grupo de recursos já existir, mostrar uma mensagem de aviso
    Write-Warning "O grupo de recursos '$resourceGroupName' já existe na região '$location'."
}

```
***
### Criar VNETS

#### Azure Portal

  
  * VNET-USA01

![002-create-vnet-usa01](https://user-images.githubusercontent.com/25647623/227694783-9a6ce49b-a381-4447-8f90-dc770de351d6.png)

  * SUB-CoreServices

![003-create-SUB-CoreServices](https://user-images.githubusercontent.com/25647623/227694854-278cbc4a-b910-4b71-871d-88d11e951f41.png)

  * SUB-Security

![004-create-SUB-Security](https://user-images.githubusercontent.com/25647623/227694937-cd6fd3eb-f994-4e4c-a193-b590088d33e1.png)

  * GatewaySubnet

![014-create-GatewaySubnet](https://user-images.githubusercontent.com/25647623/227695644-6983ab86-c942-4900-a206-80e109ef646a.png)

  * VNET-EUR01

![006-create-vnet-eur01](https://user-images.githubusercontent.com/25647623/227695582-2eff68da-6a63-4d6e-8540-74c36f1f651c.png)

  * SUB-Files

![007-create-SUB-Files](https://user-images.githubusercontent.com/25647623/227695594-3b89b9d4-ede6-4a87-bf80-b2471bf1843e.png)

  * VNET-BRA01

![009-create-vnet-bra01](https://user-images.githubusercontent.com/25647623/227695600-cf4a9c48-d0eb-4d14-bf57-46246a91f860.png)

  * SUB-WebServers

![010-create-SUB-WebServers](https://user-images.githubusercontent.com/25647623/227695609-6b3e4f2a-a713-4a47-bd17-756ac4753b0c.png)

  * SUB-Database

![011-create-SUB-Database](https://user-images.githubusercontent.com/25647623/227695616-371d304b-cae9-42f1-ac43-5819af44d240.png)

  * SUB-Storage

![012-create-SUB-Storage](https://user-images.githubusercontent.com/25647623/227695620-12ca2136-7833-4dbe-b185-592965067ef6.png)


#### Azure Powershell

```powershell

# Definindo variáveis
$rgName='rg-azure'
$location='eastus'

# Criando a rede virtual hub e suas sub redes
$subCoreServices = New-AzVirtualNetworkSubnetConfig -Name 'SUB-CoreServices' -AddressPrefix '10.1.0.0/24'
$subSecurity = New-AzVirtualNetworkSubnetConfig -Name 'SUB-Security' -AddressPrefix '10.1.1.0/24'
$gatewaySubnet = New-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -AddressPrefix '10.1.255.0/27'
$vnetUSA01 = New-AzVirtualNetwork -ResourceGroupName $rgName -Name 'VNET-USA01' -AddressPrefix '10.1.0.0/16' `
  -Location $location -Subnet $subCoreServices, $subSecurity, $gatewaySubnet

# Criando a rede virtual spoke 1 e suas sub redes
$subWebServers = New-AzVirtualNetworkSubnetConfig -Name 'SUB-WebServers' -AddressPrefix '10.3.0.0/24'
$subDatabase = New-AzVirtualNetworkSubnetConfig -Name 'SUB-Database' -AddressPrefix '10.3.1.0/24'
$subStorage = New-AzVirtualNetworkSubnetConfig -Name 'SUB-Storage' -AddressPrefix '10.3.2.0/24'
$vnetBRA01 = New-AzVirtualNetwork -ResourceGroupName $rgName -Name 'VNET-BRA01' -AddressPrefix '10.3.0.0/16' `
  -Location 'brazilsouth' -Subnet $subWebServers, $subDatabase, $subStorage

# Criando a rede virtual spoke 2 e sua sub rede
$subFiles = New-AzVirtualNetworkSubnetConfig -Name 'SUB-Files' -AddressPrefix '10.2.0.0/24'
$vnetEUR01 = New-AzVirtualNetwork -ResourceGroupName $rgName -Name 'VNET-EUR01' -AddressPrefix '10.2.0.0/16' `
  -Location 'westeurope' -Subnet $subFiles

```
***
## Criar configuração de peering entre VNETs.

* Peering VNET-USA01 -> VNET-BRA01

![015-peering-VNET-USA01-to-VNET-BRA01](https://user-images.githubusercontent.com/25647623/227696197-823fba94-9e19-4acb-9b9e-cc0cd8c3a06d.png)

* Peering VNET-USA01 -> VNET-EUR01

![016-peering-VNET-USA01-to-VNET-EUR01](https://user-images.githubusercontent.com/25647623/227696237-81c6b980-a259-47e3-a81b-5c7d28340388.png)

* VNET Peering

![017-vnets-peerings](https://user-images.githubusercontent.com/25647623/227696252-30612f38-b609-4932-9861-f0ce0637e2ba.png)

#### Azure Powershell

```powershell

# Criar emparelhamento entre vnets

    # Peer VNET-USA01 to VNET-BRA01.
    Add-AzVirtualNetworkPeering -Name 'VNET-USA01-to-VNET-BRA01' -VirtualNetwork $vnetUSA01 -RemoteVirtualNetworkId $vnetBRA01.Id

    # Peer VNET-BRA01 to VNET-USA01.
    Add-AzVirtualNetworkPeering -Name 'VNET-BRA01-to-VNET-USA01' -VirtualNetwork $vnetBRA01 -RemoteVirtualNetworkId $vnetUSA01.Id

    # Peer VNET-USA01 to VNET-EUR01.
    Add-AzVirtualNetworkPeering -Name 'VNET-USA01-to-VNET-EUR01' -VirtualNetwork $vnetUSA01 -RemoteVirtualNetworkId $vnetEUR01.Id

    # Peer VNET-EUR01 to VNET-USA01.
    Add-AzVirtualNetworkPeering -Name 'VNET-EUR01-to-VNET-USA01' -VirtualNetwork $vnetEUR01 -RemoteVirtualNetworkId $vnetUSA01.Id

```
***
## Implantar VM-LNX-01 na VNET East US e VM-WIN-01 na VNET Brazil South.

* Deploy VM-LNX01

<img src="https://user-images.githubusercontent.com/25647623/227696362-dbf05afd-27b7-47ec-b402-4392fbbffe99.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227696385-e6bb7422-6c3b-4be6-92e4-bd4099ae40ec.png" width="500px"></img>


* Deploy VM-WIN01

<img src="https://user-images.githubusercontent.com/25647623/227696404-fc62d8ca-d313-484e-a7c8-60269e9a7471.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227696414-72d1d702-1060-42c3-a1e6-05164129c552.png" width="500px"></img>


* Testar conexão entre as VMs

![022-test-connection](https://user-images.githubusercontent.com/25647623/227696438-75783617-73e9-4332-8044-8d68a9d5924b.png)
***
## Configurar um Private DNS e linkar a todas VNETs.

* Criar zona priva de DNS

![023-create-private-dns-zone](https://user-images.githubusercontent.com/25647623/227696464-4ea9f35b-e1d2-4184-a273-176ed58cd9bf.png)

* Link-USA01

![024-create-link-dns-usa01](https://user-images.githubusercontent.com/25647623/227696492-e66a8dd4-114d-4a12-ab0f-390bcc6f7dd0.png)

* Link-EUR01

![025-create-link-dns-eur01](https://user-images.githubusercontent.com/25647623/227696504-18629343-b26c-49c3-ab0d-dd891a6a7688.png)

* Link-BRA01

![026-create-link-dns-bra01](https://user-images.githubusercontent.com/25647623/227696515-6ec838cb-97a1-4857-bdd8-381a947c484c.png)

* Links-DNS

![027-create-links-dns](https://user-images.githubusercontent.com/25647623/227696522-483cbeee-b926-4574-a8b6-087f5c9a19b0.png)

* Registrar VMs

![028-registro-vms-dns](https://user-images.githubusercontent.com/25647623/227696532-e39ec7cf-ac52-48d2-a9cf-43b100b4c874.png)

* Testar conexão

![029-test-private-dns](https://user-images.githubusercontent.com/25647623/227696555-8dec2771-8bba-4524-a254-4c97916ed56f.png)





