# TemplatesVM
This is a repository for defining Virtual Machine templates for Azure TRE project.

## Acknowledgements
The repository is based on the Martin Peck's [Custom VM Sample Toolkit](https://github.com/martinpeck/custom-vm-sample-toolkit)

## Requirements (prerequisites)
Visual Studio Code with Dev Containers extension (and Docker running locally). Also, you need to have the Azure Compute Gallery instance in place.

## Software User Manual (SUM)
This section describes how to run build and deploy VM images.

### How to set up environments
First, set up the environment configuration file, located in `/scripts/environments/ENVIRONMENT_NAME.env`. Choose a proper environment name - typical values are `dev`, `prd`, `stg`, etc. **Definition of the environment file:** the content of, say,`/scripts/environments/dev.env` file looks like:
```shell
# Subscription UUID in Azure (here you need to log in)
export SUBSCRIPTION_ID=TODO_FILL

# Image environment name (e. g. SuperProject)
export CVM_ENVIRONMENT_SUFFIX=TODO_FILL

# Resource group and location (e.g. ukwest) of Azure Compute Gallery
export CVM_RESOURCE_GROUP=TODO_FILL
export CVM_LOCATION=TODO_FILL
export CVM_GALLERY_NAME=TODO_FILL

# Storage Account for VM  Image Templates
export CVM_STORAGE_ACCOUNT=TODO_FILL
export CVM_CONTAINER_NAME=TODO_FILL

# Managed Identity Name
export CVM_IMAGE_BUILDER_ID_NAME=TODO_FILL

# Custom Role Definition (descriptive name of the role, you can change)
export CVM_IMAGE_BUILDER_ROLE_NAME="Azure Image Builder Service Image Creation Role"

# Tag list (separated by spaces, logic: KEY=VALUE), e. g.:
export CVM_TAGS="Project=FILL CreatedBy=FILL Templates=FILL"
```
Then, export environment name (the name of the environment is the name of the file)
```shell
export ENVIRONMENT_NAME=dev
```
or whatever you chose instead of `dev`.

### How to deploy
First, open the project in the `.devcontainer` (if you use Visual Studio Code). Then, go to the terminal of this container. Then, log into Azure using:
```shell
az login --use-device-code
az account set --subscription YOUR_SUBSCRIPTION_UUID 
```

Then, choose what is your template image you wish to deploy, e. g. `windows11-datascience-rpython` (in the following, we use `TEMPLATE_IMAGE_NAME` which needs to be replaced). 

Then, run the following:
1. _Optional step_ (fast verification)
```shell
make vm-show-metadata TEMPLATE_PATH=templates/TEMPLATE_IMAGE_NAME
```

Mandatory steps (be aware that it takes a long time):
1. Define image (fast step)
```shell
make vm-define-image TEMPLATE_PATH=templates/TEMPLATE_IMAGE_NAME
```
2. Deploy template artifacts (fast step)
```shell
make vm-deploy-template-artifacts TEMPLATE_PATH=templates/TEMPLATE_IMAGE_NAME
```
3. Create image template (a bit slower):
```shell
make vm-create-image-template TEMPLATE_PATH=templates/TEMPLATE_IMAGE_NAME
```
Sometimes, the image needs to be deleted first (a bit slower, around 10 minutes):
```shell
make vm-delete-image-template TEMPLATE_PATH=templates/TEMPLATE_IMAGE_NAME
```
4. Build image (super slow, around 4 hours)
```shell
make vm-build-image TEMPLATE_PATH=templates/TEMPLATE_IMAGE_NAME
```
and that is all.

### How to change and define images
Images are defined as a set of scripts (PowerShell for the Windows VMs and SH for the Linux VMs). They are located in `templates` repository. The logic is straightforward, you can modify whatever script you need.

Be aware that you can only install software that does not require interaction with user during the installation (as if it does, the process will never end).

Also, modify the location in `image_template.json` files.
