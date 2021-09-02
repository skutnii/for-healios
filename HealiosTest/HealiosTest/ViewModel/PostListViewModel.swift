//
//  PostListViewModel.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Combine

protocol PostListViewModel: ObservableObject {
    var posts: [Post] { get }
    var authors: [Int: User] { get }
    
    associatedtype DetailsVM: PostDetailsViewModel
    func details(for post: Post) -> DetailsVM
}


