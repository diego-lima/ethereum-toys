pragma solidity ^0.4.23;
/**
Um contrato simples para demonstração de um bug no compilador solc.

contém simplesmente um array de structs, onde cada struct tem um texto e um endereço.

contém uma função para acrescentar ao array de structs

contém uma função para listar os elementos do array de structs
 */

contract Kitchen {
    struct Bowl {
        bytes32 food;
        address owner;
    }

    Bowl[] bowlArray;
    
    function put(bytes32 _text) public returns (uint){
        return bowlArray.push(
            Bowl({food:_text, owner:msg.sender})
        ) - 1;
    }
        
    function listBowls() public view returns (bytes32[], address[]) {
        bytes32[] memory foods = new bytes32[](bowlArray.length);
        address[] memory owners = new address[](bowlArray.length);

        for (uint i = 0; i < bowlArray.length; i++){
            foods[i] = bowlArray[i].food;
            owners[i] = bowlArray[i].owner;
        }

        return (foods, owners);
    }
}   
