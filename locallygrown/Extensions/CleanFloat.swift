//
//  CleanFloat.swift
//  locallygrown
//
//  Created by JA Kernodle on 11/4/22.
//

import Foundation

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
