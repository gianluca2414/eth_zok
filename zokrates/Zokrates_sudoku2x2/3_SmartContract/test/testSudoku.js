const verifier = artifacts.require("verifier");

contract("verifier", () => {
    it("...deploy...", async() => {
        const contractInstance = await verifier.new();

const gasEstimate = await contractInstance.createInstance.estimateGas();

const tx = await contractInstance.contractInstance({
    gas: gasEstimate - 1
    });
    assert(tx);
});
});