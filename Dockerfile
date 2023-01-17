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