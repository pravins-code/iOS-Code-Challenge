//
//  DataItem.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 27/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import Foundation

struct DataItem: Codable {
    
    let id: String?
    let type: String?
    let date: String?
    let data: String?
    
    enum CodingKeys: String, CodingKey {
        case id, type, date, data
    }
   
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }
}
