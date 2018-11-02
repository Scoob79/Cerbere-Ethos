Ce script permet de surveiller un miner Ethos, il control le fichier de configuration, le hash, la connexion internet et la liaison avec la pool. En cas de manquemant, il envoie un pushbullet pour avertir un ou plusieurs utilisateur, ainsi que tout les périphériques d'un compte.

# Installation

- `nano cerbere.sh`
- copie collé du code
- Modifier les trois valeurs en haut (API_Key, pool et limit_hash)
* !!! Attention !!! la vérification de la liaison avec la pool est prévue pour cette pool (ravenminer) pour une autre pool il faudrat l'adapter
- ctrl+x

Le rendre executable
- `chmod +x ./cerbere.sh`


C'est tout :thumbsup:

# Utilisation

`./cerbere.sh` Lance la vérification et envoi un push s'il y a un problème

`./cerbere.sh --rapport` Lance la vérification, envoi un push s'il y a un problème sinon envoi un push avec un rapport

# Exemple de rapport

Fichier de configuration : OK

Connexion Internet : OK

Hash : OK

Vitesse actuelle du miner 23 /H

Liaison Pool : OK

Vitesse actuelle de la pool : 892 Th

# Adaptation du script

Pour Nanopool par exemple :

remplacer la ligne `retour=$(curl -s -X POST -H "Content-Type: application/json" $pool | jq .x16r.hashrate)` par `retour=$(curl -s -X GET -H "Content-Type: application/json" $pool | jq .data)`.

N'oubliez pas d'adapter la  division à la ligne suivante `let retour=$retour/1000000000`.

Le but étant via les API de récupérer le Hashrate de la pool.

# New version V2

Une version V2 a été créée avec la séparation de la partie pushbullet

### !!! ATTENTION elle necéssite le script Pushbullet disponible sur mon compte
https://github.com/Scoob79/Pushbullet

@KASPAR Olivier
