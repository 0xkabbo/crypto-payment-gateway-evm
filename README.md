# Crypto Payment Gateway (EVM)

This repository provides a clean, single-file solution for processing cryptocurrency payments on any EVM-compatible chain (Ethereum, BSC, Polygon). 

## How It Works
* **Payment Events:** Every payment triggers a `PaymentReceived` event containing a `paymentId`. Your backend can listen to these events to confirm orders.
* **Token Support:** Accept native gas tokens (like ETH/MATIC) or any standard ERC-20 token (like USDC/USDT).
* **Security:** Built with OpenZeppelin's `Ownable` to ensure only the merchant can withdraw the collected funds.

## Integration Steps
1. Deploy `PaymentGateway.sol`.
2. Integration: Call `payWithToken` or `payWithNative` from your frontend.
3. Fulfillment: Monitor the blockchain for the `PaymentReceived` event with the matching `orderId`.
