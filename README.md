# tower_populator

The purpose of this project is to populate an Ansible Tower installation from a configuration file.  

## Requirements

	pip install ansible-tower-cli 
	
**current version requires installation from tower-cli issue-9-unstable branch for dynamic group support**

make sure you have ```~/.tower_cli.cfg``` configured with something like:

cat << eof >>
[general]
host = http://tower.example.com
username = admin
password = admin
verify_ssl = false

eof

## Usage 
 
Usage is simple.  Declare the options you want in [config.yml](config.yml), and run the script:

```
./tower_populator config.yml

```

## Gotchas

tower-cli doesn't do everything the Tower UI does (yet), so there are some limitations:

1. All credential types use ```username``` and ```password``` as options, even AWS, Rackspace, etc.  This is a [known issue](https://github.com/ansible/tower-cli/issues/13).

