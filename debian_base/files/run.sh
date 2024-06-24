[ "${DOCKER_BASH_SCRIPTS_DIR}"x = x ] && DOCKER_BASH_SCRIPTS_DIR="/bash_scripts.d"

rmDirs(){
for dir in $@;
do
	echo "removing dir: $dir"
	rm -rf "$dir";
done;
}

clean(){
local SCRIPT_DIR="$1" 
[ $"SCRIPT_DIR"x = x ] && SCRIPT_DIR="${DOCKER_BASH_SCRIPTS_DIR}"
local ret=0
	echo "cleaning by scripts on at: $SCRIPT_DIR"
	for script in $(find ${SCRIPT_DIR} -name *".clean."* ); do
		. "${script}"
		local r=$?;
		echo "calling clean: ${script} : exit $r"
		[ $r -eq 0 ] || ret=$r
	done
	return $ret
}

APTenableSources(){
	local DISABLED_SOURCES=/etc/apt/sources.list.disable
	local ENABLED_SOURCES=/etc/apt/sources.list.d
	local sources=$@
	echo "enabling sources: ${sources}"

	[ "$sources"x = x ] && echo "Warning using default value" && sources=stable
	for source in $sources; do
		local files=$(find "$DISABLED_SOURCES" -name *'.'"$source"'.'* )
		echo "enabling source: ${sources} with file: $files"
		for file in $files; do
			[ -f "$file" ] && ln -s "$file" "${ENABLED_SOURCES}" 2>/dev/null || (echo "source: $file for: $source, not found" && exit 1)
		done
	done
	# ls -1 "${ENABLED_SOURCES}"
}

APTupdate(){
local sources=$@
	[ "$sources"x = x ] && sources="$DEBIAN_TARGETS"
	APTenableSources $sources \
	&& apt-get -y update 
}
APTupgrade(){
	APTupdate $@ \
    && apt-get -y --no-install-recommends dist-upgrade 
}
APTinstall(){
local PKGS=$@;
	APTupdate
	echo "Installing ${PKGS}"
	for pkg in ${PKGS};do
		apt-cache policy ${pkg}
		apt-get install -y "${pkg}"
		local r=$?
		if [ $r -eq 0 ]; then
			echo "Installed: ${pkg} : $?"
		else
			echo "Error on $pkg"
			exit $r
		fi
	done
	clean 
}

env
$@
