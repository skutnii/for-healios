//
//  ObjectStore.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Foundation

class ObjectStoreImpl: ObjectStore {
    static var docDir: URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
    
    ///Posts
    static let postsSrc = URL(string: "http://jsonplaceholder.typicode.com/posts")!
        
    static var postsCache: URL {
        return docDir.appendingPathComponent("posts.json")
    }
    
    private var posts = CachedCollection<Post>(srcURL: ObjectStoreImpl.postsSrc,
                                               cacheURL: ObjectStoreImpl.postsCache,
                                               downloadMethod: fetchContent)
    
    func getPosts() -> Promise<[Post]> {
        return posts.getObjects()
    }
    
    ///Comments
    static let commentsSrc = URL(string: "http://jsonplaceholder.typicode.com/comments")!
    
    static var commentsCache: URL {
        return docDir.appendingPathComponent("comments.json")
    }
    
    private var comments = CachedCollection<Comment>(srcURL: ObjectStoreImpl.commentsSrc,
                                                     cacheURL: ObjectStoreImpl.commentsCache,
                                                     downloadMethod: fetchContent)
    
    func getComments() -> Promise<[Comment]> {
        return comments.getObjects()
    }
    
    ///Users
    static let usersSrc = URL(string: "http://jsonplaceholder.typicode.com/users")!
    
    static var usersCache: URL {
        return docDir.appendingPathComponent("users.json")
    }
    
    private var users = CachedCollection<User>(srcURL: ObjectStoreImpl.usersSrc,
                                               cacheURL: ObjectStoreImpl.usersCache,
                                               downloadMethod: fetchContent)
    
    func getUsers() -> Promise<[User]> {
        return users.getObjects()
    }
}
