#!/bin/bash
#Variable
repo="https://github.com/roxsross/bootcamp-devops-2023.git"
file="bootcamp-devops-2023"
branch="clase2-linux-bash"
app_path="app-295devops-travel"
USERID=$(id -u)

config_file="/etc/apache2/mods-enabled/dir.conf"
db_php="bootcamp-devops-2023/app-295devops-travel/config.php"
#colores
LRED='\033[1;31m'
LGREEN='\033[1;32m'
NC='\033[0m'
LBLUE='\033[0;34m'
LYELLOW='\033[1;33m'



if [ "${USERID}" -ne 0 ]; then
    echo -e "\n${LRED}Correr con usuario ROOT${NC}"
    exit
fi 

echo "====================================="
apt-get update

#### git ######

echo -e "\n${LGREEN}El Servidor se encuentra Actualizado ...${NC}"

if dpkg -s git > /dev/null 2>&1; then
    echo -e "\n${LBLUE}GIT se encuentra ya instalado ...${NC}"
else    
    echo -e "\n${LYELLOW}instalando GIT ...${NC}"
    apt install -y git
fi

git clone https://github.com/roxsross/bootcamp-devops-2023.git --single-branch --branch ejercicio2-dockeriza

# Ruta del directorio donde se creará el Dockerfile
backDirectory="./bootcamp-devops-2023/295topics-fullstack/backend"
frontDirectory="./bootcamp-devops-2023/295topics-fullstack/frontend"

# Nombre del archivo Dockerfile
dockerfile="Dockerfile"

# Contenido del Dockerfile
backContent="
# Usa una imagen oficial de Node.js como base
FROM node:20-alpine

# Establece el directorio de trabajo en la aplicación
WORKDIR /usr/src/app

# Copia los archivos necesarios para la instalación de dependencias
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto de la aplicación
COPY . .

# Compila la aplicación TypeScript
RUN npm run build

# Expone el puerto en el que la aplicación estará escuchando
EXPOSE 5000

# Comando para iniciar la aplicación
CMD [\"npm\", \"start\"]
"
frontContent="
# Usa una imagen oficial de Node.js como base
FROM node:20-alpine

# Establece el directorio de trabajo en la aplicación
WORKDIR /usr/src/app

# Copia los archivos necesarios para la instalación de dependencias
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto de la aplicación
COPY . .


# Expone el puerto en el que la aplicación estará escuchando
EXPOSE 3000

# Comando para iniciar la aplicación
CMD [\"node\", \"server.js\"]
"

# Crear el Dockerfile
echo "$backContent" > "$backDirectory/$dockerfile"
echo "$frontContent" > "$frontDirectory/$dockerfile"



docker-compose up -d

