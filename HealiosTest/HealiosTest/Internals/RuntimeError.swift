//
//  RuntimeError.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Foundation

enum RuntimeError: Error {
    case dataError(String)
    case IOError(String)
    case logicError(String)
}
