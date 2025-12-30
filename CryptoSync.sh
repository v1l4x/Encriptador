#!/bin/bash

# Paleta de colores
fin="\033[0m"
negro="\033[0;30m"
marron="\033[0;31m"
azul_claro="\033[0;32m"
azul="\033[0;34m"
magenta="\033[0;35m"
lila="\033[0;36m"
amarillo="\033[1;31m"
pistacho="\033[1;32m"
blanco="\033[1;33m"
cyan="\033[1;34m"
salmon="\033[1;35m"
amarillo_claro="\033[1;36m"

# Funciones

function handle_ctrl_c() {
  clear
  echo -e "\n${amarillo_claro}Saliendo...${fin}\n"
  exit 1
}

trap handle_ctrl_c SIGINT

function menu_principal() {
  echo -e "\n${cyan}[+]${fin}${blanco} Elige qué cifrado quieres realizar:${fin}\n"
  echo -e "${blanco}0.${fin} ${amarillo}Salir${fin} \n"
  echo -e "${azul}1.${fin} ${azul_claro}Claves GPG${fin} \n"
  echo -e "${azul}2.${fin} ${azul_claro}Md5${fin} \n"
}

function salir() {
  echo -e "${amarillo_claro}Saliendo...${fin}"
  exit 1
}

function menu_gpg() {
    
    echo -e "${azul}4.${fin} ${azul_claro}Desencriptar un archivo.${fin} \n" 
  
    while true; do
    echo -e "${cyan}[+]${fin} ${blanco}Elige la opción que quieres realizar:${fin} \n"
    echo -e "${blanco}0.${fin} ${amarillo}Volver al menú principal.${fin} \n"
    echo -e "${azul}1.${fin} ${azul_claro}Generar claves GPG nuevas.${fin} \n"
    echo -e "${azul}2.${fin} ${azul_claro}Exportar la clave pública.${fin} \n"
    echo -e "${azul}3.${fin} ${azul_claro}Encriptar un archivo.${fin} \n"
    echo -e "${azul}4.${fin} ${azul_claro}Desencriptar un archivo.${fin} \n"
    read -p "$(echo -e ${cyan}[?]${fin} ${blanco}"Elige una opción: "${fin})" opcion_gpg
    clear

    case $opcion_gpg in
      0)
        clear
        menu_principal
        return
        ;;
      1)
        claves_gpg_nuevas
        ;;
      2)
        exportar_clave_publica
        ;;
      3)
        encriptar_archivo
        ;;
      4) 
        desencriptar_archivo
         ;;
      *)
        echo -e "\n ${magenta}[¡]${fin} ${lila}Opción no válida. Por favor, elige una opción válida.${fin} \n"
        ;;
    esac
  done
}

function desencriptar_archivo() {
  read -p "$(echo -e "\n ${blanco}[/]${fin} ${salmon}Ingresa la ruta del archivo que deseas desencriptar: ${fin}")" archivo

  if [ -f "$archivo" ]; then
    read -s -p "$(echo -e "\n ${blanco}[P]${fin}${salmon} Ingresa tu contraseña: ${fin}")" contrasena
    clear
    echo -e "\n"  
    echo "$contrasena" | gpg --batch --passphrase-fd 0 --decrypt "$archivo"
    clear
    echo -e "\n ${blanco}[OK]${fin}${pistacho} El archivo ha sido desencriptado correctamente. ${fin} \n"
  else
    clear
    echo -e "\n ${magenta}[¡]${fin}${lila} El archivo especificado no existe o no se encuentra en la ruta. ${fin} \n"
  fi
}


function encriptar_archivo() {
  read -p "$(echo -e "\n ${blanco}[/]${fin} ${salmon}Ingresa la ruta del archivo que deseas encriptar: ${fin}")" archivo
  read -p "$(echo -e "\n ${blanco}[N]${fin} ${salmon}Ingresa el Nombre de usuario de la clave pública: ${fin}")" usuario

  if [ -f "$archivo" ]; then
    gpg --encrypt --recipient "$usuario" "$archivo"
    clear
    echo -e "\n ${blanco}[OK]${fin}${pistacho} El archivo ha sido encriptado correctamente. ${fin} \n"
  else
    clear
    echo -e "\n ${magenta}[¡]${fin}${lila} El archivo especificado no existe o no se encuentra en la ruta. ${fin} \n"
  fi
}

function exportar_clave_publica() {
  if [ -d ~/.gnupg/openpgp-revocs.d ]; then
    archivo_clave=$(find ~/.gnupg/openpgp-revocs.d -name "*.rev" | head -n 1)

    if [ -n "$archivo_clave" ]; then
      id_clave=$(basename "$archivo_clave" | sed 's/\.rev$//')
      gpg --armor --export "$id_clave" > directorio/donde/este/la/clave
      echo -e "\n ${blanco}[OK]${fin}${pistacho} La clave pública ha sido exportada con éxito.${fin} \n"
    else
      echo -e "\n ${magenta}[¡]${fin}${lila} Error: No se encontró ningún archivo con la clave pública.${fin} \n"
    fi
  else
    echo -e "\n ${magenta}[¡]${fin}${lila} Error: No se encontró el directorio ~/.gnupg/openpgp-revocs.d.${fin} \n"
  fi
}

function claves_gpg_nuevas() {
  read -p "$(echo -e "\n ${blanco}[@]${fin}${salmon} Ingresa tu dirección de correo electrónico: ${fin}")" email
  clear
  read -p "$(echo -e "\n ${blanco}[N]${fin}${salmon} Ingresa tu nombre: ${fin}")" nombre
  clear
  read -s -p "$(echo -e "\n ${blanco}[*]${fin}${salmon} Ingresa tu contraseña: ${fin}")" contrasena
  echo ""   
  echo "$contrasena" | gpg --batch --passphrase-fd 0 --quick-generate-key "$nombre <$email>"
  clear
  echo -e "\n ${blanco}[OK]${fin}${pistacho} Claves GPG generadas correctamente.${fin} \n"
}

function menu_md5() {
  while true; do
    echo -e "\n${cyan}[+]${fin} ${blanco}Elige la opción que quieres realizar:${fin} \n"
    echo -e "${blanco}0.${fin} ${amarillo}Volver al menú principal.${fin} \n"
    echo -e "${azul}1.${fin} ${azul_claro}Encriptar un archivo.${fin} \n"
    echo -e "${azul}2.${fin} ${azul_claro}Verificar un archivo con hash MD5${fin} \n"
        
    read -p "Opción: " opcion_md5
    clear

    case $opcion_md5 in 
      0)
        clear
        menu_principal
        return
        ;;
      1)
        encriptar_archivo_md5
        ;;
      2)
        verificar_archivo_md5
        ;;
      *)
        echo -e "\n ${magenta}[¡]${fin} ${lila}Opción no válida. Por favor, elige una opción válida.${fin} \n"
        ;;
    esac
  done
}

function verificar_archivo_md5() {
  read -p "$(echo -e "\n ${blanco}[/]${fin} ${salmon}Ingresa la ruta del archivo que deseas verificar: ${fin}")" archivo

  if [ ! -f "$archivo" ]; then
    echo -e "\n ${magenta}[¡]${fin}${lila} El archivo especificado no existe o no se encuentra en la ruta. ${fin} \n"
    return
  fi

  read -p "$(echo -e "\n ${blanco}[?]${fin}${salmon} Ingresa el hash MD5 del archivo: ${fin}")" hash_md5_ingresado
  hash_md5_calculado=$(md5sum "$archivo" | awk '{print $1}')

  if [ "$hash_md5_calculado" = "$hash_md5_ingresado" ]; then
    clear
    echo -e "\n ${blanco}[OK]${fin}${pistacho} El archivo es válido. El hash MD5 coincide.\n ${fin}"
  else
    clear
    echo -e "\n ${magenta}[¡]${fin}${lila} El archivo es corrupto. El hash MD5 no coincide.\n ${fin}"
  fi
}

function encriptar_archivo_md5() {
  read -p "$(echo -e "\n ${blanco}[/]${fin} ${salmon}Ingresa la ruta del archivo que deseas encriptar: ${fin}")" archivo

  if [ -f "$archivo" ]; then
    resultado=$(md5sum "$archivo" | awk '{print $1}')
    read -p "$(echo -e "\n ${blanco}[/]${fin}${salmon} Ingresa la ruta donde deseas guardar el archivo .txt: ${fin}")" ruta
    echo "$resultado" > "${ruta}/hash_md5.txt"
    clear
    echo -e "\n ${blanco}[OK]${fin}${pistacho} El hash MD5 del archivo ha sido guardado en ${ruta}/hash_md5.txt correctamente.\n ${fin}"
  else
    clear
    echo -e "\n ${magenta}[¡]${fin}${lila} Error: El archivo especificado no existe en la ruta proporcionada.\n ${fin}"
  fi
}

clear

# Ejecución del script
menu_principal

while true; do
  read -p "$(echo -e ${cyan}[?]${fin} ${blanco}"Elige una opción: "${fin})" opcion
  clear

  case $opcion in
    0)
      salir
      ;;
    1)
      menu_gpg
      ;;
    2)
      menu_md5
      ;;   
    *)
      echo -e "\n ${magenta}[¡]${lila} Opción no válida. Por favor, elige una opción válida.\n ${fin}"
      ;;  
  esac
done
