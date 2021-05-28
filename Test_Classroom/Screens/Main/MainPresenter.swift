//
//  MainPresenter.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/27/21.
//

import Foundation

protocol MainViewProtocol: class {
    func showSpinner()
    func hideSpinner()
    func reloadTable()
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, router: RouterProtocol)
    
    func fetchClassRooms()
    func numberOfRowsInSection() -> Int
    func getClassRoom(index: IndexPath) -> ClassRoom?
    func getTextField(text: String)
}

final class MainPresenter: MainViewPresenterProtocol {
    
    private weak var view: MainViewProtocol?
    private var router: RouterProtocol?
    private var classRooms: [ClassRoom]?
    private var filterClassRooms = [ClassRoom]()
    private var dayUpdate: Int?
    
    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func fetchClassRooms() {
        
        if Base.shared.classRooms.count == 0 || getCurrentDayUpdate() == true {
            view?.showSpinner()
            // Simulation fetch data
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
                
                self?.setCurrentDayUpdate()
                
                Service.fetchReques { [weak self] (classRooms: [ClassRoom]) in
                    self?.classRooms = classRooms
                    Base.shared.saveClassRoom(classRooms)
                    
                    DispatchQueue.main.async {
                        self?.view?.hideSpinner()
                    }
                }
            }
        } else {
            classRooms = Base.shared.classRooms
            view?.reloadTable()
        }
    }
    
    private func setCurrentDayUpdate() {
        let currentDate = Date()
        let calendar = Calendar.current
        dayUpdate = calendar.component(.day, from: currentDate)
    }
    
    private func getCurrentDayUpdate() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let newDay = calendar.component(.day, from: currentDate)
        
        return newDay == dayUpdate ? true : false
    }
    
    func numberOfRowsInSection() -> Int {
        
        if !filterClassRooms.isEmpty {
            return filterClassRooms.count
        } else {
            return classRooms?.count ?? 0
        }
    }
    
    func getClassRoom(index: IndexPath) -> ClassRoom? {
        
        if !filterClassRooms.isEmpty {
            return filterClassRooms[index.row]
        } else {
            return classRooms?[index.row]
        }
    }
    
    func getTextField(text: String) {
        filterClassRooms.removeAll()
        
        guard let classRooms = classRooms else { return }
        
        let result = classRooms.filter({$0.name.contains(text.capitalized)})
        self.filterClassRooms = result
        view?.reloadTable()
    }
}

