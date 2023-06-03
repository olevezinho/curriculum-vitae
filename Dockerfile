#FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build-env
#RUN apk add nodejs
#RUN apk add npm
#WORKDIR /app
#COPY . ./

#RUN npm --prefix Web install
#RUN dotnet publish CurriculumVitae.csproj -c Release -o output

#FROM nginx:alpine
#WORKDIR /user/share/nginx/html
#COPY --from=build-env /app/output/wwwroot .
#COPY nginx.conf /etc/nginx/nginx.conf
#EXPOSE 80
##############
# OLD SCRIPT # 
##############
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY CurriculumVitae.csproj .
RUN dotnet restore CurriculumVitae.csproj
COPY . .
RUN dotnet build CurriculumVitae.csproj -c Release -o /app/build

FROM build AS publish
RUN dotnet publish CurriculumVitae.csproj -c Release -o /app/publish

FROM docker.io/library/nginx:alpine AS final
WORKDIR /usr/share/nginx/html
COPY --from=publish /app/publish/wwwroot .
COPY nginx.conf /etc/nginx/nginx.conf