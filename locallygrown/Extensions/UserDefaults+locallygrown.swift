//
//  UserDefaults+locallygrown.swift
//  locallygrown
//
//  Created by JA Kernodle on 10/19/22.
//

import Foundation

extension UserDefaults {
    open func setStruct<T: Codable>(_ value: T?, forKey defaultName: String) {
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: defaultName)
    }

    open func structData<T>(_ type: T.Type, forKey defaultName: String) -> T? where T: Decodable {
        guard let encodedData = data(forKey: defaultName) else {
            return nil
        }
        do {
            return try JSONDecoder().decode(type, from: encodedData)
        } catch {
            return nil
        }
    }
}
