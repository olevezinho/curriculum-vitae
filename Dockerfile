FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app
COPY CurriculumVitae.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o out

FROM docker.io/library/nginx:alpine AS final
WORKDIR /app
EXPOSE 80

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/out/wwwroot /usr/share/nginx/html

##############
# OLD SCRIPT # 
##############
# FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
# WORKDIR /src
# COPY CurriculumVitae.csproj .
# RUN dotnet restore CurriculumVitae.csproj
# COPY . .
# RUN dotnet build CurriculumVitae.csproj -c Release -o /app/build

# FROM build AS publish
# RUN dotnet publish CurriculumVitae.csproj -c Release -o /app/publish

# FROM docker.io/library/nginx:alpine AS final
# WORKDIR /usr/share/nginx/html
# COPY --from=publish /app/publish/wwwroot .
# COPY nginx.conf /etc/nginx/nginx.conf