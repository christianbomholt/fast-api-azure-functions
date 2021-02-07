#!/bin/bash

func init first-azure-function --python
cd first-azure-function
func new --name first-function --template "HTTP trigger" --authlevel "anonymous"

az login

az group create --name "rg-python" --location westeurope
az storage account create --name "pythonstorageforapps" --location westeurope --resource-group "rg-python" --sku Standard_LRS
az functionapp create --resource-group "rg-python"\
 --consumption-plan-location westeurope \
 --runtime python --runtime-version 3.8 \
 --functions-version 3 \
 --name "christianbomholt" \
 --storage-account "pythonstorageforapps" \
 --os-type linux

func azure functionapp publish "christianbomholt"

site="https://christianbomholt.azurewebsites.net/api/my_first_function?user=chris&code=sGwPrv2ZPCyFUpBHkfKrGHmuGlcRTHt57SiIiQdmcpAq3TCIjuFEzw=="

curl $site