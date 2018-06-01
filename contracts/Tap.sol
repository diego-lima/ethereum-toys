pragma solidity ^0.4.16;

    /**
    * Experimentando contrato simples
    * É como se fosse um botão e um contador
    * Toda vida que alguém aperta o botão, o contador incrementa
    * Só o dono do contrato pode resetar ou matar o contrato
    */

contract Tap {
    address public owner;

    uint public taps;

    constructor () public {
        owner = msg.sender;
        taps = 0;
    }

    function kill() public {
        if (msg.sender == owner)
            selfdestruct(owner);
    }

    function tap() public returns (uint) {
        taps = taps + 1;
        return taps;
    }

    function tap2() public returns (uint) {
        taps = taps + 2;
        return taps;
    }

    function reset() public {
        require(msg.sender == owner);
        taps = 0;
    }

}