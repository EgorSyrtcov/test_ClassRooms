//
//  ModuleBuilder.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/27/21.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(router: RouterProtocol) -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
   
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = Main()
        let dependencies = Dependencies()
        let presenter = MainPresenter(view: view, router: router, dependencies: dependencies)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(router: RouterProtocol) -> UIViewController {
        let view = Detail()
        let dependencies = Dependencies()
        let presenter = DetailPresenter(view: view, router: router, dependencies: dependencies)
        view.presenter = presenter
        return view
    }
}
