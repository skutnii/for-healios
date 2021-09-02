//
//  Navigator.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import SwiftUI

struct Navigator: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    
    let navigationController: UINavigationController
    init(_ wrappedObject: UINavigationController) {
        navigationController = wrappedObject
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}
