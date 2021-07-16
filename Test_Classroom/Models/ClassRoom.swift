//
//  Class.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/27/21.
//

import UIKit

enum ClassRoomType {
    case physics
    case chemistry
    case science
    case english
    case math
    case unknown
            
    var icon: UIImage? {
        switch self {
        case .english: return UIImage(named: "Group 1589")
        case .physics, .chemistry, .science, .math: return UIImage(named: "Group 1588")
        case .unknown: return nil
        }
    }
    
    var isViewButtonHidden: Bool {
        switch self {
        case .chemistry, .english: return true
        case .physics, .science, .math: return false
        case .unknown: return true
        }
    }
}

enum ClassRoomStatus {
    case inProgress
    case completed
    case start
    case unknown
            
    var backgroundColor: UIColor {
        switch self {
        case .inProgress: return UIColor.statusInProcessColor()
        case .completed: return UIColor.statusCompletedColor()
        case .start: return UIColor.statusNotStartedColor()
        case .unknown: return .clear
        }
    }
    
    var title: String {
        switch self {
        case .inProgress: return "In Progress"
        case .completed: return "Completed"
        case .start: return "Start"
        case .unknown: return ""
        }
    }
}

struct ClassRoom: Codable {
    
    let id: Int
    let name: String
    let updateAt: Int
    
    private let _type: String
    private let _status: String
    
    var type: ClassRoomType {
        switch _type.lowercased() {
        case "physics": return .physics
        case "chemistry": return .chemistry
        case "science": return .science
        case "english": return .english
        case "math": return .math
        default: return .unknown
        }
    }
    
    var status: ClassRoomStatus {
        switch _status.lowercased() {
        case "inprogress": return .inProgress
        case "completed": return .completed
        case "notstarted": return .start
        default: return .unknown
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case updateAt
        case _type = "type"
        case _status = "status"
    }   
}
