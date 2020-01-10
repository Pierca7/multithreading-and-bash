#!/bin/bash
#------------------------------------------------------
# PALETA DE COLORES
#------------------------------------------------------
#setaf para color de letras/setab: color de fondo
    red=`tput setaf 1`;
    green=`tput setaf 2`;
    blue=`tput setaf 4`;
    bg_blue=`tput setab 4`;
    reset=`tput sgr0`;
    bold=`tput setaf bold`;
#------------------------------------------------------
# VARIABLES GLOBALES
#------------------------------------------------------
proyectoActual="/home/sor1";
proyectos="/home/sor1/Documents/repo_GitLab/repos.txt";

#------------------------------------------------------
# DISPLAY MENU
#------------------------------------------------------
imprimir_menu () {
	imprimir_encabezado "\t  S  U  P  E  R  -  M  E  N U ";

	echo -e "\t\t El proyecto actual es:";
	echo -e "\t\t $proyectoActual";

	echo -e "\t\t";
	echo -e "\t\t Opciones:";
	echo "";
	echo -e "\t\t\t a.  Ver version del Kernel";
	echo -e "\t\t\t b.  Arquitectura del CPU";
	echo -e "\t\t\t c.  Identificar CPU";
	echo -e "\t\t\t d.  Identificar las 10 primeras interrupciones";        
	echo -e "\t\t\t e.  Identificar la memoria SWAP";
	echo -e "\t\t\t f.  Identificar la memoria principal";
	echo -e "\t\t\t g.  Identificar la placa de video";
	echo -e "\t\t\t h.  Identificar el idioma del teclado";    
	echo -e "\t\t\t "
	echo -e "\t\t\t Funcion: buscar";
	echo -e "\t\t\t Funcion: crearusuario";
	echo -e "\t\t\t Funcion: redireccion"; 
	echo -e	"\t\t\t Funcion: ejecutarcomandos"; 
	echo "";
	echo -e "\t\t\t q.  Salir";
	echo "";
	echo -e "Escriba la opción y presione ENTER";
}

#------------------------------------------------------
# FUNCTIONES AUXILIARES
#------------------------------------------------------

imprimir_encabezado () {
    clear;
    #Se le agrega formato a la fecha que muestra
    #Se agrega variable $USER para ver que usuario está ejecutando
    echo -e "`date +"%d-%m-%Y %T" `\t\t\t\t\t USERNAME:$USER";
    echo "";
    #Se agregan colores a encabezado
    echo -e "\t\t ${bg_blue} ${red} ${bold}--------------------------------------\t${reset}";
    echo -e "\t\t ${bold}${bg_blue}${red}$1\t\t${reset}";
    echo -e "\t\t ${bg_blue}${red} ${bold} --------------------------------------\t${reset}";
    echo "";
}

esperar () {
    echo "";
    echo -e "Presione enter para continuar";
    read ENTER ;
}

malaEleccion () {
    echo -e "Selección Inválida ..." ;
}


decidir () {
    echo $1;
    while true; do
            read -n 1 -p "desea ejecutar? (s/n)" respuesta </dev/tty;
            case $respuesta in
                [Nn]* ) break;;
                   [Ss]* ) eval $1
                break;;
                * ) echo "Por favor tipear S/s ó N/n.";;
            esac
    done
}	

#------------------------------------------------------
# FUNCTIONES del MENU
#------------------------------------------------------
a_funcion () {
        imprimir_encabezado "\tOpción a.  Version del Kernel";
	echo la version del Kernel es:
       	uname;
	#decidir "ls -l";
}

b_funcion () {
           imprimir_encabezado "\tOpción b";
	   uname -m;
	   #completar
}

c_funcion () {
          imprimir_encabezado "\tOpción c";
          cat /proc/cpuinfo 
	  #completar       
}

d_funcion () {
    imprimir_encabezado "\tOpción d";
    cat /proc/interrupts | head -11;
    #completar
}


e_funcion () {
    imprimir_encabezado "\tOpción e";        
    echo "---------------------consultar--------------------------";
    free -m;
    # grep 'SwapTotal' /proc/meminfo;
    echo "---------------------consultar--------------------------";
    #completar
}


f_funcion () {
    imprimir_encabezado "\tOpcion f";
    df -h;
    #completar
}

g_funcion () {
    imprimir_encabezado "\tOpcion g";
    echo Modelo de placa de video: 
    lspci | grep VGA;
    #completar
}

h_funcion () {
    imprimir_encabezado "\tOpcion h";
    setxkbmap -query;
	#completar
}

buscar_funcion() {
	read -p 'Ingrese el nombre del programa a buscar  ' -r prog;
	dpkg -l | grep $prog;
}
 
crearUsuario_funcion(){
	read -p 'Ingrese el nombre de usuario ' -r nombre;
	sudo useradd -g sudo $nombre;
	echo Ingrese la contraseña;
	sudo passwd $nombre
	
	su $nombre
}

redireccion_funcion(){
	read -p 'Ingrese el usuario  ' -r usuario;
	less /var/log/auth.log | grep $usuario > $usuario.txt 
	vi $usuario.txt

}

leer_funcion(){
	imprimir_encabezado "\t Ejecutar Comandos"
	let nrolinea=0
	dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
	while  read -r var
	  do
	    firstChar="${var:0:1}"
	    if [ "$firstChar" == "#" ] ;then
		echo "$var"
	    elif [ "$firstChar" == "" ] ;then
		echo ""
		echo ""
	    else
		let nrolinea++
		echo "----------------------------------"
		echo -e "user@maquina: $dir\n"
		echo ""
		echo "linea $nrolinea: $var"
		decidir "$var"
	    fi
	done < "comandos.txt"
}

#------------------------------------------------------
# LOGICA PRINCIPAL
#------------------------------------------------------
while  true
do
	# 1. mostrar el menu
    imprimir_menu;
    # 2. leer la opcion del usuario
    read opcion;
    
    case $opcion in
        a|A) a_funcion;;
        b|B) b_funcion;;
        c|C) c_funcion;;
        d|D) d_funcion;;
        e|E) e_funcion;;
	f|F) f_funcion;;
	g|G) g_funcion;;
	h|H) h_funcion;;
	buscar|BUSCAR) buscar_funcion ;;
	crearusuario | CREARUSUARIO) crearUsuario_funcion;;
	redireccion | REDIRECCION) redireccion_funcion;;
	ejecutarcomandos | EJECUTARCOMANDOS) leer_funcion;;
		
		q|Q) break;;
        *) malaEleccion;;
    esac
    esperar;
done
 

