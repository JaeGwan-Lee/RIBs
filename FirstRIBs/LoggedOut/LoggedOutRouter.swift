//
//  LoggedOutRouter.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/21.
//

import RIBs

protocol LoggedOutInteractable: Interactable {
    var router: LoggedOutRouting? { get set }
    var listener: LoggedOutListener? { get set }
}

protocol LoggedOutViewControllable: ViewControllable {
    
}

final class LoggedOutRouter: ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>, LoggedOutRouting {

    override init(interactor: LoggedOutInteractable, viewController: LoggedOutViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
