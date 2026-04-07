#!/bin/sh

sudo mkdir -p /etc/kanata
sudo cp ./kanata.kbd /etc/kanata/kanata.kbd
sudo install -m 644 ./kanata.service /lib/systemd/system/kanata.service
sudo systemctl daemon-reload
sudo systemctl start kanata
sudo systemctl enable kanata
