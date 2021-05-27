//
//  Date.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/27/21.
//

import UIKit

extension Date{
    var intVal: Int?{
        if let d = Date.coordinate{
             let inteval = Date().timeIntervalSince(d)
             return Int(inteval)
        }
        return nil
    }


    // today's time is close to `2020-04-17 05:06:06`

    static let coordinate: Date? = {
        let dateFormatCoordinate = DateFormatter()
        dateFormatCoordinate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let d = dateFormatCoordinate.date(from: "2020-04-17 05:06:06") {
            return d
        }
        return nil
    }()
}


extension Int{
    var dateVal: Date?{
        // convert Int to Double
        let interval = Double(self)
        if let d = Date.coordinate {
            return  Date(timeInterval: interval, since: d)
        }
        return nil
    }
}
