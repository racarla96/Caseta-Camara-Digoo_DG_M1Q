#!/bin/sh

# Creamos la carpeta
mkdir /rom/postconf

# Establemos una nueva contraseña para root
passwd root

# Copiamos los archivos nuevos
cp /etc/passwd /rom/postconf/passwd
cp /etc/shadow /rom/postconf/shadow

# Actualizamos el fichero con el nuevo boot.sh
cp /mnt/disc1/dropbearmulti /rom/postconf/dropbearmulti
cp /mnt/disc1/dropbear_ecdsa_host_key /rom/postconf/dropbear_ecdsa_host_key

# Sustituimos el archivo dhcp.script
cp /npc/dhcp.script /npc/dhcp.script.orig
cp /mnt/disc1/dhcp.script /npc/dhcp.script

# Añadimos los comandos necesarios al boot.sh
cp /npc/boot.sh /npc/boot.sh.orig
cat /mnt/disc1/add_to_boot_sh >> /npc/boot.sh