#!/bin/bash

set -e

PROJECT_BASE_DIR="$PWD"
LIBRARY="$HOME/workspace/personal/project" # change this with install script!!
GITIGNORE_FILE="$LIBRARY/sample-gitignore"
BUILD_FILE="$LIBRARY/sample-build.gradle"

die()
{
    echo "$1" >&2
	exit 1
}

if [ -n "$1" ]; then 
    NAME=$1
else
    die "Specify a project name" 
fi 

if [ -z "$2" ]; then 
    JAVA_VERSION="11"
else 
    JAVA_VERSION=$2
fi

mkdir $NAME
cd $NAME

echo "# $NAME" > README.md

cat $GITIGNORE_FILE > .gitignore
sed "s/<<JAVA_VERSION>>/1.$JAVA_VERSION/" $BUILD_FILE > build.gradle

mkdir -p src/main/java src/test/java

git init
git add .gitignore README.md
git commit -m "Initial commit"

gradle wrapper --gradle-version 5.2.1
./gradlew -v # force download 
git add *gradle*
git commit -m "Add Gradle wrapper"

echo "Project is now ready to use in $PROJECT_BASE_DIR/$NAME"
