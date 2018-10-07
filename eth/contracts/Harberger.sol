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

    struct ID {
        string color;
        uint256 value;
        uint256 lastUpdate;
    }

    mapping(uint => ID) pixels;

    event Paint(uint ID, string Color, uint256 Value);

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function paintPixel(uint256 _id, string _color, uint256 _bid) payable public {
        // require(_bid <= msg.value);
        commons.transfer(msg.value);
        singlePixel(_id, _color, _bid);
    }

    function singlePixel(uint256 _id, string _color, uint256 _bid) internal {
        if (pixels[_id].lastUpdate == 0) {
           pixels[_id] = ID("#FFFFFF", minBid, timeLimit);
        }

        bool expired = (block.timestamp - pixels[_id].lastUpdate) >= timeLimit;
        uint256 cost;

        if (expired == false) {
            cost = pixels[_id].value;
        }
        else {
            cost = minBid;
        }

        require(cost < _bid);

        pixels[_id].value = _bid;
        pixels[_id].color = _color;
        pixels[_id].lastUpdate = block.timestamp;

        emit Paint(_id, _color, _bid);
    }

    function paintPixels(uint256[] _ids, string[] _colors, uint256[] _bids) payable public {
        require(_ids.length == _colors.length == _bids.length);
        // commons.transfer(msg.value);
        uint256 paintCredit = msg.value;

        // for (uint256 i = 0; i < _ids.length; i++) {
        //    uint256 _id = _ids[i];
        //   string memory _color = _colors[i];
        //    uint256 _bid = _bids[i];
        //    paintCredit -= _bid;
        //    if (paintCredit >= 0) {
        //        singlePixel(_id, _color, _bid);
        //    }
        //    else {
        //        break;
        //    }
        // }
    }

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