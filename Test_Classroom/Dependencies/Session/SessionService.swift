//
//  SessionService.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/29/21.
//

import Foundation

fileprivate enum SessionUserDefaultKey: String {
    case classRoom = "classRooms"
    case date = "date"
    var key: String { return rawValue }
}

final class SessionService {
 
    private let userDefaults = UserDefaults.standard
    
    var classRooms: [ClassRoom] {
        get {
            guard let data = userDefaults.value(forKey: SessionUserDefaultKey.classRoom.key) as? Data,
                  let items = try? PropertyListDecoder().decode([ClassRoom].self, from: data) else { return [] }
            return items
        }
        
        set {
            guard let data = try? PropertyListEncoder().encode(newValue) else { return }
            userDefaults.set(data, forKey: SessionUserDefaultKey.classRoom.key)
        }
    }
    
    var savedDate: String? {
        get {
            return userDefaults.value(forKey: SessionUserDefaultKey.date.key) as? String
        }
        
        set {
            userDefaults.set(newValue, forKey: SessionUserDefaultKey.date.key)
        }
    }
    
    var currentDate: String {
        let currentDate = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        return "\(day).\(month).\(year)"
    }
}
