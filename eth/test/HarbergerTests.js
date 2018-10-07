const Harberger = artifacts.require("Harberger");

contract("Harberger", accounts => {
    const [firstAccount] = accounts;

    it("paints pixels", async () => {
        const harberger = await Harberger.new();
        // assert.equal(await harberger.owner.call(), firstAccount);
        // harberger.paintPixels(
        //     [0, 1, 2, 3, 4, 5],
        //     ["0xFFFFFF", "0xFFFFFF", "0xFFFFFF", "0xFFFFFF", "0xFFFFFF", "0xFFFFFF"],
        //     [1000, 1000, 1000, 1000, 1000, 1000]);
        harberger.paintPixels(
            [0],
            ["0xFFFFFF"],
            [1000]);
        // harberger.paintPixel(0, "OxFFFFFF", 1000);
    });
});