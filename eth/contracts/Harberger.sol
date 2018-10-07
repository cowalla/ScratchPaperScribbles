pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2;

contract Harberger {

    constructor() public {
        owner = msg.sender;
    }
    address myaddress;
    address owner;
    address commons = owner;
    uint256 timeLimit = 4 weeks;
    uint256 minBid = 100000000000000;
    uint256 maxPixels = 1000000;
    uint16[3] defaultRGB = [256, 256, 256];

    struct ID {
        uint8[3] rgb;
        uint256 value;
        uint256 lastUpdate;
    }

    mapping(uint => ID) pixels;

    event Paint(uint Id, string Color, uint256 Value);

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function paintPixel(uint256 _id, uint8[3] _rgb, uint256 _bid) payable public {
        // require(_bid <= msg.value);
        commons.transfer(msg.value);
        singlePixel(_id, _rgb, _bid);
    }

    function singlePixel(uint256 _id, uint8[3] _rgb, uint256 _bid) internal {
        if (pixels[_id].lastUpdate == 0) {
           pixels[_id] = ID(defaultRGB, minBid, timeLimit);
        }

        bool expired = (block.timestamp - pixels[_id].lastUpdate) >= timeLimit;
        uint256 cost;

        if (expired == false) {
            cost = pixels[_id].value;
        }
        else {
            cost = minBid;
        }

        // require(cost < _bid);

        pixels[_id].value = _bid;
        pixels[_id].rgb = _rgb;
        pixels[_id].lastUpdate = block.timestamp;

        // emit Paint(_id, _rgb, _bid);
    }

    function paintPixels(uint256[] _ids, uint8[3][] _rgbs, uint256[] _bids) payable public {
        // require(_ids.length == _rgbs.length == _bids.length);
        //uint256 paintCredit = msg.value;
        //commons.transfer(msg.value);

        //for(uint32 i=0; i<_ids.length; i++){
          //  paintCredit -= _bids[i];

            // if (paintCredit >= 0) {
                // singlePixel(_ids[i], _rgbs[i], _bids[i]);
            // }

        //}
    }

//    function viewPixelColor(uint256 _id) public constant returns (string rgb) {
  //      return pixels[_id].rgb;
   // }

//     function changeTimeLimit(uint256 _timeLimit) public onlyOwner {
//         timeLimit = _timeLimit;
//     }
// 
//     function changeMinBid(uint256 _minBid) public onlyOwner {
//         minBid = _minBid;
//     }
// 
//     function changeCommons(address _commons) public onlyOwner {
//         commons = _commons;
//     }
// 
//     function changeOwner(address _owner) public onlyOwner {
//         owner = _owner;
//     }
// 
//     function changeMaxPixels(uint256 _maxPixels) public onlyOwner {
//         maxPixels = _maxPixels;
//     }
}