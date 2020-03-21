#!/bin/bash

echo "Démarrage du script de détection d'erreurs"
echo "Nom du fichier de logs spécifié : $1"
echo "* * *"
echo " * * "
echo "  *  "

# Récupération d'une partie intéressante du fichier de log (les 100 dernières lignes)
declare -a echantillon=($(tail -n 100 $1 | grep "[0-9][0-9][0-9] [0-9]" -o | cut -d " " -f 1))

## Boucle For (i de 1 à 100)
## Condition sur chaque ligne pour différencier les codes HTTP
nb_erreurs="100"

for (( i = 0; i < 100; i++ )); do
	if [[ ${echantillon[$i]} -eq 200 ]]; then
	 	((nb_erreurs--))	## Décrémentation du nombre d'erreurs si accès OK code 200
	fi
done

echo "$nb_erreurs accès avec erreur"

# Actions en fonction des stats déduites
if [[ ${nb_erreurs} -le 5 ]]; then
	echo "Le taux d'erreurs est inférieur à 5%."
else
	echo "Le taux d'erreurs est supérieur à 5%."
fi

## ? Si Int > 5 Alors ?Envoyer un mail? ?

echo "  *  "
echo " * * "
echo "* * *"
echo "Fermeture du script de détection d'erreurs"