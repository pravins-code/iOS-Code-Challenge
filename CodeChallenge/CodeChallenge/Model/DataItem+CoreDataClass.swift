//
//  DataItem.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 27/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import Foundation
import CoreData

@objc(DataItem)
class DataItem: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case id, type, date, data
    }
    
    // MARK: - Decodable
    required public convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "DataItem", in: managedObjectContext) else {
                fatalError("Failed to decode Item")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.data = try container.decodeIfPresent(String.self, forKey: .data)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(date, forKey: .date)
        try container.encode(data, forKey: .data)
    }
}

extension DataItem {
    var dateConverted: Date {
        if let date = self.date {
            return dateFormatter.date(from: date) ?? Date() // can't be converted to any date, assuming that refers to current date.
        } else {
            return Date()
        }
    }
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }
}

// MARK: - Extends the CodingUserInfoKey
public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

