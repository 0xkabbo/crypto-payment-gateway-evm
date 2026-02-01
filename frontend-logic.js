// Example code to interact with the gateway using Ethers.js
async function processPayment(contractAddress, amount, orderId) {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const gateway = new ethers.Contract(contractAddress, ["function payWithNative(string) payable"], signer);

    const tx = await gateway.payWithNative(orderId, {
        value: ethers.parseEther(amount)
    });

    console.log("Transaction sent:", tx.hash);
    await tx.wait();
    console.log("Payment confirmed for order:", orderId);
}
