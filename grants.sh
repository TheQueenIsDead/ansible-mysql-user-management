echo "Testing grants"
docker exec mysql-testing mysql -u root --password=example -e "select distinct grantee from information_schema.user_privileges;"
echo "Staging grants"
docker exec mysql-staging mysql -u root --password=example -e "select distinct grantee from information_schema.user_privileges;"
echo "Production grants"
docker exec mysql-production mysql -u root --password=example -e "select distinct grantee from information_schema.user_privileges;"