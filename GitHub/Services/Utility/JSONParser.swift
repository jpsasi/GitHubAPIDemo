//
//  JSONParser.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

typealias JSON = [String: AnyObject]

protocol JSONParcelable {

    static func fromJSON(json: JSON) -> Self?
}

func flatten<A>(x: A??) -> A? {
    if let y = x {
        return y
    }
    return nil
}

infix operator >>>= {}
func >>>= <A, B>(optional: A?, f: A->B?) -> B? {
    return flatten(optional.map(f))
}

func number(input: JSON, key: String) -> NSNumber? {
    return input[key] >>>= { $0 as? NSNumber }
}

func int(input: JSON, key: String) -> Int? {
    return input[key] >>>= { $0 as? Int }
}

func float(input: JSON, key: String) -> Float? {
    return input[key] >>>= { $0 as? Float }
}

func double(input: JSON, key: String) -> Double? {
    return input[key] >>>= { $0 as? Double }
}

func string(input: JSON, key: String) -> String? {
    return input[key] >>>= { $0 as? String }
}

func bool(input: JSON, key: String) -> Bool? {
    return input[key] >>>= { $0 as? Bool }
}

func jsonValue(input: JSON, key: String) -> JSON? {
    return input[key] >>>= { $0 as? JSON }
}

func jsonArray(input: JSON, key: String) -> [JSON]? {
    return input[key] >>>= { $0 as? [JSON] }
}

func decodeJSON(data: NSData) throws -> JSON? {
    return try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? JSON
}

func decodeJSONArrayDictionary(data: NSData) throws -> [JSON]? {
    return try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [JSON]
}
