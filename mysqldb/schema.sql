CREATE USER 'bn_mediawiki' IDENTIFIED BY 'Passw0rd';
CREATE DATABASE bitnami_mediawiki;
GRANT ALL PRIVILEGES ON bitnami_mediawiki.* TO 'bn_mediawiki';
FLUSH PRIVILEGES;
