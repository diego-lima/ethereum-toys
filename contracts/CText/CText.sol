pragma solidity ^0.4.23;

contract CText {
    struct TextThatDoesNotWork {
        bytes32 text;
        uint reads;
        address addr;
    }

    TextThatDoesNotWork[] textArray;
    
    function put(bytes32 _text, uint _reads) public {
        textArray.push(TextThatDoesNotWork({
            text: _text,
            reads: _reads,
            addr: msg.sender
        }));
    }
        
    function listTexts() public view returns (bytes32[], uint[], address[]) {
        bytes32[] memory texts = new bytes32[](textArray.length);
        uint[] memory readsArray = new uint[](textArray.length);
        address[] memory addresses = new address[](textArray.length);

        for (uint i = 0; i < textArray.length; i++){
            texts[i] = textArray[i].text;
            readsArray[i] = textArray[i].reads;
            addresses[i] = textArray[i].addr;
        }

        return (texts, readsArray, addresses);
    }
}   
