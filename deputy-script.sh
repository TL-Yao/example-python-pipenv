#!/bin/bash
# initialize parameters
# identify pull request and push
# prepare upload path, request url
export SCANTIST_IMPORT_URL="https://api-deputy.scantist.io/ci-scan/"


show_project_info() {
  echo "=================show_project_info================="
  echo "TRAVIS_EVENT_TYPE $TRAVIS_EVENT_TYPE"
  echo "TRAVIS_BRANCH $TRAVIS_BRANCH"
  echo "TRAVIS_REPO_SLUG $TRAVIS_REPO_SLUG"
  echo "TRAVIS_PULL_REQUEST_SLUG $TRAVIS_PULL_REQUEST_SLUG"
  echo "TRAVIS_PULL_REQUEST $TRAVIS_PULL_REQUEST"
  echo "TRAVIS_PULL_REQUEST_BRANCH $TRAVIS_PULL_REQUEST_BRANCH"
  echo "TRAVIS_PULL_REQUEST_SHA $TRAVIS_PULL_REQUEST_SHA"
  echo "TRAVIS_COMMIT $TRAVIS_COMMIT"
  echo "=================project info====================="

  echo "=================travis info======================="
  echo "travis_dart_version: $TRAVIS_DART_VERSION"
  echo "travis_go_version: $TRAVIS_GO_VERSION"
  echo "travis_haxe_version: $TRAVIS_HAXE_VERSION"
  echo "travis_jdk_version: $TRAVIS_JDK_VERSION"
  echo "travis_julia_version: $TRAVIS_JULIA_VERSION"
  echo "travis_node_version: $TRAVIS_NODE_VERSION"
  echo "travis_otp_release: $TRAVIS_OTP_RELEASE"
  echo "travis_perl_version: $TRAVIS_PERL_VERSION"
  echo "travis_php_version: $TRAVIS_PHP_VERSION"
  echo "travis_python_version: $TRAVIS_PYTHON_VERSION"
  echo "travis_r_version: $TRAVIS_R_VERSION"
  echo "travis_ruby_version: $TRAVIS_RUBY_VERSION"
  echo "travis_rust_version: $TRAVIS_RUST_VERSION"
  echo "travis_scala_version: $TRAVIS_SCALA_VERSION"

}
show_project_info

repo_name=$TRAVIS_REPO_SLUG
commit_sha=$TRAVIS_COMMIT
branch=$TRAVIS_BRANCH
pull_request=$TRAVIS_PULL_REQUEST
build_time=$(date +"%s")
cwd=$(pwd)


#Log the curl version used
curl --version
curl -s https://scripts.scantist.com/staging/scantist-bom-detect.jar --output scantist-bom-detect.jar

java -jar scantist-bom-detect.jar -repo_name $repo_name -commit_sha $commit_sha -branch $branch -pull_request $pull_request -working_dir $cwd -build_time $build_time

#Exit with the curl command's output status
exit $?
