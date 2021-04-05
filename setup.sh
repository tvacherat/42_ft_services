#!/bin/bash

YELLOW="\e[93m"
GREEN="\e[92m"
RESET="\e[0m"
APPS=("nginx" "mysql" "phpmyadmin" "ftps" "wordpress" "grafana" "influxdb")

setup_vm()
{
	minikube delete &> /dev/null
	sudo apt update &> /dev/null
	sudo curl -L "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl &> /dev/null
	sudo curl -L https://storage.googleapis.com/minikube/releases/v1.13.1/minikube-linux-amd64 -o /usr/local/bin/minikube &> /dev/null
	sudo chmod +x /usr/local/bin/kubectl /usr/local/bin/minikube &> /dev/null
	sudo usermod -aG docker ${USER} && newgrp docker
	echo "VM's ready !"
}

clear ()
{
	minikube delete
	kubectl delete -f srcs/configmap/
	kubectl delete -f srcs/deployments/
	kubectl delete -f srcs/services/
	docker system prune
	docker rmi $(docker images -a -q)
}

init_kube ()
{
	minikube delete
	minikube start --driver=docker --cpus=2
	eval $(minikube docker-env)
	minikube addons enable metrics-server
	minikube addons enable dashboard
	minikube addons enable metallb
	kubectl apply -f srcs/configmap/metallb.yaml
}

build_images ()
{
	for image in "${APPS[@]}"
	do
		echo -e "${YELLOW}Building ${image} container...${RESET}"
		docker build srcs/containers/${image}/. -t "${image}_img" | grep Step
		echo -e "${GREEN}${image}'s image has been build !${RESET}"
	done
}

mount_volumes ()
{
	volumes=("influxdb" "mysql")
	for vol in "${volumes[@]}"
	do
		echo -e "${YELLOW}Mounting ${vol} volumes...${RESET}"
		kubectl apply -f srcs/volumes/volume_${vol}.yaml
		echo -e "${GREEN}${vol}'s volume has been mounted !${RESET}"
	done

}

deploy ()
{
	for deploy in "${APPS[@]}"
	do
		echo -e "${YELLOW}Deploy ${deploy}...${RESET}"
		kubectl apply -f srcs/deployments/deploy_${deploy}.yaml
		echo -e "${GREEN}${deploy} has been deploy !${RESET}"
	done
}

start_services ()
{
	for service in "${APPS[@]}"
	do
		echo -e "${YELLOW}Start ${service} service...${RESET}"
		kubectl apply -f srcs/services/service_${service}.yaml
		echo -e "${GREEN}${service}'s service is up !${RESET}"
	done
}

if [[ "$#" -gt 1 ]]
then
	echo "Invalid number of arguments."
	exit 1
elif [[ "$#" == 1 ]]
then	
	if [[ "$1" == "setup" ]]
	then
		setup_vm
		exit
	
	elif [[ "$1" == "clear" ]]
	then
		clear
		exit
	else
		echo "Invalid argument."
		exit 1
	fi
fi
init_kube
build_images
mount_volumes
deploy
start_services
kubectl get services
echo -e "${YELLOW}grafana:${RESET} admin:admin\n${YELLOW}wordpress/phpmyadmin:${RESET} wp_admin:password\n${YELLOW}ftps${RESET}: ftp_admin:password"
