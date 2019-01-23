#!/bin/bash

# retorna um alerta de uso caso não tenha sido passado nenhum argumento para o script

if [ $# -eq 0 ]; then
	echo "Use um parametro salvar (-s) ou restaurar (-r)."
	exit 1
fi

# salvando os timestamps originais no arquivo bkp-timestamps

if [ $1 = "-s" ]; then
	rm -f bkp-timestamps # deleta o backup se ele já existir
	ls -l | sed -n 's/^.*Jan/01/p;s/^.*Feb/02/p;s/^.*Mar/03/p;s/^.*Apr/04/p;s/^.*May/05/p;s/^.*Jun/06/p;s
/^.*Jul/07/p;s/^.*Aug/08/p;s/^.*Sep/09/p;s/^.*Oct/10/p;s/^.*Nov/11/p;s/^.*Dec/12/p;'
fi

# restaurando os timestamps originais

if [ $1 = "-r" ]; then
	# lê cada linha de bkp-timestamps
	cat bkp-timestamps | while read line
	do
		# pega a data e o nome do arquivo em cada linha
		MES=$(echo $line | cut -f1 -d\ )
		DIA=$(echo $line | cut -f2 -d\ )
		ARQUIVO=$(echo $line | cut -f4 -d\ )
		ANO=$(echo $line | cut -f3 -d\ )
		ANOCORRENTE=$(cal | head -1 | cut -f5- -d\ | sed 's/ //g')
		# restaura a data original com o uso de touch
		if [ $ANO == *:* ]; then
			touch -d $ANOCORRENTE-$MES-$DIA\ $ANO:00 $ARQUIVO;
		else
			touch -d ""$ANO-$MES-$DIA"" $ARQUIVO;
		fi
	done
fi
