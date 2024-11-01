#!/bin/bash
#
# Andrei Henrique Santos & Italo Borges do Nascimento de Souza 

bucket_s3="nome-bucket"

lista_arquivos_s3=$(aws s3api list-objects --bucket "$bucket_s3" --query 'Contents[].Key' --output text | tr '\t' '\n')

if [ "$lista_arquivos_s3" != "None" ]; then
    total_linhas=$(echo "$lista_arquivos_s3" | wc -l)

    linha=1

    while (( linha <= total_linhas )); do
        arquivo=$(echo "$lista_arquivos_s3" | sed -n "${linha}p")
        aws s3 rm "s3://${bucket_s3}/${arquivo}"
        ((linha++))
    done
fi

