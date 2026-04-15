# Azure VM Terraform Configuration with Load Balancer

This Terraform configuration deploys a complete Azure infrastructure including:
- Resource Groups (main + backend)
- Virtual Network (Single VNet)
- 2 Subnets (webSubnet01, webSubnet02)
- 2 Network Interfaces (NIC01, NIC02)
- 2 Ubuntu Linux Virtual Machines (webserver01, webserver02) with Nginx pre-installed
- Load Balancer with backend pool and health probe
- Storage Account (for Terraform state)
- Public IP for Load Balancer

## Architecture Overview

```
┌─────────────────────────────────────┐
│        Azure Region: West Europe    │
├─────────────────────────────────────┤
│         Resource Group (RG01)       │
├─────────────────────────────────────┤
│      Virtual Network (Vnet01)       │
│         10.0.0.0/16                 │
├──────────────────┬──────────────────┤
│  webSubnet01     │  webSubnet02     │
│  10.0.1.0/24     │  10.0.2.0/24     │
├──────────────────┼──────────────────┤
│  webserver01     │  webserver02     │
│  (NIC01)         │  (NIC02)         │
└──────────┬───────┴─────────┬────────┘
           │                 │
           └────────┬────────┘
                    │
            ┌───────┴────────┐
            │ Load Balancer  │
            │    (LB01)      │
            │  +Public IP    │
            └────────────────┘
```

## Quick Start

### 1. Initialize
```bash
terraform init
```

### 2. Plan
```bash
terraform plan
```

### 3. Apply
```bash
terraform apply
```

### 4. View Outputs
```bash
terraform output
```

## File Structure

```
.
├── main.tf              # Resource definitions (VNet, Subnets, VMs, LB)
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── providers.tf         # Provider & version config
├── .gitignore          # Git ignore patterns
└── README.md           # This file
```

## Key Variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `resource_group_name` | RG01 | Main resource group |
| `location` | West Europe | Azure region |
| `virtual_network_name` | Vnet01 | VNet name |
| `address_space` | 10.0.0.0/16 | VNet CIDR |
| `subnet_names` | [webSubnet01, webSubnet02] | Subnet names |
| `subnet_address_prefixes` | [10.0.1.0/24, 10.0.2.0/24] | Subnet CIDRs |
| `vm_names` | [webserver01, webserver02] | VM names |
| `vm_size` | Standard_B2s | VM SKU |
| `vm_admin_username` | azureuser | VM admin user |
| `vm_admin_password` | (from AZURE_PASS secret) | Admin password - set via GitHub secrets |
| `load_balancer_name` | LB01 | Load Balancer name |

## Deployment Instructions

1. **Set GitHub Secret (One-time setup)**
   - In your GitHub repository, go to Settings > Secrets and Variables > Actions
   - Create a new secret named `AZURE_PASS` with your desired password
   - Password requirements: Min 12 chars, uppercase, lowercase, number, special char
   - Example: `P@ssw0rd123456!`

2. **GitHub Actions Workflow** (if using GitHub Actions)
   - Create `.github/workflows/deploy.yml`:
   ```yaml
   name: Terraform Deploy
   on: [push]
   jobs:
     terraform:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v3
         - uses: hashicorp/setup-terraform@v2
         - run: terraform init
         - run: terraform plan
         - run: terraform apply -auto-approve \
             -var="vm_admin_password=${{ secrets.AZURE_PASS }}"
   ```

3. **Manual Deployment with GitHub Secret**
   ```bash
   terraform apply -var="vm_admin_password=$AZURE_PASS"
   ```
   Or set as environment variable:
   ```bash
   export TF_VAR_vm_admin_password=$AZURE_PASS
   terraform apply
   ```

4. **Review Resources**
   - Run `terraform plan` to see what will be created

5. **Deploy**
   ```bash
   terraform apply
   ```

6. **Connect to VMs via Azure Portal**
   - Go to Azure Portal > Virtual Machines > webserver01 (or webserver02)
   - Click "Connect" > "Bastion" (or "RDP" if configured)
   - Username: `azureuser`
   - Password: `(Your AZURE_PASS from GitHub secrets)`

7. **SSH into VMs (from Linux/Mac)**
   ```bash
   ssh azureuser@<LB_PUBLIC_IP>
   # Enter password (same as AZURE_PASS)
   ```

8. **Verify Nginx**
   - Once connected, check Nginx status:
   ```bash
   sudo systemctl status nginx
   ```
   - Test the web server:
   ```bash
   curl http://localhost:80
   ```

9. **Load Balancer Web Access**
   - Open browser and navigate to: `http://<LB_PUBLIC_IP>`
   - The Load Balancer will redirect to either webserver01 or webserver02

## Load Balancer Configuration

- **Frontend**: Public IP on port 80 (HTTP)
- **Backend Pool**: Both Ubuntu VMs (webserver01, webserver02) with Nginx
- **Health Probe**: HTTP on port 80, path "/" (Nginx default page)
- **Rule**: Routes HTTP traffic (port 80) to backend VMs
- **Nginx**: Pre-installed and running on both VMs

## Nginx Auto-Installation

Both VMs automatically install and configure Nginx during deployment via the `install_nginx.sh` script:
- Updates Ubuntu packages
- Installs Nginx
- Starts Nginx service
- Enables Nginx to start on reboot
- Creates a health check page at `/var/www/html/index.html`

## Clean Up

```bash
terraform destroy
```

## Troubleshooting

- **Password Error**: Ensure password in `AZURE_PASS` meets Azure requirements:
  - Minimum 12 characters
  - At least 1 uppercase letter
  - At least 1 lowercase letter
  - At least 1 number
  - At least 1 special character
- **GitHub Secrets Not Found**: Check that `AZURE_PASS` secret is created in GitHub repository settings
- **Nginx Not Running**: SSH into VM and check status: `sudo systemctl status nginx`
- **Health Probe Failed**: Verify Nginx is running and port 80 is accessible within the subnet
- **Provider Error**: Run `terraform init` if issues occur
- **State File Issues**: Check backend storage account configuration in `providers.tf`
- **Custom Data Script**: View logs on VM at `/var/log/nginx-install.log`
| `vm_size` | Standard_DS1_v2 | VM size |

## Override Variables

### Using terraform.tfvars
```hcl
resource_group_name = "my-custom-rg"
vm_name = "my-vm"
```

### Using CLI
```bash
terraform apply -var="vm_name=custom-vm"
```

## Outputs

Key outputs after deployment:
- `vm_id` - Virtual machine ID
- `vm_private_ip` - Private IP address
- `resource_group_name` - Resource group name

## Prerequisites

- Azure CLI authenticated (`az login`)
- Terraform >= 1.0
- Active Azure subscription

## Remote Backend Setup

To use Azure Storage for state (recommended):

1. Deploy initial resources: `terraform apply`
2. Uncomment backend block in `terraform.tf`
3. Reinitialize: `terraform init`

## Cleanup

```bash
terraform destroy
```

## Cost Estimate

- **VM**: ~$50/month
- **Storage**: ~$1-2/month
- **Total**: ~$50-60/month

## Important Notes

⚠️ **Security:**
- Passwords stored in state (not encrypted by default)
- Use SSH keys for production
- Keep `.tfstate` files secure
- Never commit sensitive data to version control

## Support

- [Azure Documentation](https://azure.microsoft.com/docs/)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
- [Terraform Documentation](https://www.terraform.io/docs/)
