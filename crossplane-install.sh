# install cluster kind 0-14
kind create cluster 
#check
kubectl cluster-info
kubectl get nodes

# install crossplane
kubectl create namespace crossplane-system
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm install crossplane --namespace crossplane-system crossplane-stable/crossplane
# check
helm list -n crossplane-system
kubectl get all -n crossplane-system

# install cli
curl -sL https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh | sh
sudo mv kubectl-crossplane /usr/local/bin
#check
kubectl crossplane --help

# install configuration
kubectl crossplane install configuration registry.upbound.io/xp/getting-started-with-aws-with-vpc:v1.8.1
# check
watch kubectl get pkg

# install credentials
kubectl create secret generic aws-creds -n crossplane-system --from-file=creds=/home/ec2-user/creds.conf 
kubectl apply -f https://raw.githubusercontent.com/crossplane/crossplane/release-1.8/docs/snippets/configure/aws/providerconfig.yaml



