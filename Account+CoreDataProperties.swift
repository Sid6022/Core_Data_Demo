//
//  Account+CoreDataProperties.swift
//  Core_Demo
//
//  Created by Sagar on 06/05/19.
//  Copyright © 2019 Sagar. All rights reserved.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var cid: Int32
    @NSManaged public var acttype: String?
    @NSManaged public var users: User?

}
