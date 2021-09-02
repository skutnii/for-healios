//
//  Post.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Foundation

class Post: JsonSerializable, Identifiable {
    var id: Int
    var userId: Int?
    var title: String = ""
    var body: String = ""
    
    init(id: Int) {
        self.id = id
    }
    
    required init(jsonObject: Any) throws {
        guard
            let data = jsonObject as? [String: Any],
            let id = data["id"] as? Int
        else {
            throw RuntimeError.dataError("Invalid post JSON")
        }
        
        self.id = id
        userId = data["userId"] as? Int
        title = data["title"] as? String ?? ""
        body = data["body"] as? String ?? ""
    }

}
