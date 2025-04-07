# Progetto di Anonimizzazione Online / Online Anonymization Project

[🇮🇹 Italiano](#italian) | [🇬🇧 English](#english)

---

<a name="italian"></a>
# 🇮🇹 Progetto di Anonimizzazione Online

Questo repository contiene uno script per configurare e utilizzare vari strumenti di anonimizzazione online (Tor, Proxychains, Anonsurf) in diversi ambienti isolati.

## ⚠️ DISCLAIMER

**IMPORTANTE: LEGGERE PRIMA DELL'UTILIZZO**

Questo software è fornito esclusivamente a scopo educativo e di ricerca. L'autore non si assume alcuna responsabilità per l'uso improprio di questo strumento. Utilizzando questo software, l'utente accetta di:

1. **Utilizzo legale**: Utilizzare questi strumenti in conformità con tutte le leggi locali, nazionali e internazionali applicabili. L'anonimato online può essere illegale in alcune giurisdizioni.

2. **Nessuna garanzia**: Questo software è fornito "così com'è", senza garanzie di alcun tipo. Non è garantito che fornisca un anonimato completo o che sia privo di vulnerabilità.

3. **Rischi**: L'utente riconosce che l'anonimato online non è mai assoluto al 100%. Errori di configurazione, vulnerabilità del software o attacchi mirati possono compromettere la privacy.

4. **Uso responsabile**: L'utente si impegna a non utilizzare questi strumenti per attività illecite, molestie, violazioni della privacy altrui o qualsiasi altra attività dannosa.

5. **Limiti tecnici**: Questi strumenti possono rallentare significativamente la connessione internet e alcune funzionalità web potrebbero non funzionare correttamente.

Ricorda che il miglior approccio alla sicurezza online è una combinazione di strumenti tecnici, consapevolezza e comportamenti prudenti.

## Installazione

```bash
# Clona il repository
git clone https://github.com/IacopoLibero/anonimizzazione
cd anonimizzazione

# Rendi eseguibile lo script principale
chmod +x anon_setup.sh

# Esegui lo script (richiede privilegi di root per alcune operazioni)
sudo ./anon_setup.sh
```

## Funzionalità

Lo script offre diverse opzioni:
- Installazione e configurazione di Tor, Proxychains e Anonsurf
- Avvio di browser anonimizzati tramite Proxychains
- Controllo dell'IP pubblico
- Pulizia di cache e cookie
- Configurazione di vari ambienti isolati (Docker, Firejail, VM)
- Supporto multilingua (Italiano e Inglese)

## Ordine di Utilizzo Consigliato

Lo script offre due approcci principali per l'anonimizzazione:

### Approccio 1: Utilizzare un Ambiente Isolato (consigliato)

Questo è l'ordine consigliato per massima sicurezza:

1. **Prima configura l'ambiente isolato**:
   - Opzione 8: Configura Docker
   - Opzione 9: Configura Firejail
   - Opzione 10: Setup Whonix VM
   - Opzione 11: Setup Tails OS

2. **Poi utilizza gli strumenti all'interno dell'ambiente isolato**:
   - Gli ambienti Docker e Firejail hanno già preconfigurato Tor, Proxychains e AnonSurf
   - Per Whonix e Tails, tutti gli strumenti sono già integrati nel sistema

Con questo approccio, non è necessario installare gli strumenti sul sistema host, poiché verranno configurati automaticamente nell'ambiente isolato.

### Approccio 2: Installazione Diretta sul Sistema Host

Se preferisci non utilizzare ambienti isolati (meno sicuro ma più pratico):

1. **Prima installa gli strumenti**:
   - Opzione 1: Installa Tor, Proxychains, Anonsurf
   
2. **Poi utilizzali**:
   - Opzione 2: Avvia Tor Browser
   - Opzione 3: Avvia browser con Proxychains
   - Opzione 4: Avvia Anonsurf

### Nota Importante:
- **Non è necessario** installare gli strumenti sul sistema host se prevedi di utilizzare Docker, Firejail, Whonix o Tails
- Ogni ambiente isolato ha il proprio set di strumenti indipendente dal sistema host
- L'opzione 12 ti aiuta a confrontare le diverse opzioni per scegliere quella più adatta alle tue esigenze

## Opzioni Disponibili per l'Anonimizzazione

### 1. Docker Container

**Cos'è**: Docker è una piattaforma che permette di eseguire applicazioni in container isolati che condividono il kernel del sistema operativo host ma sono isolati a livello di file system, rete e processi.

**Vantaggi**:
- Facile da configurare e utilizzare
- Leggero (meno overhead rispetto a una VM)
- Ambiente riproducibile e portabile
- Isolamento dei processi e del file system

**Svantaggi**:
- Condivide il kernel con l'host (isolamento non completo)
- Potrebbe richiedere privilegi di root per alcune operazioni di rete

**Ideale per**: Utenti intermedi che vogliono un buon compromesso tra isolamento e facilità d'uso.

### 2. Firejail (Sandbox)

**Cos'è**: Firejail è uno strumento di sandboxing che limita l'ambiente di esecuzione di un processo usando namespaces Linux, seccomp-bpf e altre tecnologie di isolamento.

**Vantaggi**:
- Molto leggero (quasi zero overhead)
- Facile da usare
- Perfetto per isolare singole applicazioni
- Non richiede software aggiuntivo oltre Firejail stesso

**Svantaggi**:
- Isolamento meno completo rispetto a VM o Docker
- Condivide più risorse con il sistema host

**Ideale per**: Utenti che vogliono isolare rapidamente singole applicazioni senza configurazioni complesse.

### 3. Macchina Virtuale Whonix

**Cos'è**: Whonix è un sistema operativo focalizzato sulla privacy che funziona come due macchine virtuali separate: un "Gateway" che inoltra tutto il traffico attraverso Tor e una "Workstation" dove l'utente lavora.

**Vantaggi**:
- Eccellente isolamento (virtualizzazione completa)
- Progettato specificamente per l'anonimato
- Sistema a due VM che previene fughe di dati
- Protezione contro attacchi avanzati

**Svantaggi**:
- Richiede più risorse di sistema
- Configurazione più complessa
- Prestazioni inferiori rispetto a soluzioni più leggere

**Ideale per**: Utenti che necessitano di un alto livello di anonimato e sicurezza.

### 4. Tails OS

**Cos'è**: Tails è un sistema operativo live progettato per preservare la privacy e l'anonimato, che si avvia da USB e non lascia tracce sul computer.

**Vantaggi**:
- Massimo isolamento (sistema completamente separato)
- Amnesia (non salva dati a meno che non venga configurato esplicitamente)
- Tutto il traffico passa attraverso Tor
- Indipendente dal sistema operativo host

**Svantaggi**:
- Richiede riavvio del computer
- Necessaria una chiavetta USB
- Meno conveniente per uso quotidiano
- Le impostazioni si perdono tra una sessione e l'altra (a meno di configurare lo storage persistente)

**Ideale per**: Situazioni ad alto rischio che richiedono massima sicurezza e non lasciare tracce.

## Massima Protezione: Usare Tutti gli Strumenti Insieme

Per ottenere il massimo livello di anonimizzazione, questo progetto permette di utilizzare tutti e tre gli strumenti principali (Tor, Proxychains e Anonsurf) contemporaneamente. Ogni strumento aggiunge un livello diverso di protezione:

### Come Funzionano Insieme

1. **Anonsurf**: Configura tutto il traffico di rete per passare attraverso la rete Tor, modifica le regole del firewall e imposta DNS sicuri. Funziona a livello di sistema.

2. **Tor**: Crea una rete di nodi che cifrano e instradano il traffico attraverso percorsi casuali, rendendo difficile tracciare la tua attività online fino alla sorgente originale.

3. **Proxychains**: Aggiunge un ulteriore livello di inoltro proxy, permettendo di incanalare applicazioni specifiche (come browser) attraverso una catena di proxy configurabile.

Quando utilizzati insieme, creano un sistema a più livelli che massimizza l'anonimato.

## Tabella Comparativa

| Criterio          | Docker     | Firejail   | Whonix VM  | Tails OS   |
|-------------------|------------|------------|------------|------------|
| Livello isolamento| Medio      | Basso-Medio| Alto       | Molto Alto |
| Facilità d'uso    | Media      | Alta       | Media      | Media      |
| Risorse richieste | Basse      | Molto Basse| Alte       | Medie      |
| Persistenza dati  | Sì         | Sì         | Sì         | No*        |
| Protezione IP     | Buona      | Buona      | Molto Buona| Eccellente |
| Uso quotidiano    | Buono      | Ottimo     | Buono      | Difficile  |

\* Tails può essere configurato con storage persistente opzionale.

## Quale Scegliere?

- **Per principianti** interessati alla privacy: Firejail o Docker
- **Per uso quotidiano** con discreta protezione: Docker o Firejail
- **Per attività sensibili** con esigenza di buon isolamento: Whonix VM
- **Per massima protezione** in situazioni critiche: Tails OS

Ricorda che nessuna soluzione offre anonimato perfetto al 100%. La sicurezza dipende anche dalle tue abitudini di navigazione e dall'uso che fai del sistema.

## Contributi

I contributi sono benvenuti! Sentiti libero di aprire issues o pull requests per migliorare questo progetto.

---

<a name="english"></a>
# 🇬🇧 Online Anonymization Project

This repository contains a script to configure and use various online anonymization tools (Tor, Proxychains, Anonsurf) in different isolated environments.

## ⚠️ DISCLAIMER

**IMPORTANT: READ BEFORE USING**

This software is provided for educational and research purposes only. The author assumes no responsibility for misuse of this tool. By using this software, the user agrees to:

1. **Legal use**: Use these tools in compliance with all applicable local, national, and international laws. Online anonymity may be illegal in some jurisdictions.

2. **No warranty**: This software is provided "as is", without warranties of any kind. It is not guaranteed to provide complete anonymity or to be free from vulnerabilities.

3. **Risks**: The user acknowledges that online anonymity is never 100% absolute. Configuration errors, software vulnerabilities, or targeted attacks can compromise privacy.

4. **Responsible use**: The user commits not to use these tools for illegal activities, harassment, violations of others' privacy, or any other harmful activity.

5. **Technical limitations**: These tools can significantly slow down internet connection and some web functionalities may not work properly.

Remember that the best approach to online security is a combination of technical tools, awareness, and prudent behaviors.

## Installation

```bash
# Clone the repository
git clone https://github.com/IacopoLibero/anonimizzazione
cd anonimizzazione

# Make the main script executable
chmod +x anon_setup.sh

# Run the script (requires root privileges for some operations)
sudo ./anon_setup.sh
```

## Features

The script offers several options:
- Installation and configuration of Tor, Proxychains, and Anonsurf
- Launch of anonymized browsers via Proxychains
- IP address verification
- Cache and cookie cleaning
- Configuration of various isolated environments (Docker, Firejail, VM)
- Multilingual support (Italian and English)

## Recommended Usage Order

The script offers two main approaches for anonymization:

### Approach 1: Using an Isolated Environment (recommended)

This is the recommended order for maximum security:

1. **First configure the isolated environment**:
   - Option 8: Configure Docker
   - Option 9: Configure Firejail
   - Option 10: Setup Whonix VM
   - Option 11: Setup Tails OS

2. **Then use the tools inside the isolated environment**:
   - Docker and Firejail environments have Tor, Proxychains, and AnonSurf preconfigured
   - For Whonix and Tails, all tools are already integrated into the system

With this approach, it's not necessary to install the tools on the host system, as they will be automatically configured in the isolated environment.

### Approach 2: Direct Installation on the Host System

If you prefer not to use isolated environments (less secure but more practical):

1. **First install the tools**:
   - Option 1: Install Tor, Proxychains, Anonsurf
   
2. **Then use them**:
   - Option 2: Launch Tor Browser
   - Option 3: Launch browser with Proxychains
   - Option 4: Start Anonsurf

### Important Note:
- It is **not necessary** to install the tools on the host system if you plan to use Docker, Firejail, Whonix, or Tails
- Each isolated environment has its own set of tools independent from the host system
- Option 12 helps you compare the different options to choose the one that best suits your needs

## Options Available for Anonymization

### 1. Docker Container

**What it is**: Docker is a platform that allows applications to run in isolated containers that share the host operating system kernel but are isolated at the file system, network, and process level.

**Advantages**:
- Easy to configure and use
- Lightweight (less overhead compared to a VM)
- Reproducible and portable environment
- Process and file system isolation

**Disadvantages**:
- Shares the kernel with the host (not complete isolation)
- May require root privileges for some network operations

**Ideal for**: Intermediate users who want a good compromise between isolation and ease of use.

### 2. Firejail (Sandbox)

**What it is**: Firejail is a sandboxing tool that limits the execution environment of a process using Linux namespaces, seccomp-bpf, and other isolation technologies.

**Advantages**:
- Very lightweight (almost zero overhead)
- Easy to use
- Perfect for isolating single applications
- Does not require additional software beyond Firejail itself

**Disadvantages**:
- Less complete isolation compared to VM or Docker
- Shares more resources with the host system

**Ideal for**: Users who want to quickly isolate single applications without complex configurations.

### 3. Whonix Virtual Machine

**What it is**: Whonix is a privacy-focused operating system that works as two separate virtual machines: a "Gateway" that routes all traffic through Tor and a "Workstation" where the user works.

**Advantages**:
- Excellent isolation (complete virtualization)
- Specifically designed for anonymity
- Two VM system that prevents data leaks
- Protection against advanced attacks

**Disadvantages**:
- Requires more system resources
- More complex configuration
- Lower performance compared to lighter solutions

**Ideal for**: Users who need a high level of anonymity and security.

### 4. Tails OS

**What it is**: Tails is a live operating system designed to preserve privacy and anonymity, which boots from USB and leaves no traces on the computer.

**Advantages**:
- Maximum isolation (completely separate system)
- Amnesia (does not save data unless explicitly configured)
- All traffic passes through Tor
- Independent from the host operating system

**Disadvantages**:
- Requires computer reboot
- Requires a USB stick
- Less convenient for daily use
- Settings are lost between sessions (unless persistent storage is configured)

**Ideal for**: High-risk situations requiring maximum security and leaving no traces.

## Maximum Protection: Using All Tools Together

To achieve the maximum level of anonymization, this project allows you to use all three main tools (Tor, Proxychains, and Anonsurf) simultaneously. Each tool adds a different layer of protection.

### How They Work Together

1. **Anonsurf**: Configures all network traffic to pass through the Tor network, modifies firewall rules, and sets up secure DNS. It works at the system level.

2. **Tor**: Creates a network of nodes that encrypt and route traffic through random paths, making it difficult to trace your online activity back to the original source.

3. **Proxychains**: Adds an additional layer of proxy forwarding, allowing specific applications (like browsers) to be channeled through a configurable proxy chain.

When used together, they create a multi-layered system that maximizes anonymity.

## Comparison Table

| Criterion         | Docker     | Firejail   | Whonix VM  | Tails OS   |
|-------------------|------------|------------|------------|------------|
| Isolation level   | Medium     | Low-Medium | High       | Very High  |
| Ease of use       | Medium     | High       | Medium     | Medium     |
| Resources required| Low        | Very Low   | High       | Medium     |
| Data persistence  | Yes        | Yes        | Yes        | No*        |
| IP protection     | Good       | Good       | Very Good  | Excellent  |
| Daily usage       | Good       | Excellent  | Good       | Difficult  |

\* Tails can be configured with optional persistent storage.

## Which One to Choose?

- **For beginners** interested in privacy: Firejail or Docker
- **For daily use** with decent protection: Docker or Firejail
- **For sensitive activities** requiring good isolation: Whonix VM
- **For maximum protection** in critical situations: Tails OS

Remember that no solution offers 100% perfect anonymity. Security also depends on your browsing habits and how you use the system.

## Contributions

Contributions are welcome! Feel free to open issues or pull requests to improve this project.