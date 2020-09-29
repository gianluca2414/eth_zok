pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;

import "browser/verifier11.sol";


contract Bank is Verifier{
    
    struct Account{
        string name;
        address adr;
        uint money;
    }
    
    struct prova{
        uint[2] a;
        uint[2][2] b;
        uint[2] c;
    }
    
    Account[10] private accounts;
    
    
    
    
    //costruttore che inizializza le strutture dati
    constructor() public{
        for(uint i=0; i<10; i++){
            accounts[i].name="";
            accounts[i].adr=address(0);
        }
    }
    
    
    
    
    //funzione che verifica se c'è spazio per altri conti o no
    function isFull() private view returns (uint){
        for(uint i=0; i<10; i++){
            if(accounts[i].adr == address(0)){
                return i; //non è pieno, c'è ancora spazio, ritorno la prima posizione vuota
            }
        }
        return 11; //è tutto pieno, ritorno una postazione non valida
    }
    
    
    
    
    //Creazione di un account. Saldo iniziale di 100.
    function createAccount(string memory nome_) public returns (bool){
        if(isIn(msg.sender) == false){ //la persona non deve gia avere un conto
            uint index=isFull();
            if(index != 11){ //ci deve essere spazio per un nuovo conto
                accounts[index].adr = msg.sender;
                accounts[index].name = nome_;
                accounts[index].money = 100;
                return true;
            }
        }
        return false;
    }
    
    
    
    function getMyName() public view returns (string memory){
       uint index=lookup(msg.sender);
       return accounts[index].name;
    }
    
    
    
    //Funzione per il controllo se una persona ha il conto nella banca
    function isIn(address my_address) private view returns (bool){ 
        for(uint i=0; i<10; i++){
            if(accounts[i].adr==my_address){
                return true;
            }
        }
        return false;
    }
    
    
    
    
    //funzione ricerca account dato indirizzo
    function lookup(address msg_adr) private view returns (uint){
        for(uint i=0; i<10; i++){
            if(accounts[i].adr == msg_adr){
                return i;
            }
        }
        return 11;
    }
    
    
    
    
    //visualizzare il bilancio
    function getMyBalance() public view returns ( uint){
        if(isIn(msg.sender) == true){ //la persona ha effettivamente un conto in banca
            uint index = lookup(msg.sender);
            return accounts[index].money;
        }
    }
    
    
    
    
    //invio di denaro
    function sendMoney(uint value, address dst) public returns (bool){
        if(isIn(msg.sender) == true && isIn(dst) == true){
            uint index_sender = lookup(msg.sender);
            uint index_reciver = lookup(dst);
            
            if(accounts[index_sender].money >= value){
                accounts[index_sender].money -= value;
                accounts[index_reciver].money += value;
                return true;
            }
        }
        
        return false;
    }
    
    
    
    
    //richiesta di prestito. Funzione che richiede che l'utente abbia un certo ISEE per richiedere il prestito.
    //l'informazione dell'ISEE deve essere resa come una proof 0-knowledge tramite zokrates
    function getLoan(uint value, uint[2] memory a, uint[2][2] memory b,uint[2] memory c) public returns (bool){
        prova memory proofISEE;
        proofISEE.a=a;
        proofISEE.b=b;
        proofISEE.c=c;
        
        require(Verifier.verifyTx(proofISEE.a, proofISEE.b, proofISEE.c) == true);
        uint index_loan = lookup(msg.sender);
        accounts[index_loan].money += value;
        return true;
    }
    
    
}
