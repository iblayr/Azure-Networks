# Definindo variáveis
$rgName='rg-azure'
$location='eastus'

# Criando um grupo de recursos
New-AzResourceGroup -Name $rgName -Location $location

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

# Criar emparelhamento entre vnets

    # Peer VNET-USA01 to VNET-BRA01.
    Add-AzVirtualNetworkPeering -Name 'VNET-USA01-to-VNET-BRA01' -VirtualNetwork $vnetUSA01 -RemoteVirtualNetworkId $vnetBRA01.Id

    # Peer VNET-BRA01 to VNET-USA01.
    Add-AzVirtualNetworkPeering -Name 'VNET-BRA01-to-VNET-USA01' -VirtualNetwork $vnetBRA01 -RemoteVirtualNetworkId $vnetUSA01.Id

    # Peer VNET-USA01 to VNET-EUR01.
    Add-AzVirtualNetworkPeering -Name 'VNET-USA01-to-VNET-EUR01' -VirtualNetwork $vnetUSA01 -RemoteVirtualNetworkId $vnetEUR01.Id

    # Peer VNET-EUR01 to VNET-USA01.
    Add-AzVirtualNetworkPeering -Name 'VNET-EUR01-to-VNET-USA01' -VirtualNetwork $vnetEUR01 -RemoteVirtualNetworkId $vnetUSA01.Id

# Criar zona privada de DNS

New-AzPrivateDnsZone -Name "iblayr.com" -ResourceGroupName "rg-azure"