#!/bin/bash
#   ▄████████    ▄████████    ▄████████ ▀█████████▄     ▄████████    ▄████████    ▄████████
#  ███    ███   ███    ███   ███    ███   ███    ███   ███    ███   ███    ███   ███    ███
#  ███    █▀    ███    █▀    ███    ███   ███    ███   ███    █▀    ███    ███   ███    █▀
#  ███         ▄███▄▄▄      ▄███▄▄▄▄██▀  ▄███▄▄▄██▀   ▄███▄▄▄      ▄███▄▄▄▄██▀  ▄███▄▄▄
#  ███        ▀▀███▀▀▀     ▀▀███▀▀▀▀▀   ▀▀███▀▀▀██▄  ▀▀███▀▀▀     ▀▀███▀▀▀▀▀   ▀▀███▀▀▀
#  ███    █▄    ███    █▄  ▀███████████   ███    ██▄   ███    █▄  ▀███████████   ███    █▄
#  ███    ███   ███    ███   ███    ███   ███    ███   ███    ███   ███    ███   ███    ███
#  ████████▀    ██████████   ███    ███ ▄█████████▀    ██████████   ███    ███   ██████████
#                            ███    ███                             ███    ███

 ##########################################################################################
#  Ce script permet de surveiller un miner Ethos, il control le fichier de configuration,  #
#   le hash, la connexion internet et la liaison avec la pool. En cas de manquemant, il    #
#    envoie un pushbullet pour avertir un ou plusieurs utilisateur, ainsi que tout les     #
#                             périphériques d'un compte.                                   #
 ##########################################################################################
#        Crée le 25/10/2018 Par KASPAR Olivier @ mail : olivier.kaspar@gmail.com           #
 ##########################################################################################

# Liste des paramétrages
API_Key="o.XwShYtgQ3h3QU7c1lOJ2kNFkz8n0uen4"
pool="https://ravenminer.com/api"
limit_hash=18

aide () {
echo "
   ▄████████    ▄████████    ▄████████ ▀█████████▄     ▄████████    ▄████████    ▄████████
  ███    ███   ███    ███   ███    ███   ███    ███   ███    ███   ███    ███   ███    ███
  ███    █▀    ███    █▀    ███    ███   ███    ███   ███    █▀    ███    ███   ███    █▀
  ███         ▄███▄▄▄      ▄███▄▄▄▄██▀  ▄███▄▄▄██▀   ▄███▄▄▄      ▄███▄▄▄▄██▀  ▄███▄▄▄
  ███        ▀▀███▀▀▀     ▀▀███▀▀▀▀▀   ▀▀███▀▀▀██▄  ▀▀███▀▀▀     ▀▀███▀▀▀▀▀   ▀▀███▀▀▀
  ███    █▄    ███    █▄  ▀███████████   ███    ██▄   ███    █▄  ▀███████████   ███    █▄
  ███    ███   ███    ███   ███    ███   ███    ███   ███    ███   ███    ███   ███    ███
  ████████▀    ██████████   ███    ███ ▄█████████▀    ██████████   ███    ███   ██████████
                            ███    ███                             ███    ███

 ##########################################################################################
#  Ce script permet de surveiller un miner Ethos, il control le fichier de configuration,  #
#   le hash, la connexion internet et la liaison avec la pool. En cas de manquemant, il    #
#    envoie un pushbullet pour avertir un ou plusieurs utilisateur, ainsi que tout les     #
#                             périphériques d'un compte.                                   #
 ##########################################################################################
#        Crée le 25/10/2018 Par KASPAR Olivier @ mail : olivier.kaspar@gmail.com           #
 ##########################################################################################
 
Utilisation
 :
=============

./cerbere.sh                Lance la vérification et envoi un push s'il y a un problème
./cerbere.sh --rapport      Lance la vérification, envoi un push s'il y a un problème sinon envoi un push avec un rapport
./cerbere.sh --push         Vérifie si il n'ya pas une demande de rapport sur le flux pushbullet


Exemple de rapport
 :
====================

                          _____________
                         (___________(o)
    /|                  /  Mes Sirs, /
    |/                 /  Voici mon /
    |/                /  himble et /
    |/               /   modeste  /
    |               /   rapport  /
   _|_             /____________/
  (___)            (___________(o)

En ce jour, rendons grâce au segnieur CrYpT0 et au bienfais qu'il nous apporte en publiant ce compte-rendu

Fichier de configuration : OK
Connexion Internet : OK
Hash : OK
Vitesse actuelle du miner 23 /H
Liaison Pool : OK
Vitesse actuelle de la pool : 892 Th

Adaptation du script :
======================

Pour Nanopool par exemple :
---------------------------

remplacer la ligne retour=\$(curl -s -X POST -H \"Content-Type: application/json\" \$pool | jq .x16r.hashrate) par retour=\$(curl -s -X GET -H \"Content-Type: application/json\" \$pool | jq .data).
N'oubliez pas d'adapter la division à la ligne suivante let retour=\$retour/1000000000.

Le but étant via les API de récupérer le Hashrate de la pool."

}

message () { 
# envoie un message collectif

/media/www/pushbullet.sh --push_contact $API_Key "ıllıllıCERBEREıllıllı"$'\n'"$1" "$2" "scoob79mobile@gmail.com"
/media/www/pushbullet.sh --push_contact $API_Key "ıllıllıCERBEREıllıllı"$'\n'"$1" "$2" "olivier.kaspar@gmail.com"
#/media/www/pushbullet.sh --push_contact $API_Key "ıllıllıCERBEREıllıllı"$'\n'"$1" "$2" "laurie.tomaselli@gmail.com"

}

Mrapport () {



rnd=$(($RANDOM*4/32767))
if [ -z $tl ]; then 
    local1="
==================================
!!! ATTENTION !!! $local1 
une erreur à été détectée dans le fichier de configuration.
$local2
==================================
"
fi

if [ -z $ti ]; then 
    internet="
==================================
!!! ATTENTION !!! $internet
une erreur à été détectée lors du test de la connexion internet.
==================================
"
fi

if [ -z $th ]; then 
    hash1="
==================================
!!! ATTENTION !!! $hash1 
une erreur à été détectée lors du de la vérification de la vitesse de hash.
$hash2
==================================
"
fi

if [ -z "$tp" ]; then 
    pool="
==================================
!!! ATTENTION !!! $pool
une erreur à été détectée dde la récupération de la vitesse de hash de la pool.
Cela peut venir de la pool qui ne répond plus ou de l'API de la pool.
==================================
"
fi

if [ "$rnd" == 0 ]; then rapport1;fi
if [ "$rnd" == 1 ]; then rapport2;fi
if [ "$rnd" == 2 ]; then rapport3;fi
if [ "$rnd" == 3 ]; then rapport4;fi

}

rapport1 () {

#                          _____________
#                         (___________(o)
#    /|                  /  Mes Sirs, /
#    |/                 /  Voici mon /
#    |/                /  himble et /
#    |/               /   modeste  /
#    |               /   rapport  /
#   _|_             /____________/
#  (___)            (____________(o)
message "Rapport journalier", "
                            _____________
                            (___________(o)
    /|                    /   Mes Sirs,    /
    |/                   /   Voici mon  /
    |/                 /   himble et   /
    |/               /   modeste    /
    |               /    rapport      /
  _|_           /____________/
(___)        (____________(o)
En ce jour, rendons grâce au segnieur CrYpT0 et au bienfais qu'il nous apporte en publiant ce compte-rendu

$local1
$internet
$hash1
$minerhash
$pool
$poolhash"
}

rapport2 () {

message "Rapport journalier", "Bonjour,
Il fait beau aujourd'hui et je me sens très bien surtout avec un telle rapport =^..^=

$local1
$internet
$hash1
$minerhash
$pool
$poolhash"
}

rapport3 () {

message "Rapport journalier", "
 _________________________
|  ça ronronne aujourd'hui   |
|_________________________|
  \\
    \\(\\ /)
     (='.'=)
     ('')_('')

$local1
$internet
$hash1
$minerhash
$pool
$poolhash"
}

rapport4 () {

message "Rapport journalier", "
~~~~~~~~~~~~~~~~~~~~~~~~~ 
| On bombarde à toute vitesse YouHou |
~~~~~~~~~~~~~~~~~~~~~~~~~ 

' ''   __,__,___\\__' '
___'-O-------=O--'___

$local1
$internet
$hash1
$minerhash
$pool
$poolhash"
}

timestamp() {
    date +"%s" ;  
}

Mpush() {

    ret=$(timestamp)
    let ts=$ret-59
    retour=$(/media/www/pushbullet.sh --list_push $API_Key $ts | grep "\"body\": \"rapport\"")
    if [ "$retour" != "" ]; then Mcontrol; Mrapport; fi
}

Mcontrol() {
# Control du fichier local.conf

retour=$(diff /home/ethos/local.conf /home/ethos/local.conf.ok) # Compare le fichier de configuration avec celui qui est OK

if [ "$retour" != "" ]; then
	local1="Fichier de configuration : KO"
	local2="Remplacement du fichier de configuration. 
	Restart du miner"
	cp /home/ethos/local.conf /home/ethos/local.conf.$(date +%Y-%m-%d) # crée une copie du fichier corrompu
	cp /home/ethos/local.conf.ok /home/ethos/local.conf # Rétablie la bonne configuration
	minerstop # Relance le miner
	titre="ALERTE MINER"
	message "$titre", "$local1"$'\n'"$local2"
else
	local1="Fichier de configuration : OK"
fi

# Control de la connexion internet

retour=$(ping -c 1 google.fr | grep "packet loss" | cut -d ',' -f3) # Ping google

if [ "$retour" != "0% packet loss" ]; then
        internet="Connexion Internet : OK"
else
	internet="Connexion Internet : KO"
	titre="ALERTE MINER"
	message "$titre", "$internet"
fi

# Control du hash

ret=$(stat -c %Z /proc/) # Temps depuis le démarrage du serveur
let ts=$ret-1900 # On rajoute 30 minutes
if [ $(timestamp) -ge $ts ]; then # vérifie que le miner est allumé depuis plus de 30 minutes
    retour=$(cat /var/run/ethos/status.file | cut -d "." -f1)
    minerhash="Vitesse actuelle du miner $retour H"

    if [ $retour -ge $limit_hash ]; then # Si la limite basse du hashrate est atteinte
        hash1="Hash : OK"
    else
        hash1="Hash: KO"
        if [ "$retour" != "miner started: miner commanded to start" ]; then # Si le reboot à déjà un lieu
            minestop
            hash2="Reboot du miner !!!"
        else
            hash2="En attente de reboot du miner !!!"
        fi
        titre="ALERTE MINER"
        message "$titre", "$hash1 $hash2"
    fi
fi

# Control de la liaison à la pool

retour=$(curl -s -X POST -H "Content-Type: application/json" $pool | jq .x16r.hashrate) # Récupère le hashrate de la pool
let retour=$retour/1000000000
poolhash="Vitesse actuelle de la pool : $retour Th"

if [ $retour -ge 1 ]; then # Control si l'on a bien récuperer le Hashrate
    pool="Liaison Pool : OK"
else
    pool="Liaison Pool : KO"
	titre="ALERTE MINER"
	message "$titre", "$pool"
fi

# Control si l'on à bien OK de partout
if [ "$local1" == "Fichier de configuration : OK" ]; then control=$control+1;tl="ok";fi
if [ "$internet" == "Connexion Internet : OK"  ]; then control=$control+2;ti="ok";fi
if [ "$hash1" == "Hash : OK" ]; then control=$control+3;th="ok";fi
if [ "$pool" == "Liaison Pool : OK" ]; then control=$control+4;tp="ok";fi
}
  
if [ "$1" == "--push" ]; then Mpush; fi
if [ "$1" == "--rapport" ]; then Mcontrol; Mrapport; fi
if [ "$1" == "" ]; then Mcontrol; fi
if [ "$1" == "--help" ]; then aide; fi
if [ "$1" == "-h" ]; then aide; fi
exit 0
