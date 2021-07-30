//
//  CountGameRouter.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/28.
//

import RIBs

protocol CountGameInteractable: Interactable {
    var router: CountGameRouting? { get set }
    var listener: CountGameListener? { get set }
}

protocol CountGameViewControllable: ViewControllable {
    
}

final class CountGameRouter: ViewableRouter<CountGameInteractable, CountGameViewControllable>, CountGameRouting {

    override init(interactor: CountGameInteractable, viewController: CountGameViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
