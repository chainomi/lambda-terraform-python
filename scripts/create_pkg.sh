cd $path_cwd

#make folder for code package with dependencies
mkdir $package_directory/

#empty package directory if it exists contains files
rm -rf $package_directory/*

#install dependencies in package directory
pip install -r ../$source_code_dir/requirements.txt --target ./$package_directory

#copy source code to package directory
cp -r ../$source_code_dir/* ./$package_directory
