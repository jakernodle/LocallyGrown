//
//  APIError.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

enum RemoteApiError: Error {
    
    case badRequest(message: String)
    case unauthorized(message: String)
    case forbidden(message: String)
    case notFound(message: String)
    case parsing(message: String)
    case internalServer(message: String)
    case unexpected(code: Int, message: String)

    init(statusCode: Int, message: String) {
        switch statusCode {
        case 404:
            self = .notFound(message: message)
        case 400:
            self = .badRequest(message: message)
        case 401:
            self = .unauthorized(message: message)
        case 403:
            self = .forbidden(message: message)
        case 500:
            self = .internalServer(message: message)
        default:
            self = .unexpected(code: statusCode, message: message)
        }
    }
}
