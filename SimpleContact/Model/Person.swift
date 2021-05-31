
//  Person.swift
//  SimpleContact
//
//  Created by 김진태 on 2021/05/19.
//

import Foundation

struct Person: Equatable{
    var name: String
    var phone: String
    var favorite: Bool
    var memo: String
    
    static func ==(left: Person, right: Person) -> Bool {
        return left.name == right.name && left.phone == right.phone
    }
}

