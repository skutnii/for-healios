//
//  PostDetailsView.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import SwiftUI

struct PostDetailsView<ViewModel: PostDetailsViewModel>: View {
    @ObservedObject var viewModel: ViewModel
        
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Text(viewModel.post.title).font(Font.system(size: 20).weight(.bold))
                
                Spacer(minLength: 20)

                Group {
                    if let user = viewModel.user {
                        Text("by").font(.caption())
                        
                        HStack {
                            Spacer(minLength: 20)
                            
                            VStack(alignment: .leading) {
                                Text(user.name)
                                Text("company: \(user.company["name"] ?? "none")")
                                Text("email: \(user.email)")
                                Text("phone: \(user.phone)")
                            }
                        }
                    } else {
                        EmptyView()
                    }
                }
                
                Spacer(minLength: 20)
                
                Text(viewModel.post.body)

                Spacer(minLength: 20)
                
                Text("Comments:").font(.caption())

                Spacer(minLength: 10.0)

                ForEach(viewModel.comments) {
                    comment in
                    
                    VStack(alignment: .leading, spacing: 5.0) {
                        Text(comment.name).font(.system(size:14.0).weight(.bold))
                        Text(comment.body).font(.comment())
                        Text("by \(comment.email)").font(.comment())
                    }

                    Spacer(minLength: 10.0)
                }
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)

        }
        .navigationTitle("Post")
    }
}
