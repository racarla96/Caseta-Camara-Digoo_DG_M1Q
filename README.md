# Caseta Camara Digoo DG M1Q

Este tutorial trata de documentar los pasos seguidos para conectar una camara Digoo DG M1Q y añadir funcionalidades y bloquear el envío de información a terceros.

#### IMPORTANTE

ESTE TUTORIAL ESTA PROBADO PARA LA VERSIÓN ANTIGUA

Existen dos versiones de la cámara:

ANTIGUA
![](img_old_cam.jpg)
NUEVA
![](img_new_cam.jpg)


## Requisitos
- Una tarjeta SD (uso temporal)
- Adaptador USB a Serie (3.3V) + Cables Dupont (requerido sólo - paso 1 - opción 1)

![](img_USB_serial_converter.jpg)


## Paso 1 - Conectar la cámara al WiFi

El primer paso consiste en poder configurar la red WiFi a al cuál vamos a conectar la cámara. 

Debemos abrir la cámara quitando los 4 tornillos con un destornillador de estrella. Teniendo cuidado al separar las dos partes, porque el altavoz esta pegado a la parte trasera. Una vez abierto, podemos identificar los tres conectores (agujeros), como podemos ver en la siguiente figura.

![](img_camera_board_pinout_serial.png)

Aquí irá conectado el convertidor de usb a serie que podemos ver en la siguiente figura.

![](img_USB_serial_converter.jpg)

La conexión del cableado debe seguir el patrón descrito en la siguiente imagen. 

![](img_serial_rxtx.png)

Tendremos algo parecido a esto.

![](img_camara_board_to_serie.jpg)


Conectamos el USB, y abrimos una aplicación como Putty o podría ser incluso el IDE de Arduino, la configuración para ver la salida del puerto serie es 115200.

Y enchufamos la cámara, veremos que empieza a salir por la ventana un montón de lineas de información, esperamos un minuto a que inicie el sistema.

Por último, debemos copiar la siguiente linea, cambiando YOURSSID por el nombre del Wifi y YOURPSK por la contraseña del WiFi, debe ser un WiFi con seguridad WPA2.

Una vez modificada y preparada, copiamos esta linea de código a la ventana, y pulsamos intro. Esperamos dos minutos más a que lea el fichero en algún momento y ya estará conectada a la WiFi.

echo 'ctrl_interface=/etc/Wireless\nnetwork={\n    ssid="YOURSSID"\n    psk="YOURPSK"\n}' > /rom/wpa_supplicant0.conf


## Paso 2 - En desarrollo - Hack persistente con mejoras

El hack tiene estas nuevas funciones
- Elimina y bloquea la comunicación con los servicios en la nube.
- Habilita un servidor SSH - usuario: , password: 

- Servidor RTSP/onvif en la dirección IP de la cámara


La version ANTIGUA es una versión permite escritura de sus archivos. Vamos a instalar el siguiente HACK.

Conectamos la SD al PC, formateamos la SD en FAT32, y descargamos el hack zsgx1hacks-v0.4.zip del siguiente enlace o desde este repositorio.

- https://github.com/ant-thomas/zsgx1hacks

Una vez descargado, descomprimimos los archivos y los copiamos a la SD, podemos modificar el config.txt para hacer el hack persistente, os recomiendo primero probar el hack y luego si funciona, hacerlo persistente. O bien dejar la SD puesta.

Este hack tiene las siguientes funciones:

- No communication to cloud services
- RTSP/onvif server on the IP address of the camera (VLC)
- SSH server

rtsp://admin:20160404@192.168.1.6/onvif1

#### Trozo de un script a añadir
# setup and install dropbear ssh server
cp /home/hack/dropbearmulti /bin/dropbearmulti
mkdir /etc/dropbear
cp /home/hack/dropbear_ecdsa_host_key /etc/dropbear/dropbear_ecdsa_host_key
/bin/dropbearmulti dropbear

# sync the time
¿ (sleep 20 && ntpd -q -p es.pool.ntp.org ) & ?

Ya podemos desconectar la cámara de la luz, retirar el cableado y cerrarla.

# References
- https://github.com/yuvadm/DG-M1Q (Saber que fichero editar que se ejecuta cuando se inicia la cámara)
- https://github.com/rc042/DG-M1Q ()
- https://github.com/kfowlks/DG-M1Q (Información clara para conectarte por RTSP)
- https://github.com/ant-thomas/zsgx1hacks (Hacks para camaras con el mismo chip)

https://github.com/dc35956/gk7102-hack

https://robert.penz.name/1348/hikam-a7-iot-security-at-its-worst/
https://jumpespjump.blogspot.com/2015/09/how-i-hacked-my-ip-camera-and-found.html?m=1
