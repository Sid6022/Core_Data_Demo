//
//  Presistance.swift
//  Core_Demo
//
//  Created by Sagar on 12/04/19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Presistance {
    // MARK: - Core Data stack
    
    private init() {}
    
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Core_Demo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    
    // MARK: - Core Data Saving support
    
  static func saveContext (completionHandler: @escaping (Bool)->()) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completionHandler(true)
            } catch {
                 completionHandler(false)
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK:- Fetch Data
   static func fetchData() -> [User] {
        var arrUserProfile = [User]()
        let aFetchRequest : NSFetchRequest<User> = User.fetchRequest()
        do{
        let arrUserData = try Presistance.context.fetch(aFetchRequest)
            arrUserProfile =  arrUserData
        }catch{
            //handel Faild block
        }
    return arrUserProfile
    }
    
    
    //MARK:- Update data
    
    static func updateData (aTupleData: ([String],NSData),completionHandler: @escaping (Bool)->()){
       
        let arrData = aTupleData.0
        let aFetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        aFetchRequest.predicate = NSPredicate(format: "email = %@", arrData[1])
        do {
            let aTest = try context.fetch(aFetchRequest)
            guard aTest.count != 0 else { return }
            let aData = aTest[0] as! NSManagedObject
            aData.setValue(arrData[0], forKey: "name")
            aData.setValue(arrData[1], forKey: "email")
            aData.setValue(arrData[2], forKey: "gender")
            aData.setValue(aTupleData.1, forKey: "image")
            do {
                try Presistance.context.save()
                completionHandler(true)
            } catch {
                print("error : \(error)")
                  completionHandler(false)
            }
        }catch{
            completionHandler(false)
            print("error : \(error)")
        }
    }
    
    
    
    
}
