//
//  LoggedInInteractor.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/22.
//

import RIBs
import RxSwift

enum PlayerType: Int {
    case player1 = 1
    case player2
}

protocol LoggedInRouting: Routing {
    // @ 3-7
    func routeToCountGame(player1Name: String, player2Name: String)
    // @ 4-9
    func routeToOffGame()
}

protocol LoggedInListener: AnyObject {
    
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {
    
    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?
    
    private let mutableCountStream: MutableCountStream

    init(mutableCountStream: MutableCountStream) {
        self.mutableCountStream = mutableCountStream
    }
    override func didBecomeActive() {
        super.didBecomeActive()
        
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    // @ 3-6
    func goToGameRIB(player1Name: String, player2Name: String) {
        // @ 3-8
        router?.routeToCountGame(player1Name: player1Name, player2Name: player2Name)
    }
    
    // @ 4-8
    func gameEnd(playerType: PlayerType) {
        mutableCountStream.updateCount(playerType: playerType)
        router?.routeToOffGame()
    }

}
