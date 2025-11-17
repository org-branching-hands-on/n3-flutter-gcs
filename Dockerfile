# Stage 1: Build o app Flutter Web
FROM dart:3.3 AS build

# Instala o SDK do Flutter (Isso pode ser otimizado)
RUN apt-get update && apt-get install -y git curl unzip
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter precache
RUN flutter config --enable-web

# Define o diretório de trabalho
WORKDIR /app

# Copia o código e baixa dependências
COPY pubspec.* ./
RUN flutter pub get
COPY . .

# Build o app web
RUN flutter build web --release

# Stage 2: Serve com Nginx
FROM nginx:alpine
# Copia o build do stage anterior
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

