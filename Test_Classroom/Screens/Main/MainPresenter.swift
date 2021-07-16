//
//  MainPresenter.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/27/21.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func showSpinner()
    func hideSpinner()
    func reloadTable()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol, dependencies: Dependencies)
    
    func fetchClassRooms()
    func numberOfRowsInSection() -> Int
    func getClassRoom(by indexPath: IndexPath) -> ClassRoom?
    func filteringResult(with text: String)
}

final class MainPresenter: MainViewPresenterProtocol {
    
    private weak var view: MainViewProtocol?
    private var router: RouterProtocol?
    private var dependencies: Dependencies
    
    private var allClassRooms = [ClassRoom]()
    private var filteredClassRooms = [ClassRoom]()
    
    required init(view: MainViewProtocol, router: RouterProtocol, dependencies: Dependencies) {
        self.view = view
        self.router = router
        self.dependencies = dependencies
    }
}

extension MainPresenter {
    func fetchClassRooms() {
        let shouldLoadFromCache = dependencies.sessionService.currentDate == dependencies.sessionService.savedDate && !dependencies.sessionService.classRooms.isEmpty
        guard shouldLoadFromCache else {
            view?.showSpinner()
            fetchClassRooms(source: .request) { [weak self] items in
                self?.dependencies.sessionService.savedDate = self?.dependencies.sessionService.currentDate
                self?.dependencies.sessionService.classRooms = items
                self?.allClassRooms = items
                self?.filteredClassRooms = items
                self?.view?.reloadTable()
                self?.view?.hideSpinner()
            }
            return
        }
        fetchClassRooms(source: .cache) { [weak self] items in
            self?.allClassRooms = items
            self?.filteredClassRooms = items
            self?.view?.reloadTable()
        }
    }
}

extension MainPresenter {
    func numberOfRowsInSection() -> Int {
        return filteredClassRooms.count
    }
}

extension MainPresenter {
    func getClassRoom(by indexPath: IndexPath) -> ClassRoom? {
        guard !filteredClassRooms.isEmpty, filteredClassRooms.count - 1 >= indexPath.row else { return nil }
        return filteredClassRooms[indexPath.row]
    }
}

extension MainPresenter {
    func filteringResult(with text: String) {
        guard !text.isEmpty else {
            filteredClassRooms.removeAll()
            filteredClassRooms = allClassRooms
            view?.reloadTable()
            return
        }
        filteredClassRooms.removeAll()
        filteredClassRooms = allClassRooms.filter({$0.name.contains(text.capitalized)})
        view?.reloadTable()
    }
}

private enum ClassRoomsSource {
    case cache
    case request
}

private extension MainPresenter {
    func fetchClassRooms(source: ClassRoomsSource, completion: @escaping ([ClassRoom]) -> Void) {
        switch source {
        case .cache: completion(dependencies.sessionService.classRooms)
        case .request:
            dependencies.apiService.fetchReques(requestURL: .localMock) { items in
                completion(items)
            }
        }
    }
}
