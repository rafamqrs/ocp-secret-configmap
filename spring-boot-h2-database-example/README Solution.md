# Openshift ConfigMap y Secret Ejercicio

Un ejercicio simple para configurar la API con la base de datos usando configmap y secret según su conocimiento.

La API contiene un archivo de propiedades con los datos de conexión a la base de datos como: url, usuario y clave.

## Objetivos
Debe cambiar los valores fijos para usar los valores que proporcionará el secreto/mapa de configuración que creará

## Pasos
1 - Crear el secret y configmap de acuerdo con la necesidad.
-----
kind: ConfigMap
apiVersion: v1
metadata:
  name: santander-db-cm
data:
  OPENSHIFT_H2_DB_HOST: 'jdbc:h2:mem:javatpoint'
-----
kind: Secret
apiVersion: v1
metadata:
  name: santander-db-secret
data:
  OPENSHIFT_H2_PASSWORD: c2E=
  OPENSHIFT_H2_USERNAME: c2E=
type: Opaque
----

## Los valores del usuario y clave son *sa* en base64

2 - Añadir referencia de configmap y secret al deployment.
.....
template:
    spec:
        containers:
            env:
                - name: OPENSHIFT_H2_DB_HOST
                valueFrom:
                    configMapKeyRef:
                    name: santander-db-cm
                    key: OPENSHIFT_H2_DB_HOST
                - name: OPENSHIFT_H2_USERNAME
                valueFrom:
                    secretKeyRef:
                    name: santander-db-secret
                    key: OPENSHIFT_H2_USERNAME
                - name: OPENSHIFT_H2_PASSWORD
                valueFrom:
                    secretKeyRef:
                    name: santander-db-secret
                    key: OPENSHIFT_H2_USERNAME
.....
3 - Cambie los datos del archivo application.properties para usar los valores de la secret/configmap     
```console
    spring.datasource.url=${OPENSHIFT_H2_DB_HOST}
    spring.datasource.driverClassName=org.h2.Driver
    spring.datasource.username=${OPENSHIFT_H2_USERNAME}
    spring.datasource.password=${OPENSHIFT_H2_PASSWORD}
    spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
```
4 - desplegar la api a Openshift con Jenkins.

5 - Validar la API.
    Dentro de la consola openshift abra POD y vaya a la pestaña Terminal, luego ejecute los comandos
    - POST:
        - curl --location --request POST 'http://localhost:8080/student' \
                --header 'Content-Type: application/json' \
                --data-raw '{
                    "id": 1,
                    "name": "Test",
                    "age": 30,
                    "email": "test@santander"}'
    - GET:
        - curl -v http://localhost:8080/student    
