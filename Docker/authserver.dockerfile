FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ./Source/ ./
RUN dotnet restore ./NexusForever.AuthServer
RUN dotnet publish ./NexusForever.AuthServer -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/NexusForever.AuthServer/out .
COPY --from=build-env /app/NexusForever.AuthServer/AuthServer.example.json AuthServer.json
EXPOSE 23115/tcp
ENTRYPOINT ["dotnet", "NexusForever.AuthServer.dll"]