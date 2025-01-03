# ubuntu and centos
# $os =

sudo apt-get update -y
sudo apt-get upgrade -y

# dependencies
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# turn off swap
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

# network setup
sudo modprobe br_netfilter
echo '1' | sudo tee /proc/sys/net/ipv4/ip_forward
sudo sysctl --system

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl start docker

# k8s
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update

sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


#sudo kubeadm join <master's-ip>:6443 --token abcdef.0123456789abcdef --discovery-token-ca-cert-hash sha256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
