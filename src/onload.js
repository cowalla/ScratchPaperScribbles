var contractAbi,
    contractAddress,
    url = "http://localhost:63342/ScratchPaperScribbles/eth/build/contracts/Harberger.json";
    imageSize = 1000;

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

function erase_canvas(){
    var imageData = canvas.ctx.getImageData(0,0,canvas.width, canvas.height);

    for(var i=0; i<imageData.data.length; i++){
        if(i%4 === 0){
            imageData.data[i] = 255
        } else {
            imageData.data[i] = 0
        }
    }
}

(async function(){
    window.account = await web3.eth.accounts[0];
    await $.getJSON(url, function(contract){
        window.contract = contract;
        contractAbi = window.contract.abi;
        contractAddress = window.contract.networks["3"].address;
        contractTxHash = window.contract.networks["3"].transactionHash;
        window.contract = web3.eth.contract(contractAbi).at(contractAddress);

        erase_canvas()

        web3.eth.getTransaction(contractTxHash, function(error, transaction) {
            if (!error) {
                window.contract.Paint({}, {fromBlock: transaction.blockNumber}, function(err, response){
                    var imageData = canvas.ctx.getImageData(0,0,canvas.width, canvas.height)
                    var id = parseInt(response.args.ID.toString())
                    var [r,g,b] = response.args.RGB.toString().split(',')
                    var value = parseInt(response.args.Value.toString())

                    var idx = 4 * id
                    imageData.data[idx] = parseInt(r)
                    imageData.data[idx+1] = parseInt(g)
                    imageData.data[idx+2] = parseInt(b)
                    imageData.data[idx+3] = 255

                    canvas.ctx.putImageData(imageData, 0, 0)
                });
            }
        });
    });
})(this);


//    function(imData){
//        for(var i=0; i<maxIndex; i++){
//            window.contract.getPixelColor(i, function(err, rgba){
//                console.log(rgba.toString());
//                [r,g,b] = rgba.toString().split(',')
//                var idx = 4 * i
//                imData.data[idx] = r
//                imData.data[idx+1] = g
//                imData.data[idx+2] = b
//                imData.data[idx+3] = 255
//            });
//        }
//    }
