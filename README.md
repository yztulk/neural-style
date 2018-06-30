# neural-style

//Create a new instance on AWS with at least 12GB EBS. p2.xlarge is cheapest gpu aws instance at AUD 1.542 per hour. I used this AMI Ubuntu Server 16.04 LTS (HVM), SSD Volume Type - ami-963cecf4.

ssh deeplearning
//Install torch7
cd ~/
curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
git clone https://github.com/torch/distro.git ~/torch --recursive
sudo apt-get install build-essential cmake
sudo apt-get install libreadline-dev	
cd ~/torch; ./install.sh
source ~/.bashrc

//Install loadcaffe
sudo apt-get install libprotobuf-dev protobuf-compiler
luarocks install loadcaffe

//Install neural-style
cd ~/
git clone https://github.com/jcjohnson/neural-style.git
cd neural-style
sh models/download_models.sh

//Create directories and copy files
cd ~ && mkdir Documents && cd Documents
mkdir content && mkdir styles && mkdir outputs && mkdir scripts

//Run these commands from local terminal
cd ~/Documents/neural-style/jcjohnson_neural-style/
scp -i ~/.ssh/certificates/[filename].pem examples/inputs/* ubuntu@[ipaddress]:~/Documents/content
scp -i ~/.ssh/certificates/[filename].pem styles/* ubuntu@[ipaddress]:~/Documents/styles
scp -i ~/.ssh/certificates/[filename].pem ~/Documents/neural-style/fast-style-transfer-master/examples/style/* ubuntu@[ipaddress]:~/Documents/styles
scp -i ~/.ssh/certificates/[filename].pem content_image/* ubuntu@[ipaddress]:~/Documents/content
scp -i ~/.ssh/certificates/[filename].pem execution_script_aws.sh ubuntu@[ipaddress]:~/Documents/scripts

//Install CUDA
cd ~
wget https://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda-repo-ubuntu1604-9-2-local_9.2.88-1_amd64
sudo apt-key add /var/cuda-repo-9-2-local/7fa2af80.pub
sudo dpkg -i cuda-repo-ubuntu1604-9-2-local_9.2.88-1_amd64
sudo apt-get update
sudo apt-get install cuda

//Reboot aws instance
luarocks install cutorch
luarocks install cunn

//Install cuDNN
scp -i ~/.ssh/certificates/[filename].pem ~/Documents/neural-style/cudnn-7.0-linux-x64-v4.0-prod.tgz ubuntu@[ipaddress]:~/Documents/
cd ~/Documents && tar -xzvf cudnn-7.0-linux-x64-v4.0-prod.tgz
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64/
sudo cp cuda/include/cudnn.h /usr/local/cuda/include/
luarocks install cudnn

//Run neural-style
cd ~/neural-style && sh ~/Documents/scripts/execution_script_aws.sh

//Copy output to Mac - run from local terminal
scp -i ~/.ssh/certificates/[filename].pem ubuntu@[ipaddress]:~/Documents/outputs/* ~/Documents/neural-style/aws_outputs/

//remove outputs
rm ~/Documents/outputs/*

//edit deeplearning model
nano ~/Documents/scripts/execution_script_aws.sh
