//
//  PostDetailsViewModel.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Combine

class PostDetailsViewModelImpl: PostDetailsViewModel {
    @Published var post: Post
    
    init(post: Post, objectStore: ObjectStore) {
        self.post = post
        
        if let userId = post.userId {
            _ = objectStore.getUsers().then {
                [weak self] (users: [User]) in
                self?.user = users.first(where: { user in
                    user.id == userId
                })
            }
        }
        
        _ = objectStore.getComments().then {
            [weak self] (comments: [Comment]) in
            self?.comments = comments.filter { comment  in
                comment.postId == post.id
            }
        }
    }
    
    @Published private(set) var user: User?
    @Published private(set) var comments: [Comment] = []
}

