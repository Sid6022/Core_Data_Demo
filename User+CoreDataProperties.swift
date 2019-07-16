//
//  User+CoreDataProperties.swift
//  Core_Demo
//
//  Created by Sagar on 06/05/19.
//  Copyright © 2019 Sagar. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var image: NSData?
    @NSManaged public var name: String?
    @NSManaged public var accounttype: String?
    @NSManaged public var accounts: NSSet?

}

// MARK: Generated accessors for accounts
extension User {

    @objc(addAccountsObject:)
    @NSManaged public func addToAccounts(_ value: Account)

    @objc(removeAccountsObject:)
    @NSManaged public func removeFromAccounts(_ value: Account)

    @objc(addAccounts:)
    @NSManaged public func addToAccounts(_ values: NSSet)

    @objc(removeAccounts:)
    @NSManaged public func removeFromAccounts(_ values: NSSet)

}
