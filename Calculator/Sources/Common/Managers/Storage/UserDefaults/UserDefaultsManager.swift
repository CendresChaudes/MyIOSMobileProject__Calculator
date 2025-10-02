//
//  UserDefaults.swift
//  Calculator
//
//  Created by Роман on 02.10.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import Foundation

protocol IUserDefaultsManager {

    associatedtype Key: Hashable
    associatedtype Value: Codable

    func create(value: Value, forKey key: Key)
    func read(forKey key: Key) -> Value?
    func delete(forKey key: Key)
}

class UserDefaultsManager<Key: Hashable, Value: Codable>: IUserDefaultsManager {

    private let userDefaultsStandard = UserDefaults.standard

    init() {}

    func create(value: Value, forKey key: Key) {
        if let encoded = try? JSONEncoder().encode(value) {
            userDefaultsStandard.set(encoded, forKey: "\(key)")
        }
    }

    func read(forKey key: Key) -> Value? {
        if let data = userDefaultsStandard.data(forKey: "\(key)") {
            return try? JSONDecoder().decode(Value.self, from: data)
        }

        return nil
    }

    func delete(forKey key: Key) {
        userDefaultsStandard.removeObject(forKey: "\(key)")
    }
}
