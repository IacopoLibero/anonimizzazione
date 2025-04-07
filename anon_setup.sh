#!/bin/bash

# Script di anonimizzazione online con Tor, Proxychains e Anonsurf
# Creato per facilitare la configurazione di un ambiente anonimo

# Impostazione lingua predefinita (IT = italiano, EN = inglese)
LANG="IT"

# Funzione per selezionare la lingua
select_language() {
    clear
    echo "Select language / Seleziona la lingua:"
    echo ""
    echo "1. Italiano (Italian)"
    echo "2. English (Inglese)"
    echo ""
    echo -n "Scelta / Choice [1-2]: "
    read lang_choice
    
    case $lang_choice in
        1)
            LANG="IT"
            ;;
        2)
            LANG="EN"
            ;;
        *)
            LANG="IT"
            ;;
    esac
    
    # Carica le stringhe nella lingua selezionata
    load_language_strings
}

# Funzione per caricare le stringhe nella lingua selezionata
load_language_strings() {
    if [ "$LANG" = "EN" ]; then
        # English strings
        STR_TITLE="Online Anonymization Tool"
        STR_DISCLAIMER_TITLE="DISCLAIMER - READ BEFORE USING"
        STR_DISCLAIMER1="This software is provided for educational and research purposes only."
        STR_DISCLAIMER2="The author assumes no responsibility for the misuse of this tool."
        STR_DISCLAIMER3="By using this script, the user agrees that:"
        STR_DISCLAIMER4="- Will use these tools in compliance with all laws"
        STR_DISCLAIMER5="- Complete anonymity is not guaranteed"
        STR_DISCLAIMER6="- Online anonymity is never 100% absolute"
        STR_DISCLAIMER7="- Will not use these tools for illegal activities"
        STR_DISCLAIMER8="RESPONSIBLE USE: This script is designed to protect"
        STR_DISCLAIMER9="your online privacy in a legal and responsible manner."
        STR_CONTINUE="Press Enter to continue..."
        
        # Menu sections
        STR_MENU_BASIC="INSTALLATION AND BASIC CONFIGURATION:"
        STR_MENU_MAX_PROTECTION="MAXIMUM PROTECTION:"
        STR_MENU_ISOLATION="ISOLATED ENVIRONMENT CONFIGURATION:"
        
        # Menu options
        STR_MENU1="Install all (Tor, Proxychains, Anonsurf)"
        STR_MENU2="Launch Tor Browser"
        STR_MENU3="Launch browser with Proxychains"
        STR_MENU4="Start Anonsurf"
        STR_MENU5="Stop Anonsurf"
        STR_MENU6="Check current IP"
        STR_MENU7="Clean cache and cookies"
        STR_MENU8="Configure Docker (isolated container)"
        STR_MENU9="Configure Firejail (sandbox)"
        STR_MENU10="Info and setup Whonix VM"
        STR_MENU11="Info and setup Tails OS"
        STR_MENU12="Compare isolation options"
        STR_MENU13="Start Tor + Proxychains + Anonsurf together"
        STR_MENU14="Stop all protection services"
        STR_MENU15="Show disclaimer"
        STR_MENU16="Change language"
        STR_MENU0="Exit"
        
        STR_SELECT="Select an option"
        STR_PRESS_ENTER="Press Enter to continue..."
        STR_INVALID_OPTION="Invalid option"
        STR_GOODBYE="Thank you for using the anonymization script!"
        
        # Messaggi per compare_isolation_options
        STR_ISOLATION_TITLE="COMPARISON BETWEEN ISOLATION OPTIONS"
        STR_ISOLATION1="1. Native Execution (directly on the system)"
        STR_ISOLATION1_PRO="   Pro: Easy configuration, no virtualization overhead"
        STR_ISOLATION1_CON="   Con: Lower isolation, potential data leaks, all temporary files remain on the host system"
        
        STR_ISOLATION2="2. Docker Container"
        STR_ISOLATION2_PRO="   Pro: Lightweight, easy to use, process isolation, reproducible on any system with Docker"
        STR_ISOLATION2_CON="   Con: Shares the kernel with the host, incomplete isolation, possible data leaks"
        STR_ISOLATION2_REC="   Recommended for: Users who want an easy-to-configure environment with decent isolation"
        
        STR_ISOLATION3="3. Firejail (Sandbox)"
        STR_ISOLATION3_PRO="   Pro: Very lightweight, simple to use, great for isolating single applications"
        STR_ISOLATION3_CON="   Con: Does not completely isolate the system, shares resources with the host"
        STR_ISOLATION3_REC="   Recommended for: Isolating browsers or other single applications with limited resources"
        
        STR_ISOLATION4="4. Whonix in Virtual Machine"
        STR_ISOLATION4_PRO="   Pro: Excellent isolation, dual VM system (Gateway + Workstation), specifically designed for anonymity"
        STR_ISOLATION4_CON="   Con: Requires more system resources, more complex configuration"
        STR_ISOLATION4_REC="   Recommended for: Users who need a high level of anonymity and security"
        
        STR_ISOLATION5="5. Tails OS (Live System)"
        STR_ISOLATION5_PRO="   Pro: Maximum isolation and amnesia (doesn't save data), all traffic passes through Tor"
        STR_ISOLATION5_CON="   Con: Requires system reboot, USB stick needed, limitations in persistent usage"
        STR_ISOLATION5_REC="   Recommended for: Maximum security and anonymity, situations requiring no traces"
        
        STR_ISOLATION_FINAL="FINAL ADVICE:"
        STR_ISOLATION_REC1="- For occasional use: Firejail or native execution"
        STR_ISOLATION_REC2="- For regular use with good isolation: Docker"
        STR_ISOLATION_REC3="- For high security with frequent use: Whonix VM"
        STR_ISOLATION_REC4="- For high-risk situations or single sessions: Tails OS"
        
        # Messaggi per use_all_tools_together
        STR_ALL_TOOLS_START="Starting all tools together for maximum protection..."
        STR_TOR_START="Step 1: Starting Tor service..."
        STR_TOR_ERROR="Error starting Tor. Unable to continue."
        STR_TOR_SUCCESS="Tor service started"
        STR_ANONSURF_START="Step 2: Starting Anonsurf..."
        STR_ANONSURF_ERROR="Error starting Anonsurf. Stop Tor and try again."
        STR_ANONSURF_SUCCESS="Anonsurf started successfully"
        STR_PROXY_CHECK="Step 3: Checking Proxychains configuration..."
        STR_PROXY_NOT_FOUND="Proxychains configuration file not found."
        STR_PROXY_INSTALL="Installing Proxychains..."
        STR_PROXY_INSTALL_ERROR="Cannot install Proxychains. Stop other services and try again."
        STR_PROXY_ADD_TOR="Adding Tor proxy to Proxychains..."
        STR_PROXY_SUCCESS="Proxychains configured correctly"
        STR_VERIFY_COMBINED="Step 4: Verifying combined operation..."
        STR_IP_CHECK="Checking IP through all protection layers:"
        STR_IP_WARNING="Unable to obtain IP. This might indicate that the protection is very strong or there's a connection problem."
        STR_IP_ANON="Your anonymized public IP is:"
        STR_BROWSER_MAX="Step 5: Starting browser with maximum protection..."
        STR_FIREFOX_START="Starting Firefox through Proxychains (with Tor and Anonsurf active)..."
        STR_CHROME_START="Starting Chrome through Proxychains (with Tor and Anonsurf active)..."
        STR_CHROMIUM_START="Starting Chromium through Proxychains (with Tor and Anonsurf active)..."
        STR_BROWSER_ERROR="No compatible browser found. Install Firefox, Chrome, or Chromium."
        STR_ALL_SUCCESS="All systems started correctly together"
        STR_MAX_PROTECTION="Protection is now at maximum levels with: Tor + Proxychains + Anonsurf"
        STR_JS_WARNING="Remember: Disable JavaScript and clear cookies/cache for maximum security"
        
        # Messaggi per stop_all_tools
        STR_STOP_ALL="Stopping all protection tools..."
        STR_ANONSURF_STOP="Stopping Anonsurf..."
        STR_TOR_STOP="Stopping Tor service..."
        STR_ALL_STOPPED="All protection services have been stopped"
        STR_REAL_IP="Checking your real IP:"
        STR_CURRENT_IP="Your current public IP is:"
        
        # ... Add more strings as needed
    else
        # Italian strings (default)
        STR_TITLE="Tool di Anonimizzazione Online"
        STR_DISCLAIMER_TITLE="DISCLAIMER - LEGGERE PRIMA DELL'UTILIZZO"
        STR_DISCLAIMER1="Questo software è fornito esclusivamente a scopo educativo"
        STR_DISCLAIMER2="e di ricerca. L'autore non si assume alcuna responsabilità"
        STR_DISCLAIMER3="per l'uso improprio di questo strumento."
        STR_DISCLAIMER4="Utilizzando questo script, l'utente accetta che:"
        STR_DISCLAIMER5="- Utilizzerà questi strumenti in conformità con tutte le leggi"
        STR_DISCLAIMER6="- Non è garantito un anonimato completo"
        STR_DISCLAIMER7="- L'anonimato online non è mai assoluto al 100%"
        STR_DISCLAIMER8="- Non utilizzerà questi strumenti per attività illecite"
        STR_DISCLAIMER9="USO RESPONSABILE: Questo script è pensato per proteggere"
        STR_DISCLAIMER10="la tua privacy online in modo legale e responsabile."
        STR_CONTINUE="Premi Enter per continuare..."
        
        # Menu sections
        STR_MENU_BASIC="INSTALLAZIONE E CONFIGURAZIONE BASE:"
        STR_MENU_MAX_PROTECTION="MASSIMA PROTEZIONE:"
        STR_MENU_ISOLATION="CONFIGURAZIONE AMBIENTI ISOLATI:"
        
        # Menu options
        STR_MENU1="Installa tutto (Tor, Proxychains, Anonsurf)"
        STR_MENU2="Avvia Tor Browser"
        STR_MENU3="Avvia browser con Proxychains"
        STR_MENU4="Avvia Anonsurf"
        STR_MENU5="Ferma Anonsurf"
        STR_MENU6="Verifica IP corrente"
        STR_MENU7="Pulisci cache e cookie"
        STR_MENU8="Configura Docker (container isolato)"
        STR_MENU9="Configura Firejail (sandbox)"
        STR_MENU10="Info e setup Whonix VM"
        STR_MENU11="Info e setup Tails OS"
        STR_MENU12="Confronto tra le opzioni di isolamento"
        STR_MENU13="Avvia Tor + Proxychains + Anonsurf insieme"
        STR_MENU14="Ferma tutti i servizi di protezione"
        STR_MENU15="Mostra disclaimer"
        STR_MENU16="Cambia lingua"
        STR_MENU0="Esci"
        
        STR_SELECT="Seleziona un'opzione"
        STR_PRESS_ENTER="Premi Enter per continuare..."
        STR_INVALID_OPTION="Opzione non valida"
        STR_GOODBYE="Grazie per aver usato lo script di anonimizzazione!"
        
        # Messaggi per compare_isolation_options (italiano)
        STR_ISOLATION_TITLE="CONFRONTO TRA OPZIONI DI ISOLAMENTO"
        STR_ISOLATION1="1. Esecuzione Nativa (direttamente sul sistema)"
        STR_ISOLATION1_PRO="   Pro: Facilità di configurazione, nessun overhead di virtualizzazione"
        STR_ISOLATION1_CON="   Contro: Minore isolamento, potenziali fughe di dati, tutti i file temporanei rimangono sul sistema host"
        
        STR_ISOLATION2="2. Docker Container"
        STR_ISOLATION2_PRO="   Pro: Leggero, facile da utilizzare, isolamento dei processi, riproducibile su qualsiasi sistema con Docker"
        STR_ISOLATION2_CON="   Contro: Condivide il kernel con l'host, isolamento non completo, possibili fughe di dati"
        STR_ISOLATION2_REC="   Consigliato per: Utenti che vogliono un ambiente facile da configurare con discreto isolamento"
        
        STR_ISOLATION3="3. Firejail (Sandbox)"
        STR_ISOLATION3_PRO="   Pro: Leggero, semplice da usare, ottimo per isolare singole applicazioni"
        STR_ISOLATION3_CON="   Contro: Non isola completamente il sistema, condivide risorse con l'host"
        STR_ISOLATION3_REC="   Consigliato per: Isolare browser o altre singole applicazioni con risorse limitate"
        
        STR_ISOLATION4="4. Whonix in Virtual Machine"
        STR_ISOLATION4_PRO="   Pro: Eccellente isolamento, sistema a doppio VM (Gateway + Workstation), progettato specificamente per l'anonimato"
        STR_ISOLATION4_CON="   Contro: Richiede più risorse di sistema, configurazione più complessa"
        STR_ISOLATION4_REC="   Consigliato per: Utenti che necessitano di alto livello di anonimato e sicurezza"
        
        STR_ISOLATION5="5. Tails OS (Live System)"
        STR_ISOLATION5_PRO="   Pro: Massimo isolamento e amnesia (non salva dati), tutto il traffico passa attraverso Tor"
        STR_ISOLATION5_CON="   Contro: Richiede riavvio del sistema, necessaria chiavetta USB, limitazioni nell'uso persistente"
        STR_ISOLATION5_REC="   Consigliato per: Massima sicurezza e anonimato, situazioni che richiedono non lasciare tracce"
        
        STR_ISOLATION_FINAL="CONSIGLIO FINALE:"
        STR_ISOLATION_REC1="- Per uso occasionale: Firejail o esecuzione nativa"
        STR_ISOLATION_REC2="- Per uso regolare con buon isolamento: Docker"
        STR_ISOLATION_REC3="- Per alta sicurezza con uso frequente: Whonix VM"
        STR_ISOLATION_REC4="- Per situazioni ad alto rischio o per sessioni singole: Tails OS"
        
        # Messaggi per use_all_tools_together
        STR_ALL_TOOLS_START="Avvio di tutti gli strumenti insieme per la massima protezione..."
        STR_TOR_START="Step 1: Avvio del servizio Tor..."
        STR_TOR_ERROR="Errore nell'avvio di Tor. Impossibile continuare."
        STR_TOR_SUCCESS="Servizio Tor avviato"
        STR_ANONSURF_START="Step 2: Avvio di Anonsurf..."
        STR_ANONSURF_ERROR="Errore nell'avvio di Anonsurf. Ferma Tor e riprova."
        STR_ANONSURF_SUCCESS="Anonsurf avviato correttamente"
        STR_PROXY_CHECK="Step 3: Verifica configurazione di Proxychains..."
        STR_PROXY_NOT_FOUND="File di configurazione Proxychains non trovato."
        STR_PROXY_INSTALL="Installazione di Proxychains..."
        STR_PROXY_INSTALL_ERROR="Impossibile installare Proxychains. Ferma gli altri servizi e riprova."
        STR_PROXY_ADD_TOR="Aggiungo il proxy Tor a Proxychains..."
        STR_PROXY_SUCCESS="Proxychains configurato correttamente"
        STR_VERIFY_COMBINED="Step 4: Verifica del funzionamento combinato..."
        STR_IP_CHECK="Verifica dell'IP attraverso tutti i livelli di protezione:"
        STR_IP_WARNING="Non è stato possibile ottenere l'IP. Questo potrebbe indicare che la protezione è molto forte o che c'è un problema di connessione."
        STR_IP_ANON="Il tuo IP pubblico anonimizzato è:"
        STR_BROWSER_MAX="Step 5: Avvio browser con protezione massima..."
        STR_FIREFOX_START="Avvio Firefox attraverso Proxychains (con Tor e Anonsurf attivi)..."
        STR_CHROME_START="Avvio Chrome attraverso Proxychains (con Tor e Anonsurf attivi)..."
        STR_CHROMIUM_START="Avvio Chromium attraverso Proxychains (con Tor e Anonsurf attivi)..."
        STR_BROWSER_ERROR="Nessun browser compatibile trovato. Installa Firefox, Chrome o Chromium."
        STR_ALL_SUCCESS="Tutti i sistemi avviati correttamente insieme"
        STR_MAX_PROTECTION="La protezione è ora ai massimi livelli con: Tor + Proxychains + Anonsurf"
        STR_JS_WARNING="Ricorda: Disabilita JavaScript e cancella cookie/cache per massima sicurezza"
        
        # Messaggi per stop_all_tools
        STR_STOP_ALL="Arresto di tutti gli strumenti di protezione..."
        STR_ANONSURF_STOP="Arresto di Anonsurf..."
        STR_TOR_STOP="Arresto del servizio Tor..."
        STR_ALL_STOPPED="Tutti i servizi di protezione sono stati arrestati"
        STR_REAL_IP="Verifica dell'IP reale:"
        STR_CURRENT_IP="Il tuo IP pubblico attuale è:"
    fi
}

# Funzione per mostrare solo il logo (non cambia con la lingua)
show_logo() {
    cat << "EOF"
    _                      _                 
   / \   _ __   ___  _ __ (_)_ __ ___   ___  
  / _ \ | '_ \ / _ \| '_ \| | '_ ` _ \ / _ \ 
 / ___ \| | | | (_) | | | | | | | | | | (_) |
/_/   \_\_| |_|\___/|_| |_|_|_| |_| |_|\___/ 
                                           
EOF
    # Mostra il titolo nella lingua corrente
    echo " $STR_TITLE - v1.0"
}

# Funzione per mostrare il disclaimer
show_disclaimer() {
    cat << EOF
=========================================================
⚠️  $STR_DISCLAIMER_TITLE
=========================================================

$STR_DISCLAIMER1
$STR_DISCLAIMER2
$STR_DISCLAIMER3

$STR_DISCLAIMER4
$STR_DISCLAIMER5
$STR_DISCLAIMER6
$STR_DISCLAIMER7
$STR_DISCLAIMER8

$STR_DISCLAIMER9
$STR_DISCLAIMER10
=========================================================

EOF
    echo "$STR_CONTINUE"
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
    show_logo  # Mostra sempre il logo in cima
    echo -e "${BLUE}===========================================${NC}"
    echo -e "${BLUE}    $STR_ISOLATION_TITLE    ${NC}"
    echo -e "${BLUE}===========================================${NC}"
    echo ""
    
    echo -e "${YELLOW}$STR_ISOLATION1${NC}"
    echo "$STR_ISOLATION1_PRO"
    echo "$STR_ISOLATION1_CON"
    echo ""
    
    echo -e "${YELLOW}$STR_ISOLATION2${NC}"
    echo "$STR_ISOLATION2_PRO"
    echo "$STR_ISOLATION2_CON"
    echo "$STR_ISOLATION2_REC"
    echo ""
    
    echo -e "${YELLOW}$STR_ISOLATION3${NC}"
    echo "$STR_ISOLATION3_PRO"
    echo "$STR_ISOLATION3_CON"
    echo "$STR_ISOLATION3_REC"
    echo ""
    
    echo -e "${YELLOW}$STR_ISOLATION4${NC}"
    echo "$STR_ISOLATION4_PRO"
    echo "$STR_ISOLATION4_CON"
    echo "$STR_ISOLATION4_REC"
    echo ""
    
    echo -e "${YELLOW}$STR_ISOLATION5${NC}"
    echo "$STR_ISOLATION5_PRO"
    echo "$STR_ISOLATION5_CON"
    echo "$STR_ISOLATION5_REC"
    echo ""
    
    echo -e "${YELLOW}$STR_ISOLATION_FINAL${NC}"
    echo "$STR_ISOLATION_REC1"
    echo "$STR_ISOLATION_REC2"
    echo "$STR_ISOLATION_REC3"
    echo "$STR_ISOLATION_REC4"
    echo ""
}

# Avvia tutti gli strumenti insieme per la massima protezione
use_all_tools_together() {
    print_status "$STR_ALL_TOOLS_START"
    
    # Step 1: Avvia Tor
    print_status "$STR_TOR_START"
    service tor start
    if [ $? -ne 0 ]; then
        print_error "$STR_TOR_ERROR"
        return 1
    fi
    print_success "$STR_TOR_SUCCESS"
    
    # Step 2: Avvia Anonsurf
    print_status "$STR_ANONSURF_START"
    anonsurf start
    if [ $? -ne 0 ]; then
        print_error "$STR_ANONSURF_ERROR"
        service tor stop
        return 1
    fi
    print_success "$STR_ANONSURF_SUCCESS"
    
    # Step 3: Verifica configurazione di Proxychains
    print_status "$STR_PROXY_CHECK"
    CONFIG_FILE="/etc/proxychains4.conf"
    if [ ! -f "$CONFIG_FILE" ]; then
        CONFIG_FILE="/etc/proxychains.conf"
    fi
    
    if [ ! -f "$CONFIG_FILE" ]; then
        print_error "$STR_PROXY_NOT_FOUND"
        print_status "$STR_PROXY_INSTALL"
        apt install -y proxychains4
        
        CONFIG_FILE="/etc/proxychains4.conf"
        if [ ! -f "$CONFIG_FILE" ]; then
            CONFIG_FILE="/etc/proxychains.conf"
        fi
        
        if [ ! -f "$CONFIG_FILE" ]; then
            print_error "$STR_PROXY_INSTALL_ERROR"
            anonsurf stop
            service tor stop
            return 1
        fi
    fi
    
    # Verifica che il proxy Tor sia configurato in Proxychains
    if ! grep -q "socks5 127.0.0.1 9050" "$CONFIG_FILE"; then
        print_status "$STR_PROXY_ADD_TOR"
        echo "socks5 127.0.0.1 9050" >> "$CONFIG_FILE"
    fi
    print_success "$STR_PROXY_SUCCESS"
    
    # Step 4: Verifica che tutto funzioni insieme
    print_status "$STR_VERIFY_COMBINED"
    
    sleep 3
    
    # Usa Proxychains+Tor+Anonsurf per verificare l'IP
    print_status "$STR_IP_CHECK"
    CURRENT_IP=$(proxychains curl -s ifconfig.me)
    if [ -z "$CURRENT_IP" ]; then
        print_warning "$STR_IP_WARNING"
    else
        echo -e "${GREEN}$STR_IP_ANON ${CURRENT_IP}${NC}"
    fi
    
    # Step 5: Avvia browser con massima protezione
    print_status "$STR_BROWSER_MAX"
    
    # Controlla se Firefox è installato
    if command -v firefox &> /dev/null; then
        print_status "$STR_FIREFOX_START"
        proxychains firefox -private-window about:blank &
    elif command -v google-chrome &> /dev/null; then
        print_status "$STR_CHROME_START"
        proxychains google-chrome --incognito about:blank &
    elif command -v chromium-browser &> /dev/null; then
        print_status "$STR_CHROMIUM_START"
        proxychains chromium-browser --incognito about:blank &
    else
        print_error "$STR_BROWSER_ERROR"
        return 1
    fi
    
    print_success "$STR_ALL_SUCCESS"
    print_status "$STR_MAX_PROTECTION"
    print_warning "$STR_JS_WARNING"
    
    return 0
}

# Ferma tutti gli strumenti insieme
stop_all_tools() {
    print_status "$STR_STOP_ALL"
    
    print_status "$STR_ANONSURF_STOP"
    anonsurf stop
    
    print_status "$STR_TOR_STOP"
    service tor stop
    
    print_success "$STR_ALL_STOPPED"
    
    print_status "$STR_REAL_IP"
    CURRENT_IP=$(curl -s ifconfig.me)
    echo -e "${YELLOW}$STR_CURRENT_IP ${CURRENT_IP}${NC}"
}

# Menu principale
show_menu() {
    clear
    show_logo  # Mostra sempre il logo in cima
    echo ""
    echo -e "${BLUE}====================================${NC}"
    echo -e "${BLUE}    $STR_TITLE    ${NC}"
    echo -e "${BLUE}====================================${NC}"
    echo ""
    echo -e "${YELLOW}$STR_MENU_BASIC${NC}"
    echo -e "${YELLOW}1.${NC} $STR_MENU1"
    echo -e "${YELLOW}2.${NC} $STR_MENU2"
    echo -e "${YELLOW}3.${NC} $STR_MENU3"
    echo -e "${YELLOW}4.${NC} $STR_MENU4"
    echo -e "${YELLOW}5.${NC} $STR_MENU5"
    echo -e "${YELLOW}6.${NC} $STR_MENU6"
    echo -e "${YELLOW}7.${NC} $STR_MENU7"
    echo ""
    echo -e "${RED}$STR_MENU_MAX_PROTECTION${NC}"
    echo -e "${RED}13.${NC} $STR_MENU13"
    echo -e "${RED}14.${NC} $STR_MENU14"
    echo ""
    echo -e "${YELLOW}$STR_MENU_ISOLATION${NC}"
    echo -e "${YELLOW}8.${NC} $STR_MENU8"
    echo -e "${YELLOW}9.${NC} $STR_MENU9"
    echo -e "${YELLOW}10.${NC} $STR_MENU10"
    echo -e "${YELLOW}11.${NC} $STR_MENU11"
    echo -e "${YELLOW}12.${NC} $STR_MENU12"
    echo ""
    echo -e "${YELLOW}0.${NC} $STR_MENU0"
    echo -e "${YELLOW}15.${NC} $STR_MENU15"
    echo -e "${YELLOW}16.${NC} $STR_MENU16"
    echo ""
    echo -n "$STR_SELECT [0-16]: "
    read choice

    case $choice in
        1)
            check_root
            install_tor_browser
            setup_proxychains
            setup_anonsurf
            echo "$STR_PRESS_ENTER"
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
            echo "$STR_PRESS_ENTER"
            read
            show_menu
            ;;
        5)
            check_root
            stop_anonsurf
            echo "$STR_PRESS_ENTER"
            read
            show_menu
            ;;
        6)
            print_status "Verifica del tuo IP pubblico:"
            CURRENT_IP=$(curl -s ifconfig.me)
            echo -e "${GREEN}Il tuo IP pubblico attuale è: ${CURRENT_IP}${NC}"
            echo "$STR_PRESS_ENTER"
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
            
            echo "$STR_PRESS_ENTER"
            read
            show_menu
            ;;
        8)
            check_root
            setup_docker
            echo "$STR_PRESS_ENTER"
            read
            show_menu
            ;;
        9)
            check_root
            setup_firejail
            echo "$STR_PRESS_ENTER"
            read
            show_menu
            ;;
        10)
            setup_whonix_vm
            echo "$STR_PRESS_ENTER"
            read
            show_menu
            ;;
        11)
            setup_tails
            echo "$STR_PRESS_ENTER"
            read
            show_menu
            ;;
        12)
            compare_isolation_options
            echo "$STR_PRESS_ENTER"
            read
            show_menu
            ;;
        13)
            check_root
            use_all_tools_together
            echo "$STR_PRESS_ENTER"
            read
            show_menu
            ;;
        14)
            check_root
            stop_all_tools
            echo "$STR_PRESS_ENTER"
            read
            show_menu
            ;;
        15)
            clear
            show_logo      # Mostra il logo
            show_disclaimer # Poi il disclaimer
            show_menu
            ;;
        16)
            select_language
            show_menu
            ;;
        0)
            clear
            echo "$STR_GOODBYE"
            exit 0
            ;;
        *)
            print_error "$STR_INVALID_OPTION"
            sleep 1
            show_menu
            ;;
    esac
}

# Avvio dello script
select_language  # Prima selezione lingua
load_language_strings  # Caricamento stringhe iniziali
show_banner  # Mostra il logo e il disclaimer all'avvio
show_menu    # Poi mostra il menu principale