
//  Web3+Contract.swift
//  web3swift
//
//  Created by Alexander Vlasov on 19.12.2017.
//  Copyright © 2017 Bankex Foundation. All rights reserved.
//

import Foundation
import BigInt

extension web3 {
    
    /// The contract instance. Initialized in runtime from ABI string (that is a JSON array). In addition an existing contract address can be supplied to provide the default "to" address in all the following requests. ABI version is 2 by default and should not be changed.
    public func contract(_ abiString: String, at: EthereumAddress? = nil, abiVersion: Int = 2) -> web3contract? {
        return web3contract(web3: self, abiString: abiString, at: at, options: self.options, abiVersion: abiVersion)
    }
    
    /// Web3 instance bound contract instance.
    public class web3contract {
        var contract: ContractProtocol
        var web3 : web3
        public var options: Web3Options? = nil
        
        
        /// Initialize the bound contract instance by supplying the Web3 provider bound object, ABI, Ethereum address and some default
        /// options for further function calls. By default the contract inherits options from the web3 object. Additionally supplied "options"
        /// do override inherited ones.
        public init?(web3 web3Instance:web3, abiString: String, at: EthereumAddress? = nil, options: Web3Options? = nil, abiVersion: Int = 2) {
            self.web3 = web3Instance
            self.options = web3.options
            switch abiVersion {
            case 1:
                print("ABIv1 bound contract is now deprecated")
                return nil
            case 2:
                guard let c = ContractV2(abiString, at: at) else {return nil}
                contract = c
            default:
                return nil
            }
            var mergedOptions = Web3Options.merge(self.options, with: options)
            if at != nil {
                contract.address = at
                mergedOptions?.to = at
            } else if let addr = mergedOptions?.to {
                contract.address = addr
            }
            self.options = mergedOptions
        }
        
        /// Deploys a constact instance using the previously provided (at initialization) ABI, some bytecode, constructor parameters and options.
        /// If extraData is supplied it is appended to encoded bytecode and constructor parameters.
        ///
        /// Returns a "Transaction intermediate" object.
        public func deploy(bytecode: Data, parameters: [AnyObject] = [AnyObject](), extraData: Data = Data(), options: Web3Options?) -> TransactionIntermediate? {
            
            let mergedOptions = Web3Options.merge(self.options, with: options)
            guard var tx = self.contract.deploy(bytecode: bytecode, parameters: parameters, extraData: extraData, options: mergedOptions) else {return nil}
            tx.chainID = self.web3.provider.network?.chainID
            let intermediate = TransactionIntermediate(transaction: tx, web3: self.web3, contract: self.contract, method: "fallback", options: mergedOptions)
            return intermediate
        }
        
        /// Creates and object responsible for calling a particular function of the contract. If method name is not found in ABI - returns nil.
        /// If extraData is supplied it is appended to encoded function parameters. Can be usefull if one wants to call
        /// the function not listed in ABI. "Parameters" should be an array corresponding to the list of parameters of the function.
        /// Elements of "parameters" can be other arrays or instances of String, Data, BigInt, BigUInt, Int or EthereumAddress.
        ///
        /// Returns a "Transaction intermediate" object.
        public func method(_ method:String = "fallback", parameters: [AnyObject] = [AnyObject](), extraData: Data = Data(), options: Web3Options?) -> TransactionIntermediate? {
            let mergedOptions = Web3Options.merge(self.options, with: options)
            guard var tx = self.contract.method(method, parameters: parameters, extraData: extraData, options: mergedOptions) else {return nil}
            tx.chainID = self.web3.provider.network?.chainID
            let intermediate = TransactionIntermediate(transaction: tx, web3: self.web3, contract: self.contract, method: method, options: mergedOptions)
            return intermediate
        }
        
        /// Parses an EventLog object by using a description from the contract's ABI.
        public func parseEvent(_ eventLog: EventLog) -> (eventName:String?, eventData:[String:Any]?) {
            return self.contract.parseEvent(eventLog)
        }
        
        /// Creates an "EventParserProtocol" compliant object to use it for parsing particular block or transaction for events.
        public func createEventParser(_ eventName:String, filter:EventFilter?) -> EventParserProtocol? {
            let parser = EventParser(web3: self.web3, eventName: eventName, contract: self.contract, filter: filter)
            return parser
        }
    }
}
