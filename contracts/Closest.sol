pragma solidity ^0.4.16;


contract Closest {
    address public owner;

    // // Pessoa que esta no comando agora, que selecionou a aposta
    // address public person;

    // // Valor definido pela pessoa em comando
    // uint private bet;

    // // Guarda a aposta de alguem
    // struct PlacedBet{
    //     uint value;
    //     bool isSet;
    // }

    // // Precisamos manter registro dos endereços que ja apostaram
    // // se quisermos ser capazes de iterar, pois o mapping
    // // nao possibilita isso
    address[] public betterList;

    // mapping(address => PlacedBet) public betStructs;

    constructor () public {
        owner = msg.sender;
    }

    function kill() public {
        if (msg.sender == owner)
            selfdestruct(owner);
    }

    // function set_bet(uint _bet) public {
    //     require(msg.sender == owner || msg.sender == person);

    //     bet = _bet;
    // }

    // function place_bet(uint _bet) public returns (uint) {
    //     require(msg.sender != owner && msg.sender != person);
    //     require(!betStructs[msg.sender].isSet);

    //     betStructs[msg.sender].value = _bet;
    //     betStructs[msg.sender].isSet = true;
        
    //     return betterList.push(msg.sender) - 1;
    // }

    // function winners() public view returns (address ret){
    //     for (uint i = 0; i < betterList.length; i++) {
    //         if (betStructs[betterList[i]].isSet && betStructs[betterList[i]].value == bet) {
    //             ret = betterList[i];
    //             break;
    //         }
    //     }
    // }

    function first() public returns (address){
        return betterList[0];
    }

    function add(address addend) public returns (uint n){
        return betterList.push(addend) - 1;
    }

}