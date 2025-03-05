#!/bin/bash

# Fonction pour effectuer un DNS lookup
dns_lookup() {
    read -p "Entrez le domaine à vérifier : " domaine
    nslookup "$domaine"
}

# Fonction pour effectuer un WHOIS
whois_lookup() {
    read -p "Entrez le domaine ou l'IP à analyser : " cible
    whois "$cible"
}

# Fonction pour effectuer un traceroute
traceroute_check() {
    read -p "Entrez le domaine ou l'IP à tracer : " cible
    traceroute "$cible"
}

# Fonction pour se connecter en SSH
ssh_connect() {
    read -p "Entrez l'adresse de l'hôte SSH : " hote
    read -p "Entrez le nom d'utilisateur : " user
    ssh "$user"@"$hote"
}

# Fonction pour calculer le nombre de caractères dans un fichier
count_characters() {
    read -p "Entrez le chemin du fichier : " fichier
    if [ -f "$fichier" ]; then
        wc -m "$fichier"
    else
        echo "Erreur : Fichier non trouvé."
    fi
}

# Fonction pour voir les partitions du disque
view_partitions() {
    lsblk
}

# Fonction pour afficher les informations système
system_info() {
    echo "Informations système :"
    uname -a
    echo "Détails du système :"
    lsb_release -a 2>/dev/null || cat /etc/os-release
    echo "\nMémoire disponible :"
    free -h
    echo "Espace disque disponible :"
    df -h
    echo "Temps d'activité :"
    uptime
}

# Sous-menu pour les outils de surveillance système
monitoring_menu() {
    while true; do
        echo -e "\nOutils de surveillance système :"
        echo "1) Lancer btop"
        echo "2) Lancer htop"
        echo "3) Voir l'utilisation du CPU (mpstat)"
        echo "4) Voir l'utilisation de la mémoire (free -h)"
        echo "5) Revenir au menu principal"
        read -p "Choisissez une option : " choix_mon

        case $choix_mon in
            1) btop ;;
            2) htop ;;
            3) mpstat 1 5 ;;
            4) free -h ;;
            5) break ;;
            *) echo "Option invalide, veuillez réessayer." ;;
        esac
    done
}

# Menu principal
while true; do
    echo -e "Que voulez-vous faire ?"
    echo "1) DNS Lookup"
    echo "2) WHOIS Lookup"
    echo "3) Traceroute"
    echo "4) Outils de surveillance système"
    echo "5) Se connecter en SSH"
    echo "6) Calcule le nombre de caractères dans un fichier"
    echo "7) Voir les partitions du disque"
    echo "8) Voir les informations système"
    echo "9) Quitter"
    read -p "Choisissez une option : " choix

    case $choix in
        1) dns_lookup ;;
        2) whois_lookup ;;
        3) traceroute_check ;;
        4) monitoring_menu ;;
        5) ssh_connect ;;
        6) count_characters ;;
        7) view_partitions ;;
        8) system_info ;;
        9) echo "Au revoir !"; exit ;;
        *) echo "Option invalide, veuillez réessayer." ;;
    esac
done
