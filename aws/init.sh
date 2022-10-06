#! /bin/sh

AWS_PROFILE=nsite
AWS_ZONE=us-east-1a
command -v aws > /dev/null 2>&1 && {
  aws-ec2-instances-id() {
     aws --profile ${AWS_PROFILE} ec2 describe-instances  --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,PublicDnsName:PublicDnsName,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name,Id:InstanceId,Zone:Placement.AvailabilityZone}" |\
       fzf | tr -d ' ' | cut -d '|' -f 2
  }
  aws-ec2-instances-dns() {
     aws --profile ${AWS_PROFILE} ec2 describe-instances  --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,PublicDnsName:PublicDnsName,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name,Id:InstanceId,Zone:Placement.AvailabilityZone}" |\
       fzf | tr -d ' ' | cut -d '|' -f 4
  }


aws-ec2-send-key(){
  aws-ec2-instances-id | xargs -I{}\
     aws ec2-instance-connect send-ssh-public-key --profile ${AWS_PROFILE} --instance-id {} --availability-zone ${AWS_ZONE} --instance-os-user ubuntu --ssh-public-key file://~/.ssh/id_rsa.pub
}

aws-ec2-instance-connect(){
  aws-ec2-instances-dns | xargs -I{}\
    ssh -ttt ubuntu@{}
}

  alias aec2i=aws-ec2-instances-id
  alias aec2k=aws-ec2-send-key
}

