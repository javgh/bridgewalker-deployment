#!/bin/bash

# Bouncy Castle provider from http://www.bouncycastle.org/latest_releases.html
# Android uses version 1.46 of Bouncy Castle
# ( http://www.bouncycastle.org/download/bcprov-jdk15on-146.jar )
export CLASSPATH=/tmp/bcprov-jdk15on-146.jar

CERTSTORE=mykeystore.bks
if [ -a $CERTSTORE ]; then
    rm $CERTSTORE || exit 1
fi
keytool \
      -import \
      -v \
      -trustcacerts \
      -alias 0 \
      -file <(openssl x509 -in ../bridgewalker.crt) \
      -keystore $CERTSTORE \
      -storetype BKS \
      -provider org.bouncycastle.jce.provider.BouncyCastleProvider \
      -providerpath /usr/share/java/bcprov.jar \
      -storepass bridgewalker
