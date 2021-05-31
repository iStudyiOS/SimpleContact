//
//  PersistenceManager.swift
//  SimpleContact
//
//  Created by 김두리 on 2021/05/31.
//

import Foundation
import CoreData

class PersistenceManager {
    static var shared: PersistenceManager = PersistenceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Contact")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func create(person: Person) -> Void {
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: self.context)
        
        if let entity = entity {
            let manageObject = NSManagedObject(entity: entity, insertInto: self.context)
            manageObject.setValue(person.name, forKey: "name")
            manageObject.setValue(person.memo, forKey: "memo")
            manageObject.setValue(person.phone, forKey: "phone")
            manageObject.setValue(person.favorite, forKey: "favorite")
            
            do {
                try self.context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func read() -> [Person] {
        let readRequest = NSFetchRequest<NSManagedObject>(entityName: "Contact")
        
        let personData = try! context.fetch(readRequest)
    
        var dataToPerson = [Person]()
        print(personData.count)
        
        for data in personData{
            let name = data.value(forKey: "name") as! String
            let phone = data.value(forKey: "phone") as! String
            let favorite = data.value(forKey: "favorite") as! Bool
            let memo = data.value(forKey: "memo") as! String
            
            dataToPerson.append(Person(name: name, phone: phone, favorite: favorite, memo: memo))
        }
        
        return dataToPerson
    }
    
    // TODO edit person info
    func update(person: Person) -> Person {
        return person
    }
    
    //TODO delete Person
    func delete(person: Person) -> Bool {
        
        return true
    }
}
