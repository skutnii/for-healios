//
//  PostDetailsViewModelImplTests.swift
//  HealiosTestUnitTests
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import XCTest

class PostDetailsViewModelImplTests: XCTestCase {

    var objectStore: MockObjectStore?
    
    lazy var users: [User] = {
        var user1 = User(id: 2)
        user1.name = "Foo Foo"
        
        var user2 = User(id: 15)
        user2.name = "Bar Bar"
        
        return [user1, user2]
    } ()
    
    lazy var comments: [Comment] = {
        var comment1 = Comment(id: 11)
        comment1.postId = 13
        comment1.name = "foo"
        
        var comment2 = Comment(id: 2)
        comment2.postId = 21
        comment2.name = "bar"
        
        var comment3 = Comment(id: 42)
        comment3.postId = 13
        comment3.name = "baz"
        
        return [comment1, comment2, comment3]
    } ()

    override func setUpWithError() throws {
        objectStore = MockObjectStore()
        
        objectStore!.comments.resolve(comments)
        objectStore!.users.resolve(users)
    }

    func testMatchingUser() {
        let post = Post(id: 1)
        post.userId = 2
        
        let vm = PostDetailsViewModelImpl(post: post, objectStore: objectStore!)

        guard
            let user = vm.user
        else {
            XCTFail("User must be matched by post's userId")
            return
        }
        
        XCTAssertEqual(user.name, "Foo Foo", "User name must match")
    }
    
    func testMatchingComments() {
        let post = Post(id: 13)
        let vm = PostDetailsViewModelImpl(post: post, objectStore: objectStore!)
        
        XCTAssertEqual(vm.comments.count, 2, "Must be exactly two matching comments")
        var fooFound = false
        var bazFound = false
        
        for comment in vm.comments {
            if (comment.id == 11) && (comment.name == "foo") {
                fooFound = true
                continue
            }

            if (comment.id == 42) && (comment.name == "baz") {
                bazFound = true
                continue
            }
        }
        
        XCTAssertTrue(fooFound, "`foo` comment must be present")
        XCTAssertTrue(bazFound, "`baz` comment must be present")
    }
    
    func testNonMatchingPost() {
        let post = Post(id: 291)
        post.userId = 256
        let vm = PostDetailsViewModelImpl(post: post, objectStore: objectStore!)
        
        XCTAssertNil(vm.user, "There must be no user")
        XCTAssertTrue(vm.comments.isEmpty, "There must be no comments")
    }
}
