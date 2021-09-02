//
//  Comment.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Foundation

class Comment: JsonSerializable, Identifiable {
    var id: Int

    init(id: Int) {
        self.id = id
    }
    
    var postId: Int?
    var email: String = ""
    var name: String = ""
    var body: String = ""
    
    required init(jsonObject: Any) throws {
        guard
            let data = jsonObject as? [String: Any],
            let id = data["id"] as? Int
        else {
            throw RuntimeError.dataError("Invalid comment JSON")
        }
        
        self.id = id
        self.postId = data["postId"] as? Int
        self.name = data["name"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.body = data["body"] as? String ?? ""
    }

}
