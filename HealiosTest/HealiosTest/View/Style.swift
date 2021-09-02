//
//  Style.swift
//  HealiosTest
//
//  Created by Sergii Kutnii on 02.09.2021.
//

import SwiftUI

extension Font {
    static func caption() -> Font {
        return self.body.weight(.bold)
    }
    
    static func comment() -> Font {
        return self.system(size:12.0)
    }
}

