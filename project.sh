#!/bin/bash

set -eu

START_PWD=$(pwd)
GITIGNORE_FILE="sample-gitignore"
BUILD_FILE="sample-build.gradle"

die()
{
    echo "$1" >&2
	cd $START_PWD
	exit 1
}

NAME=$1
if [ -z "$NAME" ]; then die "Specify a project name"; fi 

mkdir $NAME
cd $NAME

echo "# $NAME" > README.md

cat $GITIGNORE_TEMPLATE_FILE > .gitignore
cat $BUILD_FILE > build.gradle

mkdir -p src/main/java src/test/java

git init
git add .gitignore README.md
git commit -m "Initial commit"

gradle wrapper --gradle-version 5.2.1
./gradlew -v # force download now
git add *gradle*
git commit -m "Add Gradle wrapper"


cd $START_PWD

