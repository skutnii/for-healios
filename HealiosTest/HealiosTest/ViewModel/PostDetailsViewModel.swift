//
//  PostDetailsViewModel.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Combine

protocol PostDetailsViewModel: ObservableObject {
    var post: Post { get set }
    var user: User? { get }
    var comments: [Comment] { get }
}


