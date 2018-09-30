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
        bytes32 texto;
        uint premio;
        address aaa;
        bool encerrado;
    }

    Inquerito[] public inqueritosArray;

    // function abrirInquerito(bytes32 _texto, uint _premio, address _inquerido) public returns (uint){
    function put(bytes32 _texto, uint _premio) public returns (uint){
        return inqueritosArray.push(Inquerito({
            texto: _texto,
            premio: _premio,
            aaa: msg.sender,
            encerrado: false
        }))-1;

    }
    
    function abrirInquerito(bytes32 _texto, uint _premio) public returns (uint){
        Inquerito memory novoInquerito;
        novoInquerito.texto = _texto;
        novoInquerito.premio = _premio;
        // novoInquerito.inquerido = _inquerido;
        novoInquerito.encerrado = false;

        return inqueritosArray.push(novoInquerito)-1;

    }

    function listarInqueritos () public view returns (bytes32[], uint[], bool[]) {

        bytes32[] memory textos = new bytes32[](inqueritosArray.length);
        uint[] memory premios = new uint[](inqueritosArray.length);
        // address[] memory inqueridos = new address[](inqueritosArray.length);
        bool[] memory encerrados = new bool[](inqueritosArray.length);

        for (uint i = 0; i < inqueritosArray.length; i++){
            textos[i] = inqueritosArray[i].texto;
            premios[i] = inqueritosArray[i].premio;
            // inqueridos[i] = inqueritosArray[i].inquerido;
            encerrados[i] = inqueritosArray[i].encerrado;
        }

        return (textos, premios, encerrados);
        
    }

    function pegarInquerito(uint _indice) public view returns (bytes32,uint, bool) {
        return (inqueritosArray[_indice].texto, inqueritosArray[_indice].premio, inqueritosArray[_indice].encerrado);
    }

}