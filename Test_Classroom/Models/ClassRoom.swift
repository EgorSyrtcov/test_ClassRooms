//
//  Class.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/27/21.
//

import Foundation


struct ClassRoom: Decodable {
    
    let id: Int
    let type: String
    let status: String
    let name: String
    let updateAt: Int
}
