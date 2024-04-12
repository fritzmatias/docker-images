clean_code_extensions(){
    echo remove $@
    rmDirs $@
}
echo @Var: $@
clean_code_extensions *.code_extensions