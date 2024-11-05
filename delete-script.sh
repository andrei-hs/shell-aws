#!/bin/bash
#
# Andrei Henrique Santos & Italo Borges do Nascimento de Souza 

# Verificação se o argumento necessário foi enviado
if [ $# -ne 1 ]; then
    echo "Para rodar este script é necessário enviar o seguinte argumento: "
    echo "./delete-script.sh <nome-buckets3>"
    exit 1
fi

# Salva o valor fornecido na variável bucket_s3
bucket_s3=$1

# Requere a lista de arquivos que há dentro do bucket S3 na AWS
lista_arquivos_s3=$(aws s3api list-objects --bucket "$bucket_s3" --query 'Contents[].Key' --output text | tr '\t' '\n')

# Faz uma verificação se há algum arquivo dentro do bucket S3 e executa a exclusão de cada um deles 
if [ "$lista_arquivos_s3" != "None" ]; then
    total_linhas=$(echo "$lista_arquivos_s3" | wc -l)

    linha=1

    # Gera um loop aonde ele irá percorrer de arquivo em arquivo na lista excluindo um por um
    while (( linha <= total_linhas )); do
        arquivo=$(echo "$lista_arquivos_s3" | sed -n "${linha}p")
        aws s3 rm "s3://${bucket_s3}/${arquivo}"
        ((linha++))
    done
fi

