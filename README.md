# docker-images
Repo for local images focus on safe environment development.
The expected usage is build a proyect based on a docker-compose.yml file for cloud tools & ide env locally. 


## Repo Structure
    run.sh - helper to build images
    00_envs/ - environment files


## Build
    Of course can be called via 
    `docker-compose build`
    but preferable way to build is via helper script
    `. run.sh buildAll envfile`


## Images    
### End images
| image | description | 
| ---- | ---- | 
| intellij_ce | for java on Intellij community edition ide |
| tscode | for typescipt extensions on vscode ide |
| javacode | for java extensions vscode ide |
| pycode | for python extensions vscode ide |
| sfcode | for salesforce extensions vscode ide |
| solcode | for solidity extensions vscode ide |


#### access example to ide images
    rdesktop -u user -p user -g 1680x1024 localhost
    rdesktop -u user -p user -g 1920x1040 localhost




### cloud tools: (wip)
    google-cloud-sdk
    google-cloud-firebase-emulator
    aws-ekscli
    aws-sam


### intermediate builds:
    vscode - generic image with vscode ide and remote desktop access
    xrdp - remote desktop client 
    supervisord


### image options
#### pulse audio
    - define host: pulse.docker.internals on proyect docker-compose-file


#### video
https://askubuntu.com/questions/881305/is-there-any-way-ffmpeg-send-video-to-dev-video0-on-ubuntu
install ffmpeg on host

docker-compose up idea

rdesktop -u developer -p developer -g 1680x1024 localhost
rdesktop -u developer -p developer -g 1920x1040 localhost

#from: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip

#from: https://eksctl.io/installation/
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check
### package search ref
| distro | 
| ------ |
| [arch linux](https://archlinux.org/packages/?q=) |
| [debian search](https://packages.debian.org/search?keywords=nodejs) |
| [debian version at stable](https://packages.debian.org/stable/nodejs) |
| [debian version at testing](https://packages.debian.org/testing/nodejs) |
| [debian version at experimental](https://packages.debian.org/experimental/nodejs) |


### releases ref
| oficial | debian search | 
| ------- | ------------- |
| [java](https://docs.oracle.com/en/java/javase/) | https://packages.debian.org/search?keywords=openjdk |
| [nodejs](https://nodejs.org/en/about/previous-releases) | https://packages.debian.org/search?keywords=nodejs |

