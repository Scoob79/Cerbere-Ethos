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
API_Key="Votre clé API"
pool="https://ravenminer.com/api"
limit_hash=18 # en dessous de cette limite il considère que le HASH est mort et redémarre le miner 

message (){
# envoie un message collectif

curl -i -u $API_Key: -H "Accept: application/json" -X POST -d "type=note;" -d "email=scoob79mobile@gmail.com;" -d "title=ıllıllıCERBEREıllıllı"$'\n'"$1" -d "body=$2" https://api.pushbullet.com/v2/pushes
curl -i -u $API_Key: -H "Accept: application/json" -X POST -d "type=note;" -d "email=olivier.kaspar@gmail.com;" -d "title=ıllıllıCERBEREıllıllı"$'\n'"$1" -d "body=$2" https://api.pushbullet.com/v2/pushes
curl -i -u $API_Key: -H "Accept: application/json" -X POST -d "type=note;" -d "email=laurie.tomaselli@gmail.com;" -d "title=ıllıllıCERBEREıllıllı"$'\n'"$1" -d "body=$2" https://api.pushbullet.com/v2/pushes

}


# Control du fichier local.conf

retour=$(diff /home/ethos/local.conf /home/ethos/local.conf.ok)

if [ "$retour" != "" ]; then
	local1="Fichier de configuration : KO"
	local2="Remplacement du fichier de configuration. 
	Restart du miner"
	cp /home/ethos/local.conf /home/ethos/local.conf.$(date +%Y-%m-%d)
	cp /home/ethos/local.conf.ok /home/ethos/local.conf
	minerstop
	titre="ALERTE MINER"
	message "$titre", "$local1"$'\n'"$local2"
else
	local1="Fichier de configuration : OK"
fi

# Control de la connexion internet

retour=$(ping -c 1 google.fr | grep "packet loss" | cut -d ',' -f3)

if [ "$retour" != "0% packet loss" ]; then
        internet="Connexion Internet : OK"
else
	internet="Connexion Internet : KO"
	titre="ALERTE MINER"
	message "$titre", "$internet"
fi

# Control du hash

retour=$(cat /var/run/ethos/status.file | cut -d "." -f1)
minerhash="Vitesse actuelle du miner $retour /H"

if [ $retour -ge $limit_hash ]; then
	hash1="Hash : OK"
else
	hash1="Hash: KO"
	if [ "$retour" != "miner started: miner commanded to start" ]; then
		minestop
		hash2="Reboot du miner !!!"
	else
		hash2="En attente de reboot du miner !!!"
	fi
	titre="ALERTE MINER"
	message "$titre", "$hash1 $hash2"
fi

# Control de la liaison à la pool

retour=$(curl -s -X POST -H "Content-Type: application/json" $pool | jq .x16r.hashrate)
let retour=$retour/1000000000
poolhash="Vitesse actuelle de la pool : $retour Th"

if [ $retour -ge 0 ]; then
        pool="Liaison Pool : OK"
else
        pool="Liaison Pool : KO"
	titre="ALERTE MINER"
	message "$titre", "$pool"
fi

if [ local1="Fichier de configuration : OK" ]; then control=$control+1;fi
if [ internet="Connexion Internet : OK"  ]; then control=$control+2;fi
if [ hash1="Hash : OK" ]; then control=$control+3;fi
if [ pool="Liaison Pool : OK" ]; then control=$control+4;fi


rapport1 (){

#                          _____________
#                         (___________(o)
#    /|                  /  Mes Sirs, /
#    |/                 /  Voici mon /
#    |/                /  himble et /
#    |/               /   modeste  /
#    |               /   rapport  /
#   _|_             /____________/
#  (___)            (____________(o)
message "
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

rapport2 (){

message "Rapport journalier", "Bonjour,
Il fait beau aujourd'hui et je me sens très bien surtout avec un telle rapport =^..^=

$local1
$internet
$hash1
$minerhash
$pool
$poolhash"
}

rapport3 (){

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

rapport4 (){

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

if [ "$1" == "--rapport" ]; then
	if [ "$control" == "+1+2+3+4" ]; then
		rnd=$(($RANDOM*4/32767))
		echo $rnd
		if [ "$rnd" == 0 ]; then rapport1;fi
		if [ "$rnd" == 1 ]; then rapport2;fi
		if [ "$rnd" == 2 ]; then rapport3;fi
		if [ "$rnd" == 3 ]; then rapport4;fi
	fi
fi
exit 0


