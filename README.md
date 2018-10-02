# MyENS Wallet
A native mobile wallet that lets you register and manage ENS domain names.

## Team Member(s)
- [@barrasso](https://github.com/barrasso)
- [@nljunggren](https://github.com/nljunggren)

## How to use

Requirements:

- Xcode Version 9.4.1 (9F2000)
- Cocoapods 1.5.3

ENS Contracts (Ropsten):
- https://ropsten.etherscan.io/address/0x112234455c3a32fd11230c42e7bccd4a84e02010#readContract
- https://ropsten.etherscan.io/address/0xC68De5B43C3d980B0C110A77a5F78d3c4c4d63B4#readContract

First, navigate to root directory of the the iOS project: `ios-app/MyENS/`.

Using the terminal, install the dependencies by running: `pod install`.

Open the `MyENS.xcworkspace` using Xcode.

## Future work and features

Some features that I'd like to include in the future:

- Contact list: send ether directly to friends using their ENS names
- Reminders for auctions: push notifications for bids and reveals
- Mask the root wallet address with an ENS domain that you own
- Multi-factor authentication
- Trade and sell ENS names directly in the app
- Back up and recover your private key using [Keysplit](https://devpost.com/software/keysplit) ;)
- Ability to export bids 
