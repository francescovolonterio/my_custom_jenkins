#!/bin/bash
shopt -s extglob

################################### FUNCTIONS

usage()
{
  echo "This script will be used to automate the start and stop of the Jenkins Image."
  echo ""
  echo "Possible Values are"
  echo "-b                      to create the image and launch the cotainer (on port 1234)"
  echo "-s                      to start the Jenkkis Instance (on port 1234)"
  echo "-e                      to stop the Jenkins Instance"
  echo "-k                      to clean the Jenkins Instance (It will clear the container and the image)" 
  echo "-h                      to get this help"
 exit 2
}


################################# MAIN

while getopts 'skhbe' OPTION; do
  case "$OPTION" in
    s)
      docker-compose up -d
      ;; 
    b) 
      docker build -t jenkins_custom .  
      docker-compose up -d 
      ;;
    e)
      docker stop $(docker ps -aq --filter "name=jenkins-corner")
      ;;
    k)
      docker-compose down
      docker rmi $(docker images 'jenkins_custom' -a -q)
      basefolder=${PWD}
      cd $basefolder/jenkins_data && rm -rf !("casc.yaml"|"plugins.txt")
      ;;
    h)
      echo "Option c used"
      ;;

    ?) 
      usage
      exit 1
      ;;
  esac
done
