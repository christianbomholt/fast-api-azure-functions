## Content

This is a simple repo to demonstrate deploying python webframe works such as `flask` or `FastAPI` to Azure Functions.

## Getting started

First login to your Azure subscription with sufficient permissions


```sh
az login
```

Next create a ressource group to place the function and storage account in for out `FastAPI`

```sh
az group create --name "rg-python"\
 --location westeurope
```
Thereafter we create a storage account

```sh
az storage account create --name "pythonstorageforapps"\
 --location westeurope \
 --resource-group "rg-python" \
 --sku Standard_LRS
```

And finally we create the function app, to which we will deploy our Azure function.
```sh
az functionapp create --resource-group "rg-python"\
 --consumption-plan-location westeurope \
 --runtime python --runtime-version 3.8 \
 --functions-version 3 \
 --name "christianbomholt" \
 --storage-account "pythonstorageforapps" \
 --os-type linux
```

#### Deploy code

This is dependent on Azure functions core tools, which can be installed using [this](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=linux%2Ccsharp%2Cbash#publish)

```sh
func azure functionapp publish "christianbomholt"
```

### Run locally

Install poetry to handle requirements and virutalenv
```sh
pip install poetry
poetry shell
poetry install
```

run azure function
```sh
func start
```

### Creatin new projects using `azure functions core tools`

```sh
func init first-azure-function --python

cd first-azure-function

func new --name first-function \
    --template "HTTP trigger"\
    --authlevel "anonymous"
``` 

### Example

- docs:
    - redoc: https://christianbomholt.azurewebsites.net/redoc
    - OAS / Swagger: https://christianbomholt.azurewebsites.net/docs
- endpoints:https://christianbomholt.azurewebsites.net/items/1?q=2

### Notes

Official Azure docs seems to suggest the use of

```
import az
func.WsgiMiddleware(app).handle(req, context)
```