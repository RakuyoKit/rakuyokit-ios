#!/bin/zsh
# Authoer: Rakuyo
# Update Date: 2024.04.25

project_path=$(cd `dirname $0` ; pwd)

cd $project_path

echo "Please enter version："
read version
echo "Start publishing a new version: ${version}"

git_merge() {
    local from_branch=$1
    local to_branch=$2
    local merge_message=$3

    git checkout "$to_branch"
    git merge --no-ff -m "$merge_message" "$from_branch" --no-verify
    git_push "$to_branch" --no-verify
}

git_push() {
    git push origin "$1" --no-verify
}

release(){
    main_branch="main"
    release_branch=release/${version}

    git checkout -b ${release_branch} ${main_branch}

    git_message="release: version ${version}"
    git add . && git commit -m "${git_message}" --no-verify

    git_merge "$release_branch" "$main_branch" "Merge branch '$release_branch'"

    git tag ${version}
    git_push ${version}

    git branch -d ${release_branch}
}

release
