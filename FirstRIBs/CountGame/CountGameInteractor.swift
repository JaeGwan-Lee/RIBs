//
//  CountGameInteractor.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/28.
//

import RIBs
import RxSwift

protocol CountGameRouting: ViewableRouting {
    
}

protocol CountGamePresentable: Presentable {
    var listener: CountGamePresentableListener? { get set }
    // @ 4-4
    func showAlert(clickName: String, success: @escaping (() -> Void))
}

protocol CountGameListener: AnyObject {
    // @ 4-6
    func gameEnd(playerType: PlayerType)
}

final class CountGameInteractor: PresentableInteractor<CountGamePresentable>, CountGameInteractable, CountGamePresentableListener {
 
    weak var router: CountGameRouting?
    weak var listener: CountGameListener?

    override init(presenter: CountGamePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    // @ 4-3
    func playerButtonClick(player1Name: String, player2Name: String, clickName: String) {
        let alertClickName = clickName + " 클릭!"
        // @ 4-4
        presenter.showAlert(clickName: alertClickName) {
            // @ 4-7
            if clickName == player1Name {
                self.listener?.gameEnd(playerType: .player1)
            } else {
                self.listener?.gameEnd(playerType: .player2)
            }
            
        }
    }
}
