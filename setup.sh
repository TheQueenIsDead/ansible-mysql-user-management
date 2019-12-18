docker exec -it mysql-testing bash -c 'apt update -y && apt install python-pip -y && pip install PyMySQL'
docker exec -it mysql-staging bash -c 'apt update -y && apt install python-pip -y && pip install PyMySQL'
docker exec -it mysql-production bash -c 'apt update -y && apt install python-pip -y && pip install PyMySQL'
