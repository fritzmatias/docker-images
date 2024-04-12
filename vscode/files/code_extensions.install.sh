code_install(){
local extensionDir="$1"
local extensionFiles=$(find "${extensionDir}" -name *".code_extensions" )
	echo "files: $extensionFiles"
	for e in $(cat "${extensionFiles}"| grep -v '#'); do 
		sudo -iu ${DOCKER_USER} code --force --install-extension "${e}" ; 
	done;
}

code_install  $@
	