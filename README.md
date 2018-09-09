# MyENS Wallet
A native mobile wallet that lets you register and manage ENS domain names.

## Team Member(s)
- [@barrasso](https://github.com/barrasso)

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

## Inspiration

I got the idea to build this after I attempted to get my girlfriend to register an ENS domain name. Talk about a nightmare. 🙄

I realized that the current process is not very user friendly.  Not only does one have to be familiar with general web 3 concepts, but the exisiting applications do not make it easy to register and manage names all in one cohesive location.

The main purpose of this application is to abstract all the technical jargon and make it easier for end users to interact with the ENS, similar to a typical DNS provider like GoDaddy or NameCheap.

## What it does

The app uses a web3 library written in Swift to perform calls to the Ethereum blockchain. It allows the user to send and recieve ether and ERC20 tokens, as well as registering and managing ENS domains all from within the app.

## How I built it

First, I started drawing out sketches with some good old pen and paper. Then after some feedback and iterations, [I made wireframes using Adobe XD](https://xd.adobe.com/view/b1a87360-49f5-4863-619d-bd08bbb9afb5-c799/screen/85db78f7-25f9-43b2-bd3a-1939d3c48da0/iPhone-6-7-8-13). 

Once I settled on the views and essential features, I began to code it up using Xcode.

## Built with

- [Web3Swift](https://github.com/matterinc/web3swift)
- [Infura](https://infura.io/dashboard)

## Challenges

Originally, I began to research exisiting web3 libraries written in Swift. After settling on [Web3Swift](https://github.com/matterinc/web3swift), I started working on the Etherem wallet functionality.

After a full day of getting that to work, I noticed on the most recent [WeekInEthereum](https://weekinethereum.com) post that there is [a new web3 library with ENS support](https://github.com/argentlabs/web3.swift). 

*Dang-- too late!*

Rather than reverting all of my work for the previous day, I stuck with the currently web3 library, although it is much more difficult to call contract functions.

After the hackathon, I will switch over to the newest web3 library to finish the ENS functions.

## Future work and features

Some features that I'd like to include in the future:

- Contact list: send ether directly to friends using their ENS names
- Reminders for auctions: push notifications for bids and reveals
- Mask the root wallet address with an ENS domain that you own
- Multi-factor authentication
- Trade and sell ENS names directly in the app
- Back up and recover your private key using [Keysplit](https://devpost.com/software/keysplit) ;)
- Ability to export bids 
