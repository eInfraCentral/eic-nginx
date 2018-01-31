#!/usr/bin/env bash

sites=./`basename "$0"`
root=/etc/nginx/
www=/usr/share/nginx/html
avail=${root}sites-available/
enab=${root}sites-enabled/

install() {
    sudo cp nginx.${1} ${avail}nginx.${1}
    sudo nano ${avail}nginx.${1}
}

enable() {
    ${sites} clean
    sudo ln -s ${avail}nginx.${1} ${enab}nginx.${1}
    ${sites} restart
}

case $1 in
    install)
        install $2
    ;;
    enable)
        enable $2
        case $2 in
            proxy)
            ;;
            maintenance)
                sudo mkdir -p ${www}
                sudo mv ${www} ${www}.$(date +%s)
                sudo mkdir -p ${www}
                sudo cp -R ../UnderMaintenance/* ${www}
            ;;
        esac
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
