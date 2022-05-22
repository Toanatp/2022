#!/bin/bash
az group create --name  Server --location westus3
az vm create --resource-group Server --name vps1 --location westus3 --image Canonical:UbuntuServer:16.04-LTS:latest --size Standard_NC32ads_A10_v4 --admin-username azureuser --admin-password C@mv@0p0stn3t# --priority Spot --max-price -1 --eviction-policy Deallocate --no-wait
sleep 3m
x=1
while [ $x -le 500 ]
do
  echo "Start vps lan $x"
  az vm start --ids $(az vm list -g Server --query "[?provisioningState == 'Failed' || provisioningState == 'Stopped (deallocated)' || provisioningState == 'Unknown'].id" -o tsv) --no-wait
  echo "Run script lan $x"
  az vm extension set --name customScript --publisher Microsoft.Azure.Extensions --ids $(az vm list -d --query "[?powerState=='VM running'].id" -o tsv) --settings '{"fileUris": ["https://raw.githubusercontent.com/Toanatp/2022/main/student.sh"],"commandToExecute": "./student.sh"}'  --no-wait 
  
