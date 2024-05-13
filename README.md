# BeeGFS Deployment on Crusoe Cloud

This Terraform configuration sets up a BeeGFS distributed file system on Crusoe Cloud. It provisions several compute instances configured as storage, client, metadata, and management nodes.

## Prerequisites

- Terraform installed on your local machine.
- Access to Crusoe Cloud with configured credentials.

## Configuration

Before deploying the BeeGFS cluster, you need to update a few configuration details:

1. **Authentication**: Create a file ~/.crusoe/config with contents like 

```toml
profile='default'

[default]
default_project="default"
secret_key="todo"
access_key_id="todo"
```

2. **Public SSH Key**: Replace the default `"todo"` value for the `public_ssh_key` variable with your public SSH key to enable access to the instances.

3. **Project ID**: Update the `project_id` variable's default `"todo"` value with your Crusoe Cloud project ID.

## Usage

1. **Initialization**: Initialize Terraform to download the required providers:

    ```bash
    terraform init
    ```

2. **Plan**: Review the Terraform plan to see the resources that will be created:

    ```bash
    terraform plan
    ```

3. **Apply**: Apply the Terraform configuration to create the infrastructure:

    ```bash
    terraform apply
    ```

## Architecture

- **Storage Nodes**: Three instances are configured as storage nodes. These are responsible for storing the data chunks.
- **Client Node**: A single instance configured to act as the client node, which accesses the file system.
- **Metadata Node**: One instance serves as the metadata node, managing metadata for the file system.
- **Management Node**: This node handles the management and monitoring of the BeeGFS cluster.

## Outputs

After deployment, the Terraform script outputs the public IP addresses of all configured nodes. This information is crucial for accessing and managing the BeeGFS cluster.

- `storage_ips`: IP addresses of the storage nodes.
- `client_ip`: IP address of the client node.
- `metadata_ip`: IP address of the metadata node.
- `management_ip`: IP address of the management node.

## Cleanup

To destroy the BeeGFS cluster and all associated resources:

```bash
terraform destroy
