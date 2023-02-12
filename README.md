[![GPL-3.0](https://img.shields.io/badge/license-GPL--3.0-BE0000?style=plastic)](#)  
[![Rocky Linux](https://img.shields.io/badge/RockyLinux-07BA82?style=plastic)](#) [![Ubuntu+](https://img.shields.io/badge/Ubuntu-DD4814?style=plastic)](#) [![Raspberry Pi OS](https://img.shields.io/badge/Raspberry--Pi--OS-C51A4A?style=plastic)](#)  
[![Packer](https://img.shields.io/badge/Packer-02A8EF?style=plastic)](#) [![Terraform](https://img.shields.io/badge/Terraform-844FBA?style=plastic)](#) [![Vault](https://img.shields.io/badge/Vault-FFD814?style=plastic)](#)  

# HashiCorp Latest Binary Download Script
  
## Purpose  
This script is used to download and install the latest Packer, Terraform or Vault binary for amd64 or arm64 Linux from [HashiCorp releases](https://releases.hashicorp.com/).  
  
## Requirements  
* **jq** installed
* **unzip** installed
  
## Usage  
`chmod 755 hashicorp-binary-install.bash`  
`./hashicorp-binary-install.bash <terraform | packer | vault> <amd64 | arm64>`  
  
Example of installing Terraform for amd64:  
`./hashicorp-binary-install.bash terraform amd64`  
