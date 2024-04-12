homes_clean(){
	rmDirs '~/*' '/root/*' "$HOME/*"
}

homes_clean