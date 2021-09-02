//
//  User.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Foundation

class User: JsonSerializable, Identifiable {
    
    var id: Int

    init(id: Int) {
        self.id = id
    }

    var name: String = ""
    var username: String = ""
    var email: String = ""
    
    var address: [String: Any] = [:]
    
    var phone: String = ""
    var website: String = ""
    
    var company: [String: String] = [:]
    
    required init(jsonObject: Any) throws {
        guard
            let data = jsonObject as? [String: Any],
            let id = data["id"] as? Int
        else {
            throw RuntimeError.dataError("Invalid user JSON")
        }
        
        self.id = id
        
        name = data["name"] as? String ?? ""
        username = data["username"] as? String ?? ""
        email = data["email"] as? String ?? ""
        phone = data["phone"] as? String ?? ""
        website = data["website"] as? String ?? ""
        
        address = data["address"] as? [String: Any] ?? [:]
        company = data["company"] as? [String: String] ?? [:]
    }

}
