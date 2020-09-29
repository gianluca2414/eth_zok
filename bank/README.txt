Smart Contract che rappresenta una banca molto semplice e con funzionalità estremamente basilari.
Supporta la creazione di un account con un saldo iniziale (la banca può contenere massimo 10 account), l'invio di denaro ad altri accounti, la ricezione di denaro.
Lo scopo del contratto era quello di andare a testare il funzionamento del meccanismo di Zokrates nella pratica: è per questo che nella funzione getLoan, tramite
la quale si può richiedere un prestito di un certo valore, interviene anche la funzione verifyTx, che ha il compito di prendere una proof e verificarla.
In particolare supponiamo che uno dei requisiti per accedere al prestito sia avere un certo Isee (nell'esempio deve essere maggiore di 1000). A questo punto il
richiedente, in locale, tramite zokrates genererà una proof che attesti che il suo isee è valido per il prestito (senza però rivelare alcun valore). Il richiedente
quindi richiamerà la funzione getLoan, alla quale passerà anche la proof. Il verificatore di zokrates confermerà o meno la validità della proof, permettendo o meno
l'accesso al prestito.
