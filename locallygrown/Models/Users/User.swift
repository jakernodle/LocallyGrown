//
//  User.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

protocol User {
    var name: String { get set }
    var email: String { get set }
    var pictureURL: String? { get set }
}
