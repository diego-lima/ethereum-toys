pragma solidity ^0.4.23;

contract Poll {
    
    address public owner;

    bytes32 public pergunta;

    struct Resposta {
        bytes32 texto;
        uint votos;
    }

    Resposta[] public respostas;

    function newResposta(bytes32 texto) public returns(uint rowNumber) {
        
        if (respostas.length >= 10){
            return 0;
        }

        Resposta memory newResposta;
        newResposta.texto = texto;

        return respostas.push(newResposta)-1;
    }

    // Construtor
    constructor (bytes32 texto) public {
        owner = msg.sender;
        pergunta = texto;
    }

    // Destrutor
    function kill() public {
        if (msg.sender == owner)
            selfdestruct(owner);
    }

}