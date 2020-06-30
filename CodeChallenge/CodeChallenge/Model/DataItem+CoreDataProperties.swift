//
//  DataItem+Extension.swift
//  CodeChallenge
//
//  Created by Pravin Ghogare on 28/06/20. Renaming the creater names as my machines default name is different
//  Copyright © 2020 own. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Data Item class extension

extension DataItem {
    
    @nonobjc public class func fetchDataRequest() -> NSFetchRequest<DataItem> {
        return NSFetchRequest<DataItem>(entityName: "DataItem")
    }
    // MARK: - Entity attributes
    @NSManaged public var id: String?
    @NSManaged public var type: String?
    @NSManaged public var date: String?
    @NSManaged public var data: String?
}
