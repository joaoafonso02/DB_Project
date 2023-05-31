#!/bin/bash

case "$OSTYPE" in
  darwin*)  
    sudo lsof -t -i tcp:5000 | sudo xargs kill
    sudo lsof -t -i tcp:5173 | sudo xargs kill
    ;; 
  linux*)   
    fuser 5000/tcp -k
    fuser 5173/tcp -k
    ;;
esac

if [ "$1" == "--dev" ]
then 
    docker start sql1
    sleep 3
fi

cd Backend
npm install
npm run dev &
cd ..

cd Frontend
npm install
npm run dev &
cd ..