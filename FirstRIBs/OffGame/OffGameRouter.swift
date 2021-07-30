//
//  OffGameRouter.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/22.
//

import RIBs

protocol OffGameInteractable: Interactable {
    var router: OffGameRouting? { get set }
    var listener: OffGameListener? { get set }
}

protocol OffGameViewControllable: ViewControllable {
    
}

final class OffGameRouter: ViewableRouter<OffGameInteractable, OffGameViewControllable>, OffGameRouting {

    override init(interactor: OffGameInteractable, viewController: OffGameViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
