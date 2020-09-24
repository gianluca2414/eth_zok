pragma solidity >=0.4.22 <0.7.0;

//Contract that store the prooving key
contract Storage {

    string prov_key;

    //storing the proving key
    function store(string memory key_) public {
        prov_key=key_;
    }

    //retrieve the proving key
    function retrieve() public view returns (string memory){
        return prov_key;
    }
}