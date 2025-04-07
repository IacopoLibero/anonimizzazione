# Progetto di Anonimizzazione Online

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