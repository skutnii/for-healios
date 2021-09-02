//
//  HealiosTestApp.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import SwiftUI

@main
struct HealiosTestApp: App {
    let objectStore = ObjectStoreImpl()
    
    let navigationController = UINavigationController()
    
    let postsVM: PostListViewModelImpl
    
    init() {
        postsVM = PostListViewModelImpl(objectStore: objectStore)
    }
    
    var body: some Scene {
        WindowGroup {
            {
                () -> Navigator in
                let postsView =
                    PostsView(viewModel: postsVM)
                        .withDetailsNavigation {
                            [unowned navigationController] detailsVM in
                            let details = PostDetailsView(viewModel: detailsVM)
                            let wrapper = UIHostingController(rootView: details)
                            navigationController.pushViewController(wrapper, animated: true)
                        }
                
                navigationController.viewControllers = [UIHostingController(rootView: postsView)]
                
                return Navigator(navigationController)
            } ()
        }
    }
}
