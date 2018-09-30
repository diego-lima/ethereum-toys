# encoding: utf-8

import sys

"""
Esse script recebe dois argumentos:
o primeiro é o arquivo .abi
o segundo é o arquivo .bin
esses dois arquivos devem ter sido gerados na compilação do .sol
Pega o conteúdo desses dois arquivos e joga no template abaixo
e joga num arquivo .js que pode ser facilmente importado no geth
via loadScript
"""

filenames = sys.argv[1:]

template = """
var abi = %s
var bin = "0x%s"

var config = {from:web3.eth.accounts[0],
            data: bin,
            gas: '4700000'
}

var callback = function(e,contract){
	console.log(e,contract);
	if (typeof contract.address !== 'undefined') {
		console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }

}

var contract_factory = web3.eth.contract(abi)
var contract = contract_factory.new(config, callback)
"""

if len(filenames) == 2:
    abi = open(filenames[0], "r").read()
    bin = open(filenames[1], "r").read()

    name = filenames[0].split('.')[0]

    js = open("%s.js" % name, "w")
    js.write(template % (abi, bin))
    js.close()