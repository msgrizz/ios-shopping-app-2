//
//  ProductEntries+CoreDataProperties.swift
//  PCShoppingApp
//
//  Created by user139368 on 4/25/18.
//  Copyright © 2018 user139368. All rights reserved.
//

import Foundation
import CoreData


extension ProductEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }
    
    @NSManaged public var imageName: String?
    @NSManaged public var price: Double
    @NSManaged public var quantity: Int32
    @NSManaged public var title: String?
    @NSManaged public var isPurchased: HistoryEntity?
    
}
