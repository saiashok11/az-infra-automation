# Azure VM Terraform Configuration

This Terraform configuration deploys a complete Azure infrastructure including:
- Resource Groups (main + backend)
- Virtual Network & Subnet
- Network Interface
- Storage Account (for Terraform state)
- Ubuntu Virtual Machine

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
├── main.tf              # Resource definitions
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── terraform.tf         # Provider & version config
├── .gitignore          # Git ignore patterns
└── README.md           # This file
```

## Key Variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `resource_group_name` | MYRG012 | Main resource group |
| `vm_name` | myVM01 | Virtual machine name |
| `location` | West Europe | Azure region |
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
