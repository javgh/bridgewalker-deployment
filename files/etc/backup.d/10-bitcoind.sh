#!/bin/bash

BACKUP_WALLET=/var/backups/backupninja/bitcoind/wallet.dat
if [ -f $BACKUP_WALLET ]; then
    rm $BACKUP_WALLET
fi

cd /home/jan/bitcoind/
sudo -u jan ./bitcoind backupwallet $BACKUP_WALLET
