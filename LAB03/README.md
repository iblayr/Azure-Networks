# LAB 03 – Configurar uma VPN Point-to-Site utilizando o Azure Virtual WAN

&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;

## Arquitetura

![Arquitetura drawio](https://user-images.githubusercontent.com/25647623/227754434-22814360-e803-40e6-9adf-49377580b954.png)

&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;

## Implantar Virtual WAN e Virtual HUB

* Deploy Virtual Wan

![044-deploy-vwan-01](https://user-images.githubusercontent.com/25647623/227754454-bb867cec-7930-4846-bf8f-2a6b4633e4cf.png)

* Deploy Virtual Hub

![045-deploy-vhub-01](https://user-images.githubusercontent.com/25647623/227754460-3d503f74-d57d-43ca-b3ae-5b8e5d208085.png)

* Conectar Virtual Hub à VNET-USA01

![046-connect-vhub-to-vnet-usa01](https://user-images.githubusercontent.com/25647623/227754471-b4f91e9e-5f6b-45e4-ba0a-6842f39e1c6a.png)

&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;
&nbsp;

## Implantar VPN Point to Site conectada via Virtual HUB

* Configurar User VPN no Virtual Wan (VPN Point-to-Site)

<img src="https://user-images.githubusercontent.com/25647623/227754481-1b0663c4-1a21-42b1-8a27-6a0bc186c224.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227754523-83263d79-0183-4a9b-88bc-7da1722ddb93.png" width="500px"></img>


* Criar User VPN Gateway no Virtual Hub

![049-config-user-vpn-vhub](https://user-images.githubusercontent.com/25647623/227754678-f33d011d-5c96-40a7-ab59-fbbc270e0164.png)

* Baixar e configurar VPN Client

<img src="https://user-images.githubusercontent.com/25647623/227754696-290d1cc8-f298-46d6-96c0-e1ec75de1987.png" width="500px"></img>
<img src="https://user-images.githubusercontent.com/25647623/227754698-d22156f2-2f23-4c1e-bb4d-66196471cb3f.png" width="500px"></img>

* Estabelecer conexão VPN Point-to-Site e testar

![052-test-vpn-p2p-vwan](https://user-images.githubusercontent.com/25647623/227754706-ef588a3b-bb65-4d60-92ee-f70471f89215.png)
