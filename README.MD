# DyWA Docker image 

DyWA offers user-driven development of process-oriented web applications. The approach combines business process modeling with user-side application domain evolution. In the center is the DyWA framework that accompanies the prototype-driven web-application development from the domain modeling through the development and deployment phase to the actual runtime and later product evolution. Using DyWA, application experts without programming knowledge are able to model (using their professional knowledge and understanding) both domain-specific data models and the business process models that act on the data via automatically generated elementary data operations. The resulting business processes integrate data access and manipulation, and directly constitute executable prototypes of the resulting web applications.

## Usage

### Docker run

#### Bash
```bash
docker run -it -p 8080:8080 --volume=${PWD}/h2:/opt/jboss/wildfly/standalone/data/h2:rw --volume=${PWD}/files:/opt/jboss/wildfly/standalone/data/files:rw --name=dywa scce/dywa:0.6-dime-9
```

#### Fish
```fish
docker run -it -p 8080:8080 --volume={$PWD}/h2:/opt/jboss/wildfly/standalone/data/h2:rw --volume={$PWD}/files:/opt/jboss/wildfly/standalone/data/files:rw --name=dywa scce/dywa:0.6-dime-9
```