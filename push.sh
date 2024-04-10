#!/bin/zsh
# Authoer: Rakuyo
# Update Date: 2024.04.10

project_path=$(cd `dirname $0` ; pwd)

cd $project_path

echo "Please enter version："
read version
echo "Start publishing a new version: ${version}"

release(){
    release_branch=release/${version}
    
    git checkout -b ${release_branch} main
    
    git_message="[Release] version: ${version}"
    
    git add . && git commit -m "${git_message}"
    
    git checkout main
    git merge --no-ff -m 'Merge branch '${release_branch}'' ${release_branch}
    git push origin main
    git tag ${version}
    git push origin ${version}
    git branch -d ${release_branch}
}

release
