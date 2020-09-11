//
//  ACChannelIdentifier.swift
//  
//
//  Created by Julian Tigler on 9/11/20.
//

import Foundation

public struct ACChannelIdentifier {
    let dictionary: [String: Any]
    let string: String
    
    public init?(channelName: String, identifier: [String: Any]) {
        var dictionary = identifier
        dictionary["channel"] = channelName
        self.dictionary = dictionary
        
        guard let string = try? self.dictionary.toJSON(options: .sortedKeys) else { return nil }
        self.string = string
    }
    
    public init?(string: String) {
        self.string = string
        
        guard let data = string.data(using: .utf8), let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
        self.dictionary = dictionary
    }
}

extension ACChannelIdentifier: Equatable {
    public static func == (lhs: ACChannelIdentifier, rhs: ACChannelIdentifier) -> Bool {
        lhs.string == rhs.string
    }
}