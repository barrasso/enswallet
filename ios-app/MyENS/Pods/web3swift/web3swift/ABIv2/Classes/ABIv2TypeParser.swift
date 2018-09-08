//
//  ABIv2TypeParser.swift
//  web3swift
//
//  Created by Alexander Vlasov on 03.04.2018.
//  Copyright © 2018 Bankex Foundation. All rights reserved.
//

import Foundation

public struct ABIv2TypeParser {
    
    private enum BaseParameterType: String {
        case address
        case uint
        case int
        case bool
        case function
        case bytes
        case string
        case tuple
    }
    
    private static func baseTypeMatch(from string: String, length: UInt64 = 0) -> ABIv2.Element.ParameterType? {
        switch BaseParameterType(rawValue: string) {
        case .address?:
            return .address
        case .uint?:
            return .uint(bits: length == 0 ? 256: length)
        case .int?:
            return .int(bits: length == 0 ? 256: length)
        case .bool?:
            return .bool
        case .function?:
            return .function
        case .bytes?:
            if length == 0 {
                return .dynamicBytes
            }
            return .bytes(length: length)
        case .string?:
            return .string
        case .tuple?:
            return .tuple(types: [ABIv2.Element.ParameterType]())
        default:
            return nil
        }
    }
    
    public static func parseTypeString(_ string:String) throws -> ABIv2.Element.ParameterType {
        let (type, tail) = recursiveParseType(string)
        guard let t = type, tail == nil else {throw Web3Error.inputError(desc: "Failed to parse ABI element " + string)}
        return t
    }
    
    public static func recursiveParseType(_ string: String) -> (type: ABIv2.Element.ParameterType?, tail: String?) {
        let matcher = try! NSRegularExpression(pattern: ABIv2.TypeParsingExpressions.typeEatingRegex, options: NSRegularExpression.Options.dotMatchesLineSeparators)
        let match = matcher.matches(in: string, options: NSRegularExpression.MatchingOptions.anchored, range: string.fullNSRange)
        guard match.count == 1 else {
            return (nil, nil)
        }
        var tail: String = ""
        var type: ABIv2.Element.ParameterType?
        guard match[0].numberOfRanges >= 1 else {return (nil, nil)}
        guard let baseTypeRange = Range(match[0].range(at: 1), in: string) else {return (nil, nil)}
        let baseTypeString = String(string[baseTypeRange])
        if match[0].numberOfRanges >= 2, let exactTypeRange = Range(match[0].range(at: 2), in: string) {
            let typeString = String(string[exactTypeRange])
            if match[0].numberOfRanges >= 3, let lengthRange = Range(match[0].range(at: 3), in: string) {
                let lengthString = String(string[lengthRange])
                guard let typeLength = UInt64(lengthString) else {return (nil, nil)}
                guard let baseType = baseTypeMatch(from: typeString, length: typeLength) else {return (nil, nil)}
                type = baseType
            } else {
                guard let baseType = baseTypeMatch(from: typeString, length: 0) else {return (nil, nil)}
                type = baseType
            }
        } else {
            guard let baseType = baseTypeMatch(from: baseTypeString, length: 0) else {return (nil, nil)}
            type = baseType
        }
        tail = string.replacingCharacters(in: string.range(of: baseTypeString)!, with: "")
        if (tail == "") {
            return (type, nil)
        }
        return recursiveParseArray(baseType: type!, string: tail)
    }
    
    public static func recursiveParseArray(baseType: ABIv2.Element.ParameterType, string: String) -> (type: ABIv2.Element.ParameterType?, tail: String?) {
        let matcher = try! NSRegularExpression(pattern: ABIv2.TypeParsingExpressions.arrayEatingRegex, options: NSRegularExpression.Options.dotMatchesLineSeparators)
        let match = matcher.matches(in: string, options: NSRegularExpression.MatchingOptions.anchored, range: string.fullNSRange)
        guard match.count == 1 else {return (nil, nil)}
        var tail: String = ""
        var type: ABIv2.Element.ParameterType?
        guard match[0].numberOfRanges >= 1 else {return (nil, nil)}
        guard let baseArrayRange = Range(match[0].range(at: 1), in: string) else {return (nil, nil)}
        let baseArrayString = String(string[baseArrayRange])
        if match[0].numberOfRanges >= 2, let exactArrayRange = Range(match[0].range(at: 2), in: string) {
            let lengthString = String(string[exactArrayRange])
            guard let arrayLength = UInt64(lengthString) else {return (nil, nil)}
            let baseType = ABIv2.Element.ParameterType.array(type: baseType, length: arrayLength)
            type = baseType
        } else {
            let baseType = ABIv2.Element.ParameterType.array(type: baseType, length: 0)
            type = baseType
        }
        tail = string.replacingCharacters(in: string.range(of: baseArrayString)!, with: "")
        if (tail == "") {
            return (type, nil)
        }
        return recursiveParseArray(baseType: type!, string: tail)
    }
}
