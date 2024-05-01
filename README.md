# TER-STOCK
From L3 licence

## Description
Il s'agit d'une application de gestion de stock développée dans le cadre d'un projet universitaire.


# Côté back :
- npm install mysql2
- npm install express
- npm install dotenv
- npm install jsonwebtoken
- npm install uuid
- npm install nodemailer
- npm install otp-generator

## Installation de sequelize-auto
Pour installer `sequelize-auto` et ses dépendances, exécutez les commandes suivantes :

- npm install mysql2
- npm install sequelize-auto
- npm install sequelize-auto mysql2

## Utilisation
Utilisez la commande suivante pour générer des modèles Sequelize à partir de votre base de données :

-sequelize-auto -h <host> -d <database> -u <user> -x [password] -p [port] --dialect [dialect] -c [/path/to/config] -o [/path/to/models] -t [tableName]
exemple :
npx sequelize-auto -h 127.0.0.1 -d stock -u root -x {MOT DE PASSE} --dialect mysql -o ./LOGIN/model

Exemple Windows : 

node ./node_modules/sequelize-auto/bin/sequelize-auto -h localhost -d hivestock -u root -x hai501 -p 3306 --dialect mysql -o ../testAutoSeq/models

Assurez-vous de remplacer les paramètres entre crochets par les valeurs spécifiques à votre configuration.



