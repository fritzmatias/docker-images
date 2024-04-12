node_clean(){
	if npm --version 2>/dev/null; then 
		npm cache clean --force
	else
		return 0
	fi
}

node_clean