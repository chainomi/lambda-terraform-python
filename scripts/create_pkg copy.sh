#cd $path_cwd

package_directory = "python_code_package"

#make folder for code package with dependencies
mkdir $package_directory/

#copy source code to package directory
cp -r ./$source_code_dir/* ./$package_directory
