//
//  PostsView.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import SwiftUI

struct PostsView<ViewModel: PostListViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    typealias DetailsNavigation = (ViewModel.DetailsVM) -> Void
    var showDetails: DetailsNavigation?
    
    func withDetailsNavigation(_ block: @escaping DetailsNavigation) -> PostsView {
        var clone = self
        clone.showDetails = block
        return clone
    }
    
    var body: some View {
        return List {
            ForEach(viewModel.posts) {
                post in
                HStack{
                    VStack(alignment: .leading) {
                        Text(post.title)
                        Group {
                            if
                                let authorId = post.userId,
                                let author = viewModel.authors[authorId] {
                                Text("by \(author.name)").font(.system(size: 12.0))
                            } else {
                                EmptyView()
                            }
                        }
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .onTapGesture {
                    let detailsVM = viewModel.details(for: post)
                    showDetails?(detailsVM)
                }
            }
        }
        .font(.caption())
        .navigationTitle("Posts")
    }
}

