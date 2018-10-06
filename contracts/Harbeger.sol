contract Harberger{

	constructor() public { 
		owner = msg.sender; 
	}
    address owner;

	address commons;
	uint256 timeLimit; // number of blocks auction will stay last before resetting to 0;
	uint256 minBid;
	uint256 maxPixels;

	struct ID {
		hex color;
		uint256 value;
		uint256 lastUpdate;
	};

	mapping (uint[2] => ID) pixels;

	event Paint(uint[2] ID, hex Color, uint256 Value);

	modifier onlyOwner {
        require(msg.sender == owner);
        _;
    };

	function paintPixel(uint256 _id, hex _color, uint256 _bid){
        bool expired = (block.number - pixels[_id].lastUpdate) >= timeLimit;
        uint256 cost;

        if(expired == false){
        	cost = pixels[_id].value;
        }
        else {
        	cost = minBid
        }

        require (cost < _bid)

       	pixels[_id].value = _bid;
        pixels[_id].color = _color;
        pixels[_id].lastUpdate = block.number;

        emit Paint(_id, _color, _bid);
	};

	function paintPixels(uint256[] _ids, hex[] _colors, uint256[] _bids) {
		require(_ids.length == _colors.length == _bids.length);
		commons.send(msg.value);
		uint256 paintCredit = msg.value;

		for (uint256 i = 0; i < _ids.length; i++) {
        	_id = _ids[i];
        	_color = _colors[i];
            _bid = _bids[i];
            paintCredit -= _bid;
            if (paintCredit >= 0){
            	paintPixel(_id, _color, _bid);
            }
            else{
            	break;
            }
        }
	};

	function changeTimeLimit (uint256 _timeLimit) is onlyOwner {
		timeLimit = _timeLimit;
	};

	function changeMinBid (uint256 _minBid) is onlyOwner {
		minBid = _minBid;
	};

	function changeCommons (address _commons) is onlyOwner {
		commons = _commons;
	};

	function changeOwner (address _owner) is onlyOwner {
		owner = _owner;
	};

	function changeMaxPixels (uint256 _maxPixels) is onlyOwner {
		maxPixels = _maxPixels;
	};
}