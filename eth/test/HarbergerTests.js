const Harberger = artifacts.require("Harberger");

contract("Harberger", accounts => {
    const [firstAccount] = accounts;

    const minBid = 100000000000000;
    const bid = 10 * minBid;
    const color1 = [256,256,256];
    const color2 = [0,0,0];
    const id = 0;

    var arraySize = 10;
    var ids = [...Array(arraySize).keys()].slice(1, arraySize);
    ids.push(100000);
    var colors = new Array(arraySize).fill(color1);
    var bids = new Array(arraySize).fill(bid);
    var colors2 = new Array(arraySize).fill(color2);
    var bids2 = new Array(arraySize).fill(2 * bid);

    it("paintPixel", async () => {
        const harberger = await Harberger.new();

        assert.equal((await harberger.getPixelColor(id)).toString(), "0,0,0", "The non-instantiated ID.color should be nothing, yet");

        await harberger.paintPixel(id, color1, bid);
        assert.equal((await harberger.getPixelColor(id)).toString(), color1.toString(), "The non-instantiated ID.color should be " + color1.toString());
        assert.equal(await harberger.getPixelValue(id), bid, "The non-instantiated ID.value should have been increased");

        await harberger.paintPixel(id, color2, 2 * bid);
        assert((await harberger.getPixelColor(id)).toString(), color2.toString(),  "The non-instantiated ID.color should be " + color2.toString());
        assert(await harberger.getPixelValue(id) > bid, "The non-instantiated ID.value should have been increased");
        assert.equal(await harberger.getPixelValue(id), 2 * bid, "The non-instantiated ID.value should have been set to " + (2 * bid));
    });

    it("paintPixels", async () => {
        const harberger = await Harberger.new();

        for (var index = 0; index < ids.length; index++) {
            assert((await harberger.getPixelColor(ids[index])).toString(), "0,0,0", "The non-instantiated ID.color should be nothing, yet");
        }

        await harberger.paintPixels(ids, colors, bids);
        for (var index = 0; index < ids.length; index++) {
            const id = ids[index];
            const color = colors[index];

            assert.equal((await harberger.getPixelColor(id)).toString(), color.toString(), "The non-instantiated ID.color should be " + color.toString());
            assert.equal(await harberger.getPixelValue(id), bid, "The non-instantiated ID.value should have been increased");
        }

        await harberger.paintPixels(ids, colors2, bids2);
        for (var index = 0; index < ids.length; index++) {
            const id = ids[index];
            const color = colors2[index];
            const bid = bids2[index];

            assert.equal((await harberger.getPixelColor(id)).toString(), color.toString(), "The non-instantiated ID.color should be " + color.toString());
            assert.equal(await harberger.getPixelValue(id), bid, "The non-instantiated ID.value should have been increased");
        }

    });

});