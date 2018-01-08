# DyWA Docker image 

DyWA offers user-driven development of process-oriented web applications. The approach combines business process modeling with user-side application domain evolution. In the center is the DyWA framework that accompanies the prototype-driven web-application development from the domain modeling through the development and deployment phase to the actual runtime and later product evolution. Using DyWA, application experts without programming knowledge are able to model (using their professional knowledge and understanding) both domain-specific data models and the business process models that act on the data via automatically generated elementary data operations. The resulting business processes integrate data access and manipulation, and directly constitute executable prototypes of the resulting web applications.

## Docker

```bash
docker run -it -p 8080:8080 --volume=${PWD}/h2:/opt/jboss/wildfly/standalone/data/h2:rw --volume=${PWD}/files:/opt/jboss/wildfly/standalone/data/files:rw --name=dywa scce/dywa:latest
```
```fish
docker run -it -p 8080:8080 --volume={$PWD}/h2:/opt/jboss/wildfly/standalone/data/h2:rw --volume={$PWD}/files:/opt/jboss/wildfly/standalone/data/files:rw --name=dywa scce/dywa:latest
```

## Docker compose

```yml
version: '3.2'

networks:
  postgres:

services:
  wildfly:
    depends_on:
      - postgres
    networks:
      - postgres
    image: scce/dywa:0.7
    ports:
      - "8080:8080"
    volumes:
      - type: volume
        source: wildfly
        target: /opt/jboss/wildfly
  postgres:
    environment:
      - "POSTGRES_DB=dywa"
      - "POSTGRES_PASSWORD=sa"
      - "POSTGRES_USER=sa"
    image: scce/dywa-postgres:latest
    networks:
      - postgres
    ports:
      - "5432:5432"

volumes:
  wildfly:
```
