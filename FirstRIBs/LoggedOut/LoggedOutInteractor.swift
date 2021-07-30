//
//  LoggedOutInteractor.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/21.
//

import RIBs
import RxSwift

protocol LoggedOutRouting: ViewableRouting {
    
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
    
}

protocol LoggedOutListener: AnyObject {
    func didLogin(withPlayer1Name player1Name: String, player2Name: String)
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {
    
    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?

    override init(presenter: LoggedOutPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    // @ 2-3 자식 RIB Interactor -> 부모 RIB Interactor
    func login(withPlayer1Name player1Name: String?, player2Name: String?) {
        let player1NameWithDefault = playerName(player1Name, withDefaultName: "Player 1")
        let player2NameWithDefault = playerName(player2Name, withDefaultName: "Player 2")
        
        listener?.didLogin(withPlayer1Name: player1NameWithDefault, player2Name: player2NameWithDefault)
    }

    private func playerName(_ name: String?, withDefaultName defaultName: String) -> String {
        if let name = name {
            return name.isEmpty ? defaultName : name
        } else {
            return defaultName
        }
    }
    
}
