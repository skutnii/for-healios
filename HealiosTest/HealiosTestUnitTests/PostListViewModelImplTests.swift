//
//  HealiosTestUnitTests.swift
//  HealiosTestUnitTests
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import XCTest

class PostListViewModelImplTests: XCTestCase {
    
    var objectStore: MockObjectStore?
    var viewModel: PostListViewModelImpl?

    override func setUpWithError() throws {
        objectStore = MockObjectStore()
        viewModel = PostListViewModelImpl(objectStore: objectStore!)
    }

    override func tearDownWithError() throws {
        objectStore = nil
        viewModel = nil
    }
    
    func testPostsNotUpdatedWithoutUsers() throws {
        var postsBlockCalled = false
        let cancellable = viewModel!.$posts.sink { posts in
            guard
                posts.count == 1, //The block is called first when it is passed to .sink(), so this is needed to filter out false positives
                posts[0].id == 1
            else {
                return
            }
            
            postsBlockCalled = true
        }
        
        objectStore!.posts.resolve([Post(id: 1)])
        XCTAssertFalse(postsBlockCalled, "PostListViewModelImpl must not update its posts var if just posts have been loaded")
    }
    
    func testAuthorsAreNotUpdatedWithoutPosts() throws {
        var usersBlockCalled = false
        let cancellable = viewModel!.$authors.sink {
            users in
            guard
                users.count == 1,
                let user = users[1],
                user.id == 1
            else {
                return
            }
            
            usersBlockCalled = true
        }
        
        objectStore!.users.resolve([User(id: 1)])
        XCTAssertFalse(usersBlockCalled, "PostListViewModelImpl must not update its authors if just users were loaded")
    }

    func testPostsAndAuthorsAreUpdatedWhenBothLoad() throws {
        var postsBlockCalled = false
        var usersBlockCalled = false
        
        let cancellable1 = viewModel!.$authors.sink {
            users in
            guard
                users.count == 1,
                let user = users[1],
                user.id == 1
            else {
                return
            }
            
            usersBlockCalled = true
        }
        
        let cancellable2 = viewModel!.$posts.sink {
            posts in
            guard
                posts.count == 1,
                posts[0].id == 1
            else {
                return
            }
            
            postsBlockCalled = true
        }
        
        objectStore!.posts.resolve([Post(id: 1)])
        objectStore!.users.resolve([User(id: 1)])
        
        XCTAssertTrue(postsBlockCalled, "Posts property must be updated when both posts and users are loaded")
        XCTAssertTrue(usersBlockCalled, "Authors property must be updated when both posts and users are loaded")
    }

}
