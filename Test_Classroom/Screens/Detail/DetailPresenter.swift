//
//  DetailPresenter.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 8.10.21.
//

import Foundation

protocol DetailViewProtocol: AnyObject {}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, router: RouterProtocol, dependencies: Dependencies)
}

final class DetailPresenter: DetailViewPresenterProtocol {
  
    private weak var view: DetailViewProtocol?
    private var router: RouterProtocol?
    private var dependencies: Dependencies
    
    required init(view: DetailViewProtocol, router: RouterProtocol, dependencies: Dependencies) {
        self.view = view
        self.router = router
        self.dependencies = dependencies
    }
}
