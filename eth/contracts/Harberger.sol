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
    uint16[3] defaultRgb = [256, 256, 256];

    struct ID {
        uint16[3] rgb;
        uint256 value;
        uint256 lastUpdate;
    }

    mapping(uint => ID) pixels;

    event Paint(uint ID, uint16[3] RGB, uint256 Value);

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function paintPixel(uint256 _id, uint16[3] _rgb, uint256 _bid) payable public {
        // require(_bid <= msg.value);
        commons.transfer(msg.value);
        singlePixel(_id, _rgb, _bid);
    }

    function singlePixel(uint256 _id, uint16[3] _rgb, uint256 _bid) internal {
        if (pixels[_id].lastUpdate == 0) {
            pixels[_id] = ID(defaultRgb, minBid, timeLimit);
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

        emit Paint(_id, _rgb, _bid);
    }

    function paintPixels(uint256[] _ids, uint16[3][] _rgb, uint256[] _bids) payable public {
        uint256 paintCredit = msg.value;
        commons.transfer(msg.value);

        for (uint32 i = 0; i < _ids.length; i++) {
            paintCredit -= _bids[i];
            if (paintCredit >= 0) {
                singlePixel(_ids[i], _rgb[i], _bids[i]);
            }
        }
    }

    function getPixelColor(uint _id) public view returns (uint16[3]) {
        return pixels[_id].rgb;
    }

    function getPixelValue(uint _id) public view returns (uint256) {
        return pixels[_id].value;
    }

    function changeTimeLimit(uint256 _timeLimit) public onlyOwner {
        timeLimit = _timeLimit;
    }

    function changeMinBid(uint256 _minBid) public onlyOwner {
        minBid = _minBid;
    }

    function changeCommons(address _commons) public onlyOwner {
        commons = _commons;
    }

    function changeOwner(address _owner) public onlyOwner {
        owner = _owner;
    }

    function changeMaxPixels(uint256 _maxPixels) public onlyOwner {
        maxPixels = _maxPixels;
    }
}