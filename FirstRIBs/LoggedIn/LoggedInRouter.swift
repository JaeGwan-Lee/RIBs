//
//  LoggedInRouter.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/22.
//

import RIBs
import Hero

protocol LoggedInInteractable: Interactable, OffGameListener, CountGameListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
    
    private let viewController: LoggedInViewControllable
    // @ 2-19
    private let offGameBuilder: OffGameBuildable
    // @ 2-21
    private var currentChild: ViewableRouting?
    // @ 3-11
    private let countGameBuilder: CountGameBuildable
    
    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         offGameBuilder: OffGameBuildable,
         countGameBuilder: CountGameBuildable) {
        self.viewController = viewController
        // @ 2-20
        self.offGameBuilder = offGameBuilder
        // @ 3-12
        self.countGameBuilder = countGameBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        attachOffGame()
    }
    
    // @ 2-22
    private func attachOffGame() {
        let offGame = offGameBuilder.build(withListener: interactor)
        self.currentChild = offGame
        attachChild(offGame)
        viewController.present(viewController: offGame.viewControllable)
    }
    
    // @ 3-10
    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }
    
    // @ 3-9
    func routeToCountGame(player1Name: String, player2Name: String) {
        detachCurrentChild()
        // @ 3-13
        let countGame = countGameBuilder.build(withListener: interactor)
        currentChild = countGame
        attachChild(countGame)
        viewController.present(viewController: countGame.viewControllable)
    }
    
    // @ 4-10
    func routeToOffGame() {
        detachCurrentChild()
        attachOffGame()
    }
 
}
