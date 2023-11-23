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
CMD ["npm", "start"]
