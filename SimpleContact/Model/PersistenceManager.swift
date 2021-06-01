//
//  PersistenceManager.swift
//  SimpleContact
//
//  Created by 김두리 on 2021/05/31.
//

import CoreData
import Foundation

class PersistenceManager {
    static var shared = PersistenceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Contact")
        container.loadPersistentStores(completionHandler: {
            _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        // context 내부에 변화가 없다면 저장하지 않도록 하여 불필요한 연산을 줄임. context.save는 연산량이 많은 메소드라고 함.
        if context.hasChanges {
            // perform 메소드는 Thread 관련한 문제를 미리 방지해주기 위해 쓰는 메소드라는데 정확히는 모릅니다 ㅎㅎ - 진태
            context.perform {
                do {
                    try self.context.save()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
    
    func createContact(name: String, memo: String, phone: String, favorite: Bool, completion: (() -> Void)? = nil) {
        let contact = Contact(context: context)
        
        contact.name = name
        contact.memo = memo
        contact.phone = phone
        contact.favorite = favorite
            
        saveContext()
        completion?()
    }
    
    // filterPredicate는 나중에 Favorite 버튼을 눌렀을 때 Favorite된 데이터만 불러오기 위해 넣어줌
    func readContacts(filterPredicate: NSPredicate? = nil) -> [Contact] {
        let readRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        // Contact의 이름 순에 따라 Sort하기 위한 코드
        let sortByName = NSSortDescriptor(key: #keyPath(Contact.name), ascending: true)
        readRequest.sortDescriptors = [sortByName]
        readRequest.predicate = filterPredicate
        
        var contactList = [Contact]() // 빈 배열 생성
        
        // contactList의 값을 읽어옴
        context.performAndWait {
            do {
                contactList = try context.fetch(readRequest)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        
        return contactList
    }
    
    // TODO: edit person info
    func updateContact(_ contact: Contact, name: String, memo: String, phone: String, favorite: Bool, completion: (() -> Void)? = nil) {
        contact.name = name
        contact.memo = memo
        contact.phone = phone
        contact.favorite = favorite
        
        saveContext()
        completion?()
    }
    
    // TODO: delete Person
    func deleteContact(_ contact: Contact) {
        context.delete(contact)
        saveContext()
    }
}
