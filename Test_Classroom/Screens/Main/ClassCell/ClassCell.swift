//
//  ClassCell.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/27/21.
//

import UIKit

final class ClassCell: UITableViewCell {
    
    private enum StatusColor {
        case inProgress
        case completed
        case notStarted
        
        var textName: String {
            switch self {
            case .inProgress:
                return "inProgress"
            case .completed:
                return "completed"
            case .notStarted:
                return "notStarted"
            }
        }
    }
    
    static let identifier = "ClassCell"
    
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var status: UILabel!
    @IBOutlet weak var dateUpdate: UILabel!
    @IBOutlet weak var imageScreen: UIImageView!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var viewForButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ClassCell", bundle: nil)
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 11, left: 22, bottom: 11, right: 18)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }
    
    func setupClassRoom(_ classRoom: ClassRoom?) {
        
        guard let classRoom = classRoom else { return }
        
        self.name.text = "\(classRoom.name)"
        self.status.text = "\(classRoom.status)"
        
        if classRoom.type == "english" {
            imageScreen.image = UIImage(named: "Group 1589")
            viewForButton.isHidden = true
        }
        
        if classRoom.status == StatusColor.inProgress.textName {
            viewStatus.backgroundColor = UIColor.statusInProcessColor()
        }
        
        if classRoom.status == StatusColor.completed.textName {
            viewStatus.backgroundColor = UIColor.statusCompletedColor()
        }
        
        if classRoom.status == StatusColor.notStarted.textName {
            viewStatus.backgroundColor = UIColor.statusNotStartedColor()
        }
        
        let timeInterval = TimeInterval(classRoom.updateAt)
        // create NSDate from Double (NSTimeInterval)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)
        dateUpdate.text = "\(myNSDate)"
    }
}
