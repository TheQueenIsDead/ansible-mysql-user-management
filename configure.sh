ANSIBLE_NOCOWS=1 ansible-playbook playbook.yml -i inventory -l testing;
ANSIBLE_NOCOWS=1 ansible-playbook playbook.yml -i inventory -l staging;
ANSIBLE_NOCOWS=1 ansible-playbook playbook.yml -i inventory -l production;
