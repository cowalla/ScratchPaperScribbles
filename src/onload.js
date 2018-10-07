var contractAbi,
    contractAddress,
    url = 'http://localhost:63342/ScratchPaperScribbles/eth/build/contracts/Harberger.json'

var { currentProvider: cp } = window.web3;
var isToshi = !!cp.isToshi;
var isCipher = !!cp.isCipher;
var isMetaMask = !!cp.isMetaMask;

if (typeof web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
} else {
    // Set the provider you want from Web3.providers
    web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545"));
}

(async function(){
    window.account = await web3.eth.accounts[0];
    await $.getJSON(url, function(contract){
        window.contract = contract;
        contractAbi = window.contract.abi;
        contractAddress = window.contract.networks["5777"].address;
        window.contract = web3.eth.contract(contractAbi).at(contractAddress);
        
        var event = window.contract.Paint({}, {fromBlock: 0}, function(error, result) {
            if (!error) {
                console.log(result);
            }
        });
    });
})(this);
