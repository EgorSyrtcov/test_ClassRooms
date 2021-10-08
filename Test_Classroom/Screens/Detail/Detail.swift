//
//  Detail.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 8.10.21.
//

import UIKit

final class Detail: UIViewController {
    
    var presenter: DetailViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension Detail: DetailViewProtocol {
    
}
