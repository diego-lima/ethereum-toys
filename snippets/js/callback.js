var callback = function(e,contract){
	console.log(e,contract);
	if (typeof contract.address !== 'undefined') {
		console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }

}
