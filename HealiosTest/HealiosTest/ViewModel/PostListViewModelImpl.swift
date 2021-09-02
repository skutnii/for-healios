//
//  PostListViewModel.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Combine

class PostListViewModelImpl: PostListViewModel{
    private let objectStore: ObjectStore
    
    init(objectStore: ObjectStore) {
        self.objectStore = objectStore

        _ = (objectStore.getPosts() &&& objectStore.getUsers()).then({
            [weak self] (res: ([Post], [User])) in
            let (posts, users) = res
            self?.posts = posts
            
            var userIndex = [Int: User]()
            for user in users {
                userIndex[user.id] = user
            }
            
            self?.authors = userIndex
        })
    }
    
    @Published private(set) var posts: [Post] = []
    @Published private(set) var authors: [Int : User] = [:]

    func details(for post: Post) -> PostDetailsViewModelImpl {
        return PostDetailsViewModelImpl(post: post, objectStore: objectStore)
    }
}
