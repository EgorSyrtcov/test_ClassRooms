//
//  ClassCell.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/27/21.
//

import UIKit

final class ClassCell: UITableViewCell {
    
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
        name.text = "\(classRoom.name)"
        status.text = classRoom.status.title
        imageScreen.image = classRoom.type.icon
        viewForButton.isHidden = classRoom.type.isViewButtonHidden
        viewStatus.backgroundColor = classRoom.status.backgroundColor
        dateUpdate.text = classRoom.updateAt.formattedDate
    }
}
