//
//  User.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

protocol User {
    var id: String { get }
    var name: String { get }
    var email: String { get }
    var pictureURL: String? { get }
}
