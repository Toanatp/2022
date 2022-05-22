#!/bin/bash
az group create --name  Server --location westus3
az vm create --resource-group Server --name vps1 --location westus3 --image UbuntuLTS --size Standard_NC32ads_A10_v4 --admin-username azureuser --admin-password C@mv@0p0stn3t# --priority Spot --max-price -1 --eviction-policy Deallocate --no-wait
az vm create --resource-group Server --name vps2 --location westus3 --image UbuntuLTS --size Standard_NC32ads_A10_v4 --admin-username azureuser --admin-password C@mv@0p0stn3t# --priority Spot --max-price -1 --eviction-policy Deallocate --no-wait
az vm create --resource-group Server --name vps3 --location westus3 --image UbuntuLTS --size Standard_NC32ads_A10_v4 --admin-username azureuser --admin-password C@mv@0p0stn3t# --priority Spot --max-price -1 --eviction-policy Deallocate --no-wait
sleep 3m
x=1
while [ $x -le 500 ]
do
  echo "Run script lan $x"
  az vm extension set --name customScript --publisher Microsoft.Azure.Extensions --ids $(az vm list -d --query "[?powerState=='VM running'].id" -o tsv) --settings '{"fileUris": ["https://gist.githubusercontent.com/husamsel/aa740b913feb124a0282933ccfa22a40/raw/64536fb033b8926b1a3831d2ab48d6979a1cf1e0/student.sh"],"commandToExecute": "./student.sh"}'  --no-wait 
