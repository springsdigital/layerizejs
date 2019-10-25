#!/bin/bash
read -p "What's the package name?: " packagename
if [ -d "$packagename" ]
  then
    echo "This lambda layer already exists, use upload_layer.sh"
    exit 1
fi
echo "Creating a lambda layer package for $packagename"
mkdir "$packagename"
cd "$packagename"
mkdir nodejs
cd nodejs
npm init -y >/dev/null
printf "\033[1;32mCreated package.json ✔\033[0m\n"
echo "Is the package scoped?"
read -p "[Y/n]:" scoped
if [ $scoped = Y ] || [ $scoped = y ] || [ $scoped = Yes ] || [ $scoped = yes ]
  then
    echo "Provide the full package with scope. Example: @scope/package"
    read -p "@scope/package: " scopedpackage
    echo "This is a scoped package. Installing $scopedpackage"
    npm i $scopedpackage &>/dev/null
    printf "\033[1;32mInstalled $scopedpackage ✔\033[0m\n"
  else
    echo "This is a not scoped package. Installing $packagename"
    npm i $packagename &>/dev/null
    printf "\033[1;32mInstalled $packagename ✔\033[0m\n"
fi
cd ..
zip -r nodejs.zip nodejs/ >/dev/null
printf "\033[1;32mLayer created ✔\033[0m\n"
echo "Do you want to upload the layer?"
read -p "[Y/n]:" upload
if [ $upload = Y ] || [ $upload = y ] || [ $upload = Yes ] || [ $upload = yes ]
  then
    echo "Uploading layer"
    aws lambda publish-layer-version --zip-file fileb://nodejs.zip --cli-input-json '{
        "LayerName": "'$packagename'",
        "Description": "'$packagename' for nodejs",
        "CompatibleRuntimes": [
            "nodejs10.x"
        ]
    }' >/dev/null
    printf "\033[1;32mUploaded ✔\033[0m\n"
    echo "The $packagename lambda layer was successfully created and uploaded"
  else
    echo "Goodbye"
fi
