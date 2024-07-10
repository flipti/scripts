#!/bin/bash

# Obtém uma lista de todos os projetos ativos do GCP
projects=$(gcloud projects list --format="value(projectId)")

# Loop através de cada projeto
for project in $projects; do
    # echo "Executando operações no projeto: $project"
    
    # Obtém uma lista de todas as instâncias no projeto
    instances=$(gcloud compute instances list --project=$project --format="value(name)")

    # Loop através de cada instância
    for instance in $instances; do
        echo "Executando operações na instância: $instance" >> saida.txt
        
        # Comandos que você deseja executar na instância
        # Exemplo: Obter deviceName e licenses da instância
        gcloud compute instances describe $instance --project=$project --format="table(guestAccelerators[].acceleratorType,networkInterfaces[0].accessConfigs[0].natIP,disks[].licenses)" >> saida.txt
        
        echo "-------------------------------------"
    done
    
    echo "-------------------------------------"
done
