//
//  ObjectStore.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Foundation

protocol ObjectStore {
    func getPosts() -> Promise<[Post]>
    func getComments() -> Promise<[Comment]>
    func getUsers() -> Promise<[User]>
}
