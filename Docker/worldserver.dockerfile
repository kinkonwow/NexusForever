FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ./Source/ ./
RUN dotnet restore ./NexusForever.WorldServer
RUN dotnet publish ./NexusForever.WorldServer -c Release -o out

WORKDIR /app/NexusForever.WorldServer/out/
RUN apt-get update && apt-get install -y unzip
RUN wget https://arctium.io/files/index.php\?f\=15c07193964ecf -O GameTable.zip
RUN unzip GameTable.zip -d tbl

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/NexusForever.WorldServer/out .
COPY --from=build-env /app/NexusForever.WorldServer/WorldServer.example.json WorldServer.json
EXPOSE 24000/tcp
ENTRYPOINT ["dotnet", "NexusForever.WorldServer.dll"]