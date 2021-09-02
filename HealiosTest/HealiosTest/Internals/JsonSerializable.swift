//
//  JsonSerializable.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import Foundation

protocol JsonSerializable {
    init(jsonObject: Any) throws
}
