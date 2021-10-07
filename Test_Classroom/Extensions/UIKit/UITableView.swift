//
//  UITableView.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 7.10.21.
//

import UIKit

extension UITableView {
    
    func registerClassForCell<T: UITableViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func registerNibForCell<T: UITableViewCell>(_ cell: T.Type) {
        let nib = UINib(nibName: String(describing: cell), bundle: nil)
        self.register(nib, forCellReuseIdentifier: cell.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for index: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.identifier, for: index) as! T
    }
    
    func isLast(for indexPath: IndexPath) -> Bool {
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
    
}
