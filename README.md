# dullahan

## Infrastructure

### Initialisation

#### Pre-`terraform`

A remote storage container must exist before applying the plan.

```sh
# Create a resource group. This must be imported afterwards by terraform.
az group create --name "$RESOURCE_GROUP_NAME" --location eastus

# Create storage account.
az storage account create --resource-group "$RESOURCE_GROUP_NAME" --name "$STORAGE_ACCOUNT_NAME" --sku Standard_LRS --encryption-services blob

# Create blob container.
az storage container create --name "$CONTAINER_NAME" --account-name "$STORAGE_ACCOUNT_NAME"
```

#### Post-`terraform`

```sh
# Install certbot.
sudo apt install certbot

# Get certificates.
certbot certonly -d dullahan.utkarshverma.me
```
