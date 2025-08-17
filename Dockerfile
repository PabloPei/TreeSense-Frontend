FROM ubuntu:20.04 AS build

ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    python3 \
    xz-utils \
    zip \
    ca-certificates \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=dialog

WORKDIR /home/flutter

# Clonar Flutter desde git (versión más reciente)
RUN git clone -b stable https://github.com/flutter/flutter.git flutter

# Establecer PATH
ENV PATH="/home/flutter/flutter/bin:${PATH}"

# Configurar git
RUN git config --global --add safe.directory /home/flutter/flutter

# Actualizar a la última versión estable
RUN cd flutter && git pull && flutter upgrade

# Configurar para web
RUN flutter config --enable-web --no-analytics
RUN flutter precache --web

# Directorio de trabajo para la app
WORKDIR /home/flutter/app

# Copiar archivos de configuración
COPY --chown=flutter:flutter pubspec.yaml pubspec.lock ./

# Instalar dependencias
RUN flutter pub get

# Copiar código fuente
COPY --chown=flutter:flutter . .

# Build para web
RUN flutter build web --release

# Etapa final con nginx
FROM nginx:alpine

# Copiar build
COPY --from=build /home/flutter/app/build/web /usr/share/nginx/html

# Copiar configuración nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Exponer puerto
EXPOSE 80

# Ejecutar nginx
CMD ["nginx", "-g", "daemon off;"]