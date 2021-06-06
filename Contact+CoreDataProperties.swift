//
//  Contact+CoreDataProperties.swift
//  SimpleContact
//
//  Created by 김두리 on 2021/06/06.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var favorite: Bool
    @NSManaged public var memo: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var photo: Data?

}

extension Contact : Identifiable {

}
