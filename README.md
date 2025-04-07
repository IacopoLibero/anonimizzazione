# Progetto di Anonimizzazione Online

Questo repository contiene uno script per configurare e utilizzare vari strumenti di anonimizzazione online (Tor, Proxychains, Anonsurf) in diversi ambienti isolati.

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