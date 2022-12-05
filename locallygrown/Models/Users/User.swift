//
//  User.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

// User objects are immutable for these properties on the client (only backend calls can change these)
protocol User {
    var id: String { get }
    var name: String { get }
    var email: String { get }
    // Pictures are optional
    var pictureURL: String? { get }
}
