//
//  Contact+CoreDataProperties.swift
//  SimpleContact
//
//  Created by 김두리 on 2021/05/31.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var memo: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var phone: String?

}

extension Contact : Identifiable {

}
