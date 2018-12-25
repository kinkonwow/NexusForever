FROM mysql:latest

COPY ./Database/Base/Auth.sql /docker-entrypoint-initdb.d/01.sql
COPY ./Database/Base/Character.sql /docker-entrypoint-initdb.d/02.sql
COPY ./Database/Base/World.sql /docker-entrypoint-initdb.d/03.sql

COPY ./Database/Updates/Auth/* /docker-entrypoint-initdb.d/
COPY ./Database/Updates/Character/* /docker-entrypoint-initdb.d/
COPY ./Database/Updates/World/* /docker-entrypoint-initdb.d/