var abi = <<abi|O Application Binary Interface(ABI) do contrato>>
var bin = "0x<<bin|O bytecode do contrato>>"

var config = {from:<<from|O from que é passado para o config do contract factory|web3.eth.accounts[0]>>,
            data: bin,
            gas: <<gas|O gas que é passado para o config do contract factory|'4700000'>>
}

var callback = function(e,contract){
	console.log(e,contract);
	if (typeof contract.address !== 'undefined') {
		console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }

}

var contract_factory = web3.eth.contract(abi)
var contract = contract_factory.new(config, callback)