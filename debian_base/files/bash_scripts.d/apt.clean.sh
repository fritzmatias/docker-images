cleanApt(){
	apt-get clean \
	&& rmDirs \
	 	'/var/lib/apt/lists/*' \
		'/var/cache/apt/archives/partial/*' \
		'/var/cache/apt/archives/*' \
		'/etc/apt/sources.list.d/*' \
		;
}

cleanApt