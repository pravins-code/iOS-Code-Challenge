//
//  DataItem+Extension.swift
//  CodeChallenge
//
//  Created by baps on 28/06/20.
//  Copyright © 2020 own. All rights reserved.
//

import Foundation
import CoreData

extension DataItem {
    
    @nonobjc public class func fetchDataRequest() -> NSFetchRequest<DataItem> {
        return NSFetchRequest<DataItem>(entityName: "DataItem")
    }
    @NSManaged public var id: String?
    @NSManaged public var type: String?
    @NSManaged public var date: String?
    @NSManaged public var data: String?
}
