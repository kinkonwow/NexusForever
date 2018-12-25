FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ./Source/ ./
RUN dotnet restore ./NexusForever.StsServer
RUN dotnet publish ./NexusForever.StsServer -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/NexusForever.StsServer/out .
COPY --from=build-env /app/NexusForever.StsServer/StsServer.example.json StsServer.json
EXPOSE 6600/tcp
ENTRYPOINT ["dotnet", "NexusForever.StsServer.dll"]