//
//  Base.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/28/21.
//

import Foundation

class Base {
    
    static let shared = Base()
    
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    var classRooms: [ClassRoom] {
        get {
            if let data = defaults.value(forKey: "classRooms") as? Data {
                return try! PropertyListDecoder().decode([ClassRoom].self, from: data)
            } else {
                return [ClassRoom]()
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "classRooms")
            }
        }
    }
    
    func saveClassRoom(_ classRooms: [ClassRoom]) {
        self.classRooms = classRooms
    }
}
