#!/bin/bash
read -p "What's the layer name (without lambda-layer-nodejs)?: " packagename
echo "Updating a lambda layer package for $packagename"
cd "$packagename"
cd nodejs
npm update >/dev/null
printf "\033[1;32mUpdated ✔\033[0m\n"
echo "Packing layer"
cd ..
if [ -f nodejs.zip ]
  then
  rm nodejs.zip >/dev/null
fi
zip -r nodejs.zip nodejs/ >/dev/null
printf "\033[1;32mPacked ✔\033[0m\n"
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
    echo "The $packagename lambda layer was successfully updated and uploaded"
  else
    echo "Goodbye"
fi
