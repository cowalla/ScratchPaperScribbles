const Harberger = artifacts.require("Harberger");

contract("Harberger", accounts => {
    const [firstAccount] = accounts;

    const minBid = 100000000000000;
    const bid = 10 * minBid;
    const color1 = "#FFFFFF";
    const color2 = "#000000";
    const id = 0;

    var arraySize = 100
    var bids = new Array(arraySize).fill(bid);
    var colors = new Array(arraySize).fill(bid);
    var ids = [...Array(arraySize).keys()].slice(1, arraySize);

    it("paintPixel", async () => {
        const harberger = await Harberger.new();

        assert(Object.keys(await harberger.getPixelColor(id)).length == 0, "The non-instantiated ID.color should be nothing, yet");

        await harberger.paintPixel(id, color1, bid);
        assert.equal(await harberger.getPixelColor(id), color1, "The non-instantiated ID.color should be " + color1);
        assert.equal(await harberger.getPixelValue(id), bid, "The non-instantiated ID.value should have been increased");

        await harberger.paintPixel(id, color2, 2 * bid);
        assert(await harberger.getPixelColor(id), color2,  "The non-instantiated ID.color should be " + color2);
        assert(await harberger.getPixelValue(id) > bid, "The non-instantiated ID.value should have been increased");
        assert.equal(await harberger.getPixelValue(id), 2 * bid, "The non-instantiated ID.value should have been set to " + (2 * bid));
    });

    // it("paintPixels", async () => {
    //     const harberger = await Harberger.new();
    //
    //     assert(Object.keys(harberger.getPixelColor(id)).length == 0, "The non-instantiated ID.color should be nothing, yet");
    //     var paintPixelsResponse = contract.paintPixels(
    //         ids,
    //         colors,
    //         bids,
    //         {
    //             from: account,
    //             value: 10000000000000000,
    //             gas: 30000000
    //         },
    //         function(d){console.log('completed')}
    //     )
    // });




});