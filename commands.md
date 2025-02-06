```
aws ec2 launch - ssh 

SG: ssh, http, https, 3000

cd Downloads
chmod 400 key.pem
ssh -i "key.pem" ec2-user@ec2-44-207-1-254.compute-1.amazonaws.com

sudo yum update -y
sudo yum install git -y
git --version

git config --global user.name "siddhi46"
git config --global user.email "siddhi.khaire46@gmail.com"
git config --list 

curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs
node -v
npm -v
npm install aws-sdk

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
terraform --version
terraform -help
terraform -help plan

git clone https://github.com/siddhi46/aws-seminar.git
cd aws-seminar/

sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo docker login

sudo docker build -t siddhi46/user-data-app .
sudo docker images
sudo docker push siddhi46/user-data-app

sudo docker run -d -p 3000:3000 siddhi46/user-data-app
sudo docker logs 3e6
```
