#!/usr/bin/env bash

sites=./`basename "$0"`
root=/etc/nginx/
www=/usr/share/nginx/html
avail=${root}sites-available/
enab=${root}sites-enabled/

add() {
    sudo cp nginx.${1} ${avail}nginx.${1}
    sudo nano ${avail}nginx.${1}
}

enable() {
    ${sites} clean
    sudo ln -s ${avail}nginx.${1} ${enab}nginx.${1}
    ${sites} restart
    sudo mkdir -p ${www}
    sudo mv ${www} ${www}.$(date +%s)
    sudo mkdir -p ${www}
    sudo cp -R ../${1}/* ${www}
}

case $1 in
    add)
        add $2
    ;;
    enable)
        enable $2
    ;;
    clean)
        sudo rm ${enab}*
    ;;
    install)
        sudo apt install nginx
    ;;
    restart)
        sudo service nginx restart
    ;;
esac
