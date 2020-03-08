pip install -r requirements.yaml --user

cat << eof > ~/.tower_cli.cfg 
host: tower.example.com
username: admin
password: admin
verify_ssl: False
eof



kubectl create ns tower

kubectl config set-context --current --namespace=tower

curl https://raw.githubusercontent.com/geerlingguy/tower-operator/master/deploy/tower-operator.yaml| sed 's/default/tower/g' | kubectl apply -f -

kubectl apply -f - << eof

apiVersion: tower.ansible.com/v1alpha1

kind: Tower

metadata:

  name: tower

  namespace: tower

spec:

  tower_hostname: tower.example.com

  tower_secret_key: admin

  tower_task_image: ansible/awx_task:9.1.1

  tower_web_image: ansible/awx_web:9.1.1

  tower_admin_user: admin

  tower_admin_email: admin@example.com

  tower_admin_password: admin

eof

cat << EOF >> tower_delete.sh

kubectl delete -f - << eof

apiVersion: tower.ansible.com/v1alpha1

kind: Tower

metadata:

  name: tower

  namespace: tower

spec:

  tower_hostname: tower.example.com

  tower_secret_key: aabbcc

  tower_task_image: ansible/awx_task:9.1.1

  tower_web_image: ansible/awx_web:9.1.1

  tower_admin_user: admin

  tower_admin_email: admin@example.com

  tower_admin_password: admin

eof

EOF

