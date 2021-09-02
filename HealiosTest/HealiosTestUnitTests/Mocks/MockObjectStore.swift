//
//  MockObjectStore.swift
//  HealiosTestUnitTests
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Foundation

class MockObjectStore: ObjectStore {
    var posts = Promise<[Post]>()
    func getPosts() -> Promise<[Post]> {
        return posts
    }
    
    var users = Promise<[User]>()
    func getUsers() -> Promise<[User]> {
        return users
    }
    
    var comments = Promise<[Comment]>()
    func getComments() -> Promise<[Comment]> {
        return comments
    }
}
