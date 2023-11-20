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

git clone https://github.com/roxsross/bootcamp-devops-2023.git --single-branch --branch clase2-linux-bash

sed -i "s/\$dbPassword = \"\";/\$dbPassword = \"codepass\";/" "bootcamp-devops-2023/app-295devops-travel/config.php"

sed -i "s/\$dbHost     = \"localhost\"; /\$dbHost = \"db\";/" "bootcamp-devops-2023/app-295devops-travel/config.php"


docker-compose up -d

