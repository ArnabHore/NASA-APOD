//
//  CoreDataManager.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 13/11/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    /// Save image data
    /// - Parameters:
    ///     - imgData: Current image details to be saved
    func saveData(imgData: [String: Any]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ImageList", in: managedContext)!
        let imageList = NSManagedObject(entity: entity, insertInto: managedContext)
        for (key, value) in imgData {
            imageList.setValue(value, forKey: key)
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    /// Fetch image data
    /// - Parameters:
    ///     - properties: Properties to fetch from local db
    func fetchData(properties: [String]?) -> [Any] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageList")
        if let properties = properties {
            fetchRequest.propertiesToFetch = properties
        }
        do {
            let result = try managedContext.fetch(fetchRequest)
            return self.populateData(result: result, isList: (properties != nil))
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    /// Delete image data
    /// - Parameters:
    ///     - date: Date for which the data will be removed
    func deleteData(date: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageList")
        fetchRequest.predicate = NSPredicate(format: "date = %@", date)
        do {
            let list = try managedContext.fetch(fetchRequest)
            if let objectToDelete = list.first as? NSManagedObject {
                managedContext.delete(objectToDelete)
                do {
                    try managedContext.save()
                }
                catch let error as NSError {
                    print("Could not delete. \(error), \(error.userInfo)")
                }
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    /// Populate fetched data as Array or Dictionary
    private func populateData(result: [NSFetchRequestResult], isList: Bool) -> [Any] {
        if isList {
            var list: [String] = []
            for data in result as! [NSManagedObject] {
                list.append(data.value(forKey: "date") as! String)
            }
            return list
        } else {
            var list: [[String: Any]] = []
            for data in result as! [NSManagedObject] {
                var dict: [String: Any] = [:]
                dict["title"] = data.value(forKey: "title") as! String
                dict["date"] = data.value(forKey: "date") as! String
                list.append(dict)
            }
            return list
        }
    }
}
