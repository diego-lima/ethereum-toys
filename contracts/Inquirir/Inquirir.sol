pragma solidity ^0.4.24; 
/**
Inquirir

Inquérito: 
    Texto
    Prêmio
    Inquerido

Inquisidor:
    Nome
    ID
    Pontos de inquisição
 */


contract Inquirir {

    struct Inquerito {
        // bytes32 texto;
        address inquerido;
        uint premio;
    }

    Inquerito[] public inqueritosArray;

    //////////
    //          Inqueritos
    //////////

    function put(uint _premio) public returns (uint){
        return inqueritosArray.push(
            Inquerito({inquerido: msg.sender, premio: _premio})
            // Inquerito({texto: _texto, inquerido: msg.sender, premio: _premio})
        )-1;

    }
    
    // function abrirInquerito(bytes32 _texto, uint _premio) public returns (uint){
    //     Inquerito memory novoInquerito;
    //     novoInquerito.texto = _texto;
    //     novoInquerito.premio = _premio;
    //     // novoInquerito.inquerido = _inquerido;
    //     novoInquerito.encerrado = false;

    //     return inqueritosArray.push(novoInquerito)-1;

    // }

    function listarInqueritos () public view returns (uint[], address[]) {

        uint[] memory premios = new uint[](inqueritosArray.length);
        // bytes32[] memory textos = new bytes32[](inqueritosArray.length);
        address[] memory inqueridos = new address[](inqueritosArray.length);

        for (uint i = 0; i < inqueritosArray.length; i++){
            premios[i] = inqueritosArray[i].premio;
            // textos[i] = inqueritosArray[i].texto;
            inqueridos[i] = inqueritosArray[i].inquerido;
        }

        return (premios, inqueridos);
        
    }

    // function pegarInquerito(uint _indice) public view returns (bytes32,uint, bool) {
    //     return (inqueritosArray[_indice].texto, inqueritosArray[_indice].premio, inqueritosArray[_indice].encerrado);
    // }

}