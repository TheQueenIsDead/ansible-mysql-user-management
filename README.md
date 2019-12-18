# ansible.mysql

This repos holds configuration as code config and playbook files for configuring mysql
credentials for users and services.

## Todo

- Add in the same configuration for services, and test (Per host config).
- Ascertain and document how removing a user looks declaratively.

## Usage

The `inventory` file holds a list of all mysql instances in a given environment.
This app largely relies on the assertion that users will have access to environments as opposed
to specific database instances.
Services should work with limits and host-names, but this can be ascertained later.

The `vars/users.yml` file holds a list of users and a list of environments they should have access to.

Running the playbook for a specific `-l` of an environment (for example, `-l testing`) will add all users with the 
`testing` environment to each mysql instance in the inventory.

As of current, users can not be given explicit hosts to join. This may be rectified with the use of groups, but it not
yet implemented.

## Pre-requesites

The host requires a MySQL python module installed, which can be done with the following command

```bash
# Debian hosts
apt update -y && apt install python-pip -y && pip install PyMySQL
```

This should have been taken care of by your previous configuration management steps

## Demo

To run the demo, clone this repository and run the following

```bash
# Allow execute rights on helper demo scripts
chmod +x setup.sh reset.sh grants.sh
# Bring up the demo mysql instances
docker-compose up -d
# Setup the necessary python packages for ansible
./setup.sh
# Check out the grants per env
./grants.sh
# Run the script
ansible-playbook playbook.yml -i inventory -l testing -v
# Verify the testing hosts have been updated (Dougal and David have users, but John does not)
./grants.sh
# Run the playbook on the other two environments
ansible-playbook playbook.yml -i inventory -l staging -v
ansible-playbook playbook.yml -i inventory -l production -v
# Verify David and Dougal have staging access (Not John) and only David has a production account
./grants.sh
# Tada! You can reset the mysql grants with ./rest.sh instead of bringing up the docker environment again
```

### Credentials

Database
u: root
p: example

## Handy MySQL

### Grants

```bash
mysql> select distinct grantee from information_schema.user_privileges;
+--------------------------------+
| grantee                        |
+--------------------------------+
| 'mysql.infoschema'@'localhost' |
| 'mysql.session'@'localhost'    |
| 'mysql.sys'@'localhost'        |
| 'root'@'localhost'             |
| 'duffyboy'@'localhost'         |
| 'dgilroy'@'localhost'          |
| 'dking'@'localhost'            |
| 'root'@'%'                     |
+--------------------------------+
8 rows in set (0.00 sec)
```

### Revoke and drop a user
```bash
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'duffyboy'@'localhost';
DROP USER 'duffyboy'@'localhost';
```

On newer versions,
```bash
apt install default-libmysqlclient-dev
pip install MySQL-python
```

ansible 2.5.1.
