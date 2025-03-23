#! /usr/bin/sh

# Set the necessary variables
RESOURCE_GROUP="rg-mslearn-mlops"
REGIONS=("eastus" "westus" "centralus" "northeurope" "westeurope")
RANDOM_REGION=${REGIONS[$RANDOM % ${#REGIONS[@]}]}
WORKSPACE_NAME="mlw-mslearn-mlops"
COMPUTE_INSTANCE="ci001"

# Create the resource group and workspace and set to default
echo "Create a resource group and set as default:"
az group create --name $RESOURCE_GROUP --location $RANDOM_REGION
az configure --defaults group=$RESOURCE_GROUP

echo "Create an Azure Machine Learning workspace:"
az ml workspace create --name $WORKSPACE_NAME 
az configure --defaults workspace=$WORKSPACE_NAME 

# Create compute instance
echo "Creating a compute instance with name: " $COMPUTE_INSTANCE
az ml compute create --name ${COMPUTE_INSTANCE} --size STANDARD_DS11_V2 --type ComputeInstance 

# Create the URI folder data asset
echo "Create training data asset:"
az ml data create --name diabetes-dev-folder \
                  --path ../experimentation/data \
                  --type uri_folder \
                  --version 1.0
