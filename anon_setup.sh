#!/bin/bash

# Script di anonimizzazione online con Tor, Proxychains e Anonsurf
# Creato per facilitare la configurazione di un ambiente anonimo

# Funzione per mostrare solo il logo
show_logo() {
    cat << "EOF"
    _                      _                 
   / \   _ __   ___  _ __ (_)_ __ ___   ___  
  / _ \ | '_ \ / _ \| '_ \| | '_ ` _ \ / _ \ 
 / ___ \| | | | (_) | | | | | | | | | | (_) |
/_/   \_\_| |_|\___/|_| |_|_|_| |_| |_|\___/ 
                                           
 Tool di Anonimizzazione - v1.0
EOF
}

# Funzione per mostrare il disclaimer
show_disclaimer() {
    cat << "EOF"
=========================================================
⚠️  DISCLAIMER - LEGGERE PRIMA DELL'UTILIZZO
=========================================================

Questo software è fornito esclusivamente a scopo educativo 
e di ricerca. L'autore non si assume alcuna responsabilità 
per l'uso improprio di questo strumento.

Utilizzando questo script, l'utente accetta che:
- Utilizzerà questi strumenti in conformità con tutte le leggi
- Non è garantito un anonimato completo
- L'anonimato online non è mai assoluto al 100%
- Non utilizzerà questi strumenti per attività illecite

USO RESPONSABILE: Questo script è pensato per proteggere 
la tua privacy online in modo legale e responsabile.
=========================================================

EOF
    echo "Premi Enter per continuare..."
    read
}

# Funzione per mostrare il logo e il disclaimer (all'avvio)
show_banner() {
    show_logo
    show_disclaimer
}

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Cartella di base dello script (percorso relativo)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Funzione per messaggi di stato
print_status() {
    echo -e "${BLUE}[*] ${NC}$1"
}

print_success() {
    echo -e "${GREEN}[+] ${NC}$1"
}

print_error() {
    echo -e "${RED}[-] ${NC}$1"
}

print_warning() {
    echo -e "${YELLOW}[!] ${NC}$1"
}

# Controlla se lo script è eseguito come root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        print_error "Questo script richiede privilegi di root."
        print_error "Eseguilo con 'sudo $0'"
        exit 1
    fi
}

# Installa Tor Browser
install_tor_browser() {
    print_status "Installazione di Tor Browser..."
    
    apt update && apt install -y tor torbrowser-launcher
    
    if [ $? -eq 0 ]; then
        print_success "Tor Browser installato correttamente"
        print_status "Puoi avviare Tor Browser con il comando 'torbrowser-launcher'"
    else
        print_error "Errore durante l'installazione di Tor Browser"
    fi
}

# Configura Proxychains
setup_proxychains() {
    print_status "Configurazione di Proxychains..."
    
    apt update && apt install -y proxychains4
    
    # Percorso del file di configurazione può variare
    CONFIG_FILE="/etc/proxychains4.conf"
    if [ ! -f "$CONFIG_FILE" ]; then
        CONFIG_FILE="/etc/proxychains.conf"
    fi
    
    if [ -f "$CONFIG_FILE" ]; then
        # Backup del file di configurazione originale
        cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"
        
        # Verifica e aggiorna la configurazione
        if ! grep -q "^dynamic_chain" "$CONFIG_FILE"; then
            sed -i 's/^#dynamic_chain/dynamic_chain/' "$CONFIG_FILE"
            echo "dynamic_chain attivato"
        fi
        
        if ! grep -q "^strict_chain" "$CONFIG_FILE"; then
            sed -i 's/^#strict_chain/strict_chain/' "$CONFIG_FILE"
            echo "strict_chain attivato"
        fi
        
        if ! grep -q "^proxy_dns" "$CONFIG_FILE"; then
            sed -i 's/^#proxy_dns/proxy_dns/' "$CONFIG_FILE"
            echo "proxy_dns attivato"
        fi
        
        # Assicurati che il proxy Tor sia configurato
        if ! grep -q "socks5 127.0.0.1 9050" "$CONFIG_FILE"; then
            echo "socks5 127.0.0.1 9050" >> "$CONFIG_FILE"
            echo "Proxy Tor aggiunto"
        fi
        
        print_success "Proxychains configurato correttamente"
    else
        print_error "File di configurazione di Proxychains non trovato"
    fi
}

# Installa e configura Anonsurf
setup_anonsurf() {
    print_status "Installazione di Anonsurf..."
    
    apt update && apt install -y anonsurf
    
    if [ $? -eq 0 ]; then
        print_success "Anonsurf installato correttamente"
    else
        print_warning "Anonsurf non trovato nei repository predefiniti"
        print_status "Tentativo di installazione tramite repository alternativo..."
        
        # Installazione da repository ParrotSec se disponibile
        apt install -y git
        cd /tmp
        git clone https://github.com/Und3rf10w/kali-anonsurf.git
        cd kali-anonsurf
        ./installer.sh
        
        if [ $? -eq 0 ]; then
            print_success "Anonsurf installato correttamente da source"
        else
            print_error "Errore durante l'installazione di Anonsurf"
        fi
    fi
}

# Avvia anonsurf e verifica l'IP
start_anonsurf() {
    print_status "Avvio di Anonsurf..."
    service tor start
    anonsurf start
    
    if [ $? -eq 0 ]; then
        print_success "Anonsurf avviato correttamente"
        print_status "Verifica del tuo IP pubblico:"
        
        sleep 3
        
        # Usa Tor per la richiesta
        CURRENT_IP=$(proxychains curl -s ifconfig.me)
        echo -e "${GREEN}Il tuo IP pubblico attuale è: ${CURRENT_IP}${NC}"
    else
        print_error "Errore durante l'avvio di Anonsurf"
    fi
}

# Stop anonsurf
stop_anonsurf() {
    print_status "Arresto di Anonsurf..."
    anonsurf stop
    
    if [ $? -eq 0 ]; then
        print_success "Anonsurf arrestato correttamente"
        print_status "Verifica del tuo IP pubblico:"
        
        sleep 2
        
        CURRENT_IP=$(curl -s ifconfig.me)
        echo -e "${YELLOW}Il tuo IP pubblico attuale è: ${CURRENT_IP}${NC}"
    else
        print_error "Errore durante l'arresto di Anonsurf"
    fi
}

# Avvia browser anonimo con proxychains
launch_anonymous_browser() {
    print_status "Avvio del browser attraverso proxychains..."
    
    # Controlla se Firefox è installato
    if command -v firefox &> /dev/null; then
        proxychains firefox -private-window &
    # Controlla se Chrome è installato
    elif command -v google-chrome &> /dev/null; then
        proxychains google-chrome --incognito &
    # Controlla se Chromium è installato
    elif command -v chromium-browser &> /dev/null; then
        proxychains chromium-browser --incognito &
    else
        print_error "Nessun browser compatibile trovato. Installa Firefox, Chrome o Chromium."
    fi
}

# Installa Docker e crea un container per anonimizzazione
setup_docker() {
    print_status "Installazione di Docker..."
    apt update
    apt install -y docker.io docker-compose
    systemctl enable docker
    systemctl start docker
    
    if [ $? -eq 0 ]; then
        print_success "Docker installato correttamente"
        
        # Crea una directory per il container
        mkdir -p "$SCRIPT_DIR/docker"
        
        # Crea Dockerfile
        cat > "$SCRIPT_DIR/docker/Dockerfile" << EOF
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \\
    tor \\
    proxychains4 \\
    curl \\
    firefox-esr \\
    git \\
    sudo \\
    && rm -rf /var/lib/apt/lists/*

# Configurazione Proxychains
RUN sed -i 's/^#dynamic_chain/dynamic_chain/' /etc/proxychains4.conf \\
    && sed -i 's/^strict_chain/#strict_chain/' /etc/proxychains4.conf \\
    && sed -i 's/^#proxy_dns/proxy_dns/' /etc/proxychains4.conf

# Installa anonsurf
RUN cd /tmp \\
    && git clone https://github.com/Und3rf10w/kali-anonsurf.git \\
    && cd kali-anonsurf \\
    && chmod +x installer.sh \\
    && ./installer.sh

ENTRYPOINT ["/bin/bash"]
EOF

        # Crea docker-compose.yml
        cat > "$SCRIPT_DIR/docker/docker-compose.yml" << EOF
version: '3'
services:
  anon:
    build: .
    container_name: anontools
    restart: unless-stopped
    volumes:
      - /tmp/.X11-unix:/tmp/.X11-unix
    environment:
      - DISPLAY=\${DISPLAY}
    network_mode: host
    cap_add:
      - NET_ADMIN
EOF

        # Script di avvio del container
        cat > "$SCRIPT_DIR/run_docker_anon.sh" << EOF
#!/bin/bash
xhost +local:docker
cd "\$(dirname "\$0")/docker"
docker-compose up -d
docker exec -it anontools bash
EOF
        chmod +x "$SCRIPT_DIR/run_docker_anon.sh"
        
        print_success "Container Docker configurato correttamente"
        print_status "Puoi avviare l'ambiente con: sudo ./run_docker_anon.sh"
    else
        print_error "Errore durante l'installazione di Docker"
    fi
}

# Configura Firejail (sandbox)
setup_firejail() {
    print_status "Installazione di Firejail..."
    apt update
    apt install -y firejail
    
    if [ $? -eq 0 ]; then
        print_success "Firejail installato correttamente"
        
        # Crea profilo personalizzato per Tor
        cat > "$SCRIPT_DIR/tor_firejail.profile" << EOF
# Firejail profile for Tor+Proxychains
include /etc/firejail/firefox.profile
net.protocol unix,inet,inet6
EOF

        # Crea script di avvio
        cat > "$SCRIPT_DIR/run_firejail_anon.sh" << EOF
#!/bin/bash
# Avvia Tor
sudo service tor start

# Verifica che Tor sia in esecuzione
if ! pgrep -x "tor" > /dev/null; then
    echo "Errore: Tor non è in esecuzione"
    exit 1
fi

# Avvia Firefox in sandbox con Proxychains
firejail --profile="\$(dirname "\$0")/tor_firejail.profile" proxychains firefox -private-window
EOF
        chmod +x "$SCRIPT_DIR/run_firejail_anon.sh"
        
        print_success "Firejail configurato correttamente"
        print_status "Puoi avviare l'ambiente con: ./run_firejail_anon.sh"
    else
        print_error "Errore durante l'installazione di Firejail"
    fi
}

# Scarica e configura VM Whonix
setup_whonix_vm() {
    print_status "Per utilizzare Whonix VM, dovrai:"
    echo "1. Installare VirtualBox: sudo apt install virtualbox"
    echo "2. Scaricare Whonix da: https://www.whonix.org/wiki/VirtualBox/XFCE"
    echo "3. Importare le VM Whonix-Gateway e Whonix-Workstation in VirtualBox"
    echo "4. Avviare prima Whonix-Gateway e poi Whonix-Workstation"
    
    # Crea script informativo
    cat > "$SCRIPT_DIR/install_whonix.sh" << EOF
#!/bin/bash
# Script per installare VirtualBox e scaricare Whonix

# Installa VirtualBox
sudo apt update
sudo apt install -y virtualbox

# Crea directory per Whonix
mkdir -p "\$(dirname "\$0")/whonix"

# Scarica Whonix
echo "Inizio download di Whonix (questo potrebbe richiedere tempo)..."
wget -c https://download.whonix.org/ova/16.0.3.7/Whonix-XFCE-16.0.3.7.ova -O "\$(dirname "\$0")/whonix/Whonix-XFCE.ova"

# Informazioni per l'utente
echo ""
echo "Download completato!"
echo "Per importare Whonix in VirtualBox, esegui:"
echo "virtualbox \$(dirname "\$0")/whonix/Whonix-XFCE.ova"
echo ""
echo "Dopo l'importazione, avvia prima Whonix-Gateway e poi Whonix-Workstation"
EOF
    chmod +x "$SCRIPT_DIR/install_whonix.sh"
    
    print_status "Script di installazione per Whonix creato: ./install_whonix.sh"
}

# Informazioni su Tails OS
setup_tails() {
    print_status "Per utilizzare Tails OS:"
    echo "1. Scarica l'immagine ISO da: https://tails.boum.org/install/download/index.en.html"
    echo "2. Usa 'Rufus' (Windows) o 'dd' (Linux) per creare una chiavetta USB avviabile"
    echo "3. Riavvia il computer e fai il boot dalla chiavetta USB"
    
    # Crea script informativo per Linux
    cat > "$SCRIPT_DIR/install_tails.sh" << EOF
#!/bin/bash
# Script per scaricare Tails OS e creare una chiavetta USB avviabile

# Installa dipendenze
sudo apt update
sudo apt install -y wget

# Crea directory per Tails
mkdir -p "\$(dirname "\$0")/tails"

# Scarica Tails
echo "Inizio download di Tails OS (questo potrebbe richiedere tempo)..."
wget -c https://tails.net/install/download/torrents/tails-amd64-5.8.iso.torrent -O "\$(dirname "\$0")/tails/tails.iso.torrent"

echo ""
echo "File torrent di Tails OS scaricato!"
echo "Usa un client torrent per scaricare l'immagine ISO"
echo ""
echo "Dopo aver scaricato l'immagine, per creare una chiavetta USB avviabile:"
echo "sudo dd if=/percorso/immagine-tails.iso of=/dev/sdX bs=4M status=progress"
echo "(sostituisci /dev/sdX con il dispositivo della tua chiavetta USB)"
EOF
    chmod +x "$SCRIPT_DIR/install_tails.sh"
    
    print_status "Script di installazione per Tails creato: ./install_tails.sh"
}

# Confronta le varie opzioni di isolamento
compare_isolation_options() {
    clear
    echo -e "${BLUE}===========================================${NC}"
    echo -e "${BLUE}    CONFRONTO TRA OPZIONI DI ISOLAMENTO    ${NC}"
    echo -e "${BLUE}===========================================${NC}"
    echo ""
    
    echo -e "${YELLOW}1. Esecuzione Nativa (direttamente sul sistema)${NC}"
    echo "   Pro: Facilità di configurazione, nessun overhead di virtualizzazione"
    echo "   Contro: Minore isolamento, potenziali fughe di dati, tutti i file temporanei rimangono sul sistema host"
    echo ""
    
    echo -e "${YELLOW}2. Docker Container${NC}"
    echo "   Pro: Leggero, facile da utilizzare, isolamento dei processi, riproducibile su qualsiasi sistema con Docker"
    echo "   Contro: Condivide il kernel con l'host, isolamento non completo, possibili fughe di dati"
    echo "   Consigliato per: Utenti che vogliono un ambiente facile da configurare con discreto isolamento"
    echo ""
    
    echo -e "${YELLOW}3. Firejail (Sandbox)${NC}"
    echo "   Pro: Leggero, semplice da usare, ottimo per isolare singole applicazioni"
    echo "   Contro: Non isola completamente il sistema, condivide risorse con l'host"
    echo "   Consigliato per: Isolare browser o altre singole applicazioni con risorse limitate"
    echo ""
    
    echo -e "${YELLOW}4. Whonix in Virtual Machine${NC}"
    echo "   Pro: Eccellente isolamento, sistema a doppio VM (Gateway + Workstation), progettato specificamente per l'anonimato"
    echo "   Contro: Richiede più risorse di sistema, configurazione più complessa"
    echo "   Consigliato per: Utenti che necessitano di alto livello di anonimato e sicurezza"
    echo ""
    
    echo -e "${YELLOW}5. Tails OS (Live System)${NC}"
    echo "   Pro: Massimo isolamento e amnesia (non salva dati), tutto il traffico passa attraverso Tor"
    echo "   Contro: Richiede riavvio del sistema, necessaria chiavetta USB, limitazioni nell'uso persistente"
    echo "   Consigliato per: Massima sicurezza e anonimato, situazioni che richiedono non lasciare tracce"
    echo ""
    
    echo -e "${YELLOW}CONSIGLIO FINALE:${NC}"
    echo "- Per uso occasionale: Firejail o esecuzione nativa"
    echo "- Per uso regolare con buon isolamento: Docker"
    echo "- Per alta sicurezza con uso frequente: Whonix VM"
    echo "- Per situazioni ad alto rischio o per sessioni singole: Tails OS"
    echo ""
}

# Avvia tutti gli strumenti insieme per la massima protezione
use_all_tools_together() {
    print_status "Avvio di tutti gli strumenti insieme per la massima protezione..."
    
    # Step 1: Avvia Tor
    print_status "Step 1: Avvio del servizio Tor..."
    service tor start
    if [ $? -ne 0 ]; then
        print_error "Errore nell'avvio di Tor. Impossibile continuare."
        return 1
    fi
    print_success "Servizio Tor avviato"
    
    # Step 2: Avvia Anonsurf
    print_status "Step 2: Avvio di Anonsurf..."
    anonsurf start
    if [ $? -ne 0 ]; then
        print_error "Errore nell'avvio di Anonsurf. Ferma Tor e riprova."
        service tor stop
        return 1
    fi
    print_success "Anonsurf avviato correttamente"
    
    # Step 3: Verifica configurazione di Proxychains
    print_status "Step 3: Verifica configurazione di Proxychains..."
    CONFIG_FILE="/etc/proxychains4.conf"
    if [ ! -f "$CONFIG_FILE" ]; then
        CONFIG_FILE="/etc/proxychains.conf"
    fi
    
    if [ ! -f "$CONFIG_FILE" ]; then
        print_error "File di configurazione Proxychains non trovato."
        print_status "Installazione di Proxychains..."
        apt install -y proxychains4
        
        CONFIG_FILE="/etc/proxychains4.conf"
        if [ ! -f "$CONFIG_FILE" ]; then
            CONFIG_FILE="/etc/proxychains.conf"
        fi
        
        if [ ! -f "$CONFIG_FILE" ]; then
            print_error "Impossibile installare Proxychains. Ferma gli altri servizi e riprova."
            anonsurf stop
            service tor stop
            return 1
        fi
    fi
    
    # Verifica che il proxy Tor sia configurato in Proxychains
    if ! grep -q "socks5 127.0.0.1 9050" "$CONFIG_FILE"; then
        print_status "Aggiungo il proxy Tor a Proxychains..."
        echo "socks5 127.0.0.1 9050" >> "$CONFIG_FILE"
    fi
    print_success "Proxychains configurato correttamente"
    
    # Step 4: Verifica che tutto funzioni insieme
    print_status "Step 4: Verifica del funzionamento combinato..."
    
    sleep 3
    
    # Usa Proxychains+Tor+Anonsurf per verificare l'IP
    print_status "Verifica dell'IP attraverso tutti i livelli di protezione:"
    CURRENT_IP=$(proxychains curl -s ifconfig.me)
    if [ -z "$CURRENT_IP" ]; then
        print_warning "Non è stato possibile ottenere l'IP. Questo potrebbe indicare che la protezione è molto forte o che c'è un problema di connessione."
    else
        echo -e "${GREEN}Il tuo IP pubblico anonimizzato è: ${CURRENT_IP}${NC}"
    fi
    
    # Step 5: Avvia browser con massima protezione
    print_status "Step 5: Avvio browser con protezione massima..."
    
    # Controlla se Firefox è installato
    if command -v firefox &> /dev/null; then
        print_status "Avvio Firefox attraverso Proxychains (con Tor e Anonsurf attivi)..."
        proxychains firefox -private-window about:blank &
    elif command -v google-chrome &> /dev/null; then
        print_status "Avvio Chrome attraverso Proxychains (con Tor e Anonsurf attivi)..."
        proxychains google-chrome --incognito about:blank &
    elif command -v chromium-browser &> /dev/null; then
        print_status "Avvio Chromium attraverso Proxychains (con Tor e Anonsurf attivi)..."
        proxychains chromium-browser --incognito about:blank &
    else
        print_error "Nessun browser compatibile trovato. Installa Firefox, Chrome o Chromium."
        return 1
    fi
    
    print_success "Tutti i sistemi avviati correttamente insieme"
    print_status "La protezione è ora ai massimi livelli con: Tor + Proxychains + Anonsurf"
    print_warning "Ricorda: Disabilita JavaScript e cancella cookie/cache per massima sicurezza"
    
    return 0
}

# Ferma tutti gli strumenti insieme
stop_all_tools() {
    print_status "Arresto di tutti gli strumenti di protezione..."
    
    print_status "Arresto di Anonsurf..."
    anonsurf stop
    
    print_status "Arresto del servizio Tor..."
    service tor stop
    
    print_success "Tutti i servizi di protezione sono stati arrestati"
    
    print_status "Verifica dell'IP reale:"
    CURRENT_IP=$(curl -s ifconfig.me)
    echo -e "${YELLOW}Il tuo IP pubblico attuale è: ${CURRENT_IP}${NC}"
}

# Menu principale
show_menu() {
    clear
    show_logo  # Mostra sempre il logo in cima
    echo ""
    echo -e "${BLUE}====================================${NC}"
    echo -e "${BLUE}    TOOL DI ANONIMIZZAZIONE ONLINE    ${NC}"
    echo -e "${BLUE}====================================${NC}"
    echo ""
    echo -e "${YELLOW}INSTALLAZIONE E CONFIGURAZIONE BASE:${NC}"
    echo -e "${YELLOW}1.${NC} Installa tutto (Tor, Proxychains, Anonsurf)"
    echo -e "${YELLOW}2.${NC} Avvia Tor Browser"
    echo -e "${YELLOW}3.${NC} Avvia browser con Proxychains"
    echo -e "${YELLOW}4.${NC} Avvia Anonsurf"
    echo -e "${YELLOW}5.${NC} Ferma Anonsurf"
    echo -e "${YELLOW}6.${NC} Verifica IP corrente"
    echo -e "${YELLOW}7.${NC} Pulisci cache e cookie"
    echo ""
    echo -e "${RED}MASSIMA PROTEZIONE:${NC}"
    echo -e "${RED}13.${NC} Avvia Tor + Proxychains + Anonsurf insieme"
    echo -e "${RED}14.${NC} Ferma tutti i servizi di protezione"
    echo ""
    echo -e "${YELLOW}CONFIGURAZIONE AMBIENTI ISOLATI:${NC}"
    echo -e "${YELLOW}8.${NC} Configura Docker (container isolato)"
    echo -e "${YELLOW}9.${NC} Configura Firejail (sandbox)"
    echo -e "${YELLOW}10.${NC} Info e setup Whonix VM"
    echo -e "${YELLOW}11.${NC} Info e setup Tails OS"
    echo -e "${YELLOW}12.${NC} Confronto tra le opzioni di isolamento"
    echo ""
    echo -e "${YELLOW}0.${NC} Esci"
    echo -e "${YELLOW}15.${NC} Mostra disclaimer"
    echo ""
    echo -n "Seleziona un'opzione [0-15]: "
    read choice

    case $choice in
        1)
            check_root
            install_tor_browser
            setup_proxychains
            setup_anonsurf
            echo "Premi Enter per continuare..."
            read
            show_menu
            ;;
        2)
            torbrowser-launcher &
            show_menu
            ;;
        3)
            launch_anonymous_browser
            show_menu
            ;;
        4)
            check_root
            start_anonsurf
            echo "Premi Enter per continuare..."
            read
            show_menu
            ;;
        5)
            check_root
            stop_anonsurf
            echo "Premi Enter per continuare..."
            read
            show_menu
            ;;
        6)
            print_status "Verifica del tuo IP pubblico:"
            CURRENT_IP=$(curl -s ifconfig.me)
            echo -e "${GREEN}Il tuo IP pubblico attuale è: ${CURRENT_IP}${NC}"
            echo "Premi Enter per continuare..."
            read
            show_menu
            ;;
        7)
            print_status "Pulizia cache e cookie..."
            
            # Firefox
            if [ -d ~/.mozilla/firefox ]; then
                find ~/.mozilla/firefox -name "cookies.sqlite" -delete
                find ~/.mozilla/firefox -name "cache2" -type d -exec rm -rf {} + 2>/dev/null
                print_success "Cache e cookie di Firefox eliminati"
            fi
            
            # Chrome
            if [ -d ~/.cache/google-chrome ]; then
                rm -rf ~/.cache/google-chrome
                rm -rf ~/.config/google-chrome/Default/Cookies
                rm -rf ~/.config/google-chrome/Default/Cache
                print_success "Cache e cookie di Chrome eliminati"
            fi
            
            # Chromium
            if [ -d ~/.cache/chromium ]; then
                rm -rf ~/.cache/chromium
                rm -rf ~/.config/chromium/Default/Cookies
                rm -rf ~/.config/chromium/Default/Cache
                print_success "Cache e cookie di Chromium eliminati"
            fi
            
            echo "Premi Enter per continuare..."
            read
            show_menu
            ;;
        8)
            check_root
            setup_docker
            echo "Premi Enter per continuare..."
            read
            show_menu
            ;;
        9)
            check_root
            setup_firejail
            echo "Premi Enter per continuare..."
            read
            show_menu
            ;;
        10)
            setup_whonix_vm
            echo "Premi Enter per continuare..."
            read
            show_menu
            ;;
        11)
            setup_tails
            echo "Premi Enter per continuare..."
            read
            show_menu
            ;;
        12)
            compare_isolation_options
            echo "Premi Enter per continuare..."
            read
            show_menu
            ;;
        13)
            check_root
            use_all_tools_together
            echo "Premi Enter per continuare..."
            read
            show_menu
            ;;
        14)
            check_root
            stop_all_tools
            echo "Premi Enter per continuare..."
            read
            show_menu
            ;;
        15)
            clear
            show_logo      # Mostra il logo
            show_disclaimer # Poi il disclaimer
            show_menu
            ;;
        0)
            clear
            echo "Grazie per aver usato lo script di anonimizzazione!"
            exit 0
            ;;
        *)
            print_error "Opzione non valida"
            sleep 1
            show_menu
            ;;
    esac
}

# Avvio dello script
show_banner  # Mostra il logo e il disclaimer all'avvio
show_menu    # Poi mostra il menu principale