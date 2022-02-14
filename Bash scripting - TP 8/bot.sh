# Catedra: Arquitectura y Sistemas Operativos. - TUP UTN FRBB
# Profesor: Marco Ustarroz
# Año: 2021
# Alumno: Herbosa Ezequiel
# Video del script: https://youtu.be/SZsreZ7diJ8


!/bin/bash	
echo $" ---------------------------------"
echo $"       Buen dia," $USER$"."       
echo $" ---------------------------------"
echo $" SUS OPCIONES PARA HOY MI REY:"
echo 
echo $"1) Reloj."
echo $"2) Clima hoy."
echo $"3) Frase motivacional."
echo $"4) Calidad del aire hoy."
echo $"5) Adivinar Numero secreto."
echo $"6) Borrar registros del juego."
echo $"7) Mostrar dia con mas jugadas."
echo $"8) Borrar pantalla."
echo $"9) Salir."
echo $" ---------------------------------"

while [[ true ]]; do
	
	echo $"Seleccion: "; read input;


	case $input in

	1)
	echo $" ---------------------------------"
	echo "La hora es:" $(date +%R) $(date +%p) "mi lord.";
	echo $" ---------------------------------"
	;;

	2)
	echo $" ---------------------------------"
	echo "Aquí le dejo el reporte del clima patroncito: " && curl wttr.in/BHI?0;
	echo $" ---------------------------------"
	;;

	3)
	echo $" ---------------------------------"
	echo "Aquí tiene una frase que hara su día mas bonito:" && curl -s https://frasedeldia.azurewebsites.net/api/phrase |\jq --raw-output '.phrase'
	echo $" ---------------------------------"
	;;

	4)
	echo $" ---------------------------------"
	echo ""
	echo "CALIDAD DEL AIRE EN BAHIA BLANCA:"
	echo "Polvo en suspension (ppm):" && curl -s https://gobiernoabierto.bahia.gob.ar/WS/3040 | jq '.[0]["valor"]'
	echo "Estado:" && curl -s https://gobiernoabierto.bahia.gob.ar/WS/3040 | jq '.[0]["estado"]'
	echo "";
	echo "Velocidad del viento (km/h)" && curl -s https://gobiernoabierto.bahia.gob.ar/WS/3040 | jq '.[6]["valor"]'
	echo "";
	echo "Los demas sensores se encuentran fuera de servicicio o con problemas tecnicos";
	echo $" ---------------------------------"
	;;

	5) 
		num_random=$(( $RANDOM % 10 + 1 ))

		try=10
		corte=3
		contar_intentos=1
		let partidas_jugadas++

		#-----------------------------------------------------
		# crear carpeta y nombre de archivo:

		fecha=$(date +%F)
		mkdir -p /home/$USER/numero_secreto/$fecha
		cd /home/$USER/numero_secreto/$fecha/

		generar_nombre_archivo=$(date +%T)
		#-----------------------------------------------------
	
		echo "Numero secreto:"
		echo ""
		sleep .50
		echo "Tenes que adivinar un numero entre 1 y 10"
		sleep .75
		echo "Empeza arriesgando el primer numero"



		for (( i=1 ; i <= $try ; i++ )) ; do
			read numero

			# -1 para escape
			if [[ $numero -eq -1 ]]; then
				echo "juego finalizado, partida anulada"
				let partidas_jugadas--
				break
			fi

			if [[ "$numero" -ne "$num_random" ]]; then
				let contar_intentos++
			fi

			if [ "$numero" == "$num_random" ] && [ "$i" -le "$corte" ]; then
				echo "Excelente! adivinaste en $contar_intentos intentos!!"
				echo "$contar_intentos intentos para adivinar el numero: $num_random" >> $generar_nombre_archivo
				sleep 1
			break

			elif [ "$numero" == "$num_random" ] && [ "$i" -gt "$corte" ]; then
				echo "¡ Bien! el número secreto era "$num_random"!"
				echo "  Lo adivinaste en $contar_intentos intentos"
				echo "$contar_intentos intentos para adivinar el numero: $num_random" >> $generar_nombre_archivo
			break
			fi

			if [ "$i" -ge "$try" ] ; then
				echo ""
			        echo "Se acabaron los intentos :'("
			        echo "La re manqueaste aca bro jajaja" >> $generar_nombre_archivo
				sleep 0.2
			
				echo "por si te interesa el numero era $num_random"
				sleep 0.5
				echo "No era tan dificil. ¬¬ "
		        break

			elif [ "$numero" -gt "$num_random" ]; then
				echo "El numero es menor..."

			elif [ "$numero" -lt "$num_random" ]; then
				echo "El numero es mayor"
			fi

			done

			;;


	6)
	rm -r /home/ezee/numero_secreto/*
	echo $" ---------------------------------"
	echo "Se han eliminado TODOS los registros alamacendados en home/$USER/numero_secreto"
	echo $" ---------------------------------"
	;;

	7)
	echo $" ---------------------------------"
	echo "A continuacion se muestra cuantas jugadas realizó y que día tuvo mayor actividad:"
	sleep 1
	cd /home/$USER/numero_secreto/
	find $numero_secreto -type f -exec dirname {} \; | sort | uniq -c | sort -nr | head -1
	echo $" ---------------------------------"
	# Marco, este punto en particular me costo bastante googlie y googlie pero me termino ayudando un compañero al final, 
	# prefiero apelar a la sinceridad.

	;;

	8)
	clear
	echo $" ---------------------------------"
	echo $"1) Reloj."
	echo $"2) Clima hoy."
	echo $"3) Frase motivacional."
	echo $"4) Calidad del aire hoy."
	echo $"5) Adivinar Numero secreto."
	echo $"6) Borrar registros del juego."
	echo $"7) Mostrar dia con mas jugadas."
	echo $"8) Borrar pantalla."
	echo $"9) Salir."
	echo $" ---------------------------------"
	;;

	9)
	echo $" ---------------------------------"
	echo "Muchas gracias, vuelva prontos"; exit 
	echo $" ---------------------------------"
	;;

		


	*)
	echo $" ---------------------------------"
	echo $"1) Reloj."
	echo $"2) Clima hoy."
	echo $"3) Frase motivacional."
	echo $"4) Calidad del aire hoy."
	echo $"5) Adivinar Numero secreto."
	echo $"6) Borrar registros del juego."
	echo $"7) Mostrar dia con mas jugadas."
	echo $"8) Borrar pantalla."
	echo $"9) Salir."
	echo $" ---------------------------------"
	;;
	esac


done






