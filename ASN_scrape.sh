#!/bin/bash

RED='\033[0;91m'
YELLOW='\033[0;93m'
BLUE='\033[0;94m'
GREEN='\033[0;92m'
NC='\033[0m' # No Color

SUCCEED="${GREEN}[SUCCESS]${NC}"
WARN="${YELLOW}[WARN]${NC}"
ERR="${RED}[ERROR]${NC}"
INFO="${BLUE}[INFO]${NC}"

echo -e "${YELLOW} ⠀⠀⠀⢀⣤⠤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀"
echo "⠀⠀⠀⡞⠁⠀⠀⠈⠙⠶⠖⠒⠒⠖⠲⠦⢤⡴⠖⠋⠉⠉⢳⡀⠀⠀"
echo "⠀⠀⠀⣷⠀⠀⠀⠀⠀⠈⠀⠀⠠⠀⠰⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀"
echo "⢀⠀⠀⠈⠀⢀⣠⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⠏⠀⠀⠀"
echo "⠈⠙⠲⠀⣴⠃⠀⠀⣻⣷⠀⠀⠀⠀⠀⢀⠔⠚⠛⠲⣦⠀⢀⡴⠖⠁"
echo "⠤⢤⡄⠀⢿⣤⣀⣤⣿⣿⣦⠀⠀⠀⢀⣾⡀⠀⢀⣠⣿⡆⠈⠁⠀⠀"
echo "⠀⠀⠀⢀⢘⠿⣿⣿⣿⣻⠟⠀⠀⠀⢸⣿⣿⡿⣿⣿⠟⠀⠀⠉⠉⠁"
echo "⠀⠀⠀⠀⠈⠓⢦⣍⣉⠁⠀⠀⠀⠀⠀⠉⠙⣛⣭⠝⠓⠀⠀⠀⠀⠀"
echo "⠀⠀⠀⠀⠀⠀⠀⠀⢻⠀⠙⠲⠖⠃⣸⡟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo -e "⠀⠀⠀⠀⠀⠀⠀⠀⠈⠧⠶⠒⠶⠼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀${NC}"

echo -e "${GREEN}super silly asn scraper program!!!!11!!${NC} ${RED}:3${NC}"

dtg="$(date -I)"

while IFS= read -r line; do
    echo -e "${INFO} ASN Lookup site read from ${YELLOW}asn_sites.lst${NC}: ${BLUE}$line${NC}"
done < asn_sites.lst

args=("$@")

if [ -z "$1" ]
  then
    echo -e "${ERR} No IP List File supplied"
    echo -e "${INFO} ${YELLOW}./ASN_scrape.sh <IP_FILE>${NC}"
    exit
fi

FILE=$1     
if [ -f $FILE ]; then
   echo -e "${SUCCEED} Targets File '$FILE' exists."
else
   echo -e "${ERR} Targets File '$FILE' does not exist."
   echo -e "${INFO} ${YELLOW}./ASN_scrape.sh <IP_FILE>${NC}"
   exit
fi


ip_file=${args[0]}

echo -e "${WARN} File: ${YELLOW}${ip_file}${NC} selected. Is this correct? If it isn't, do ${RED}CTRL + C${NC} and quit the program. Otherwise, press ${GREEN}ENTER${NC}."
read -p ""
while IFS= read -r line; do
    echo -e "${INFO} : ${BLUE}$line${NC}"
done < ${ip_file}

echo -e "${WARN} Before scans start, would you like to hold the files in a different directory? Give an ${RED}absolute filepath${NC}. ${YELLOW}Example: /media/user/USB/${NC} If you want to store as is, just hit ${GREEN}ENTER${NC}"
read -p "Filepath: " filepath
echo ${filepath}ASN_Lookup_${dtg}
mkdir ${filepath}ASN_Lookup_${dtg} 2>/dev/null

while IFS= read -r line; do
    chosen_site=$(shuf -n 1 asn_sites.lst)
    echo -e "${WARN} Site Chosen: ${YELLOW}$chosen_site${NC} for IP: ${BLUE}$line${NC}"
    echo -e "${INFO} ${BLUE}Command${NC}: sudo curl ${chosen_site}${line}"
    sudo curl ${chosen_site}${line} > ${filepath}ASN_Lookup_${dtg}/lookup_${line}
done < ${ip_file}

echo -e "${SUCCEED} ASN lookup Complete! Check ${YELLOW}ASN_Lookup_${dtg}/${NC}"