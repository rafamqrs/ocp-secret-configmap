# Openshift ConfigMap y Secret Ejercicio

Un simple ejercicio a configurar una api con una base de datos atraves de configmap y secret.

## Objetivos
- Desplegar una api spring-boot.
- Cambiar los datos fijos de application.yaml a variables de ambiente.
- Configurar la api con configmaps y secrets.

## Pasos
- Hacer el desplegue de la api.
- Crear el secret y config de acuerdo con la necesidad.
- Cambiar los datos de deployment.
- Validar la API.
    - GET:
        - curl -v http://localhost:8080/student
    - POST:
        - curl --location --request POST 'http://localhost:8080/student' \
                --header 'Content-Type: application/json' \
                --data-raw '{
                    "id": 1,
                    "name": "Test",
                    "age": 30,
                    "email": "test@santander"}'

    
