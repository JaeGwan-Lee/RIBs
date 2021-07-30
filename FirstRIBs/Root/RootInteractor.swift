//
//  RootInteractor.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/21.
//

import RIBs
import RxSwift

// Router에 호출이 필요 할 경우 RootRouting 프로토콜에 정의 해서 전달한다.
protocol RootRouting: ViewableRouting {
    func routeToLoggedIn(withPlayer1Name player1Name: String, player2Name: String)
}

// Presentable 프로토콜을 통해 RootViewController를 연결 해 준다.
// RootViewController에서 이벤트가 발생하면 Presentable 프로토콜을 통해 Interactor에게 전달한다.
protocol RootPresentable: Presentable {
    // ViewController에 어떤 행위를 할지 정의함.
    var listener: RootPresentableListener? { get set }
}

// 부모 RIB에 해당 행위를 호출한다.
protocol RootListener: AnyObject {
    
}

/*
 - Interactor
 Interactor는 비지니스 로직을 담당한다.
 Present에서 입력한 데이터가 들어왔을 때 적절한 상태로 변경하라고 다시 Present에게 전달하거나,
 Router에 전달하여 자식 RIB을 만들거나 또는 Listener에게 상태를 전달할 수도 있습니다.
 */
final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener, UrlHandler {
    
    weak var router: RootRouting?
    weak var listener: RootListener?

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    // ViewController와 상관없이 자식 RIB의 Interactor가 부모 RIB에 Attach되면서 Active가 되는데, 그때 수행할 것을 정의함.
    override func didBecomeActive() {
        super.didBecomeActive()
        
    }

    // 해당 RIB이 Detach되면서 Detactive될때 어떤 행동을 수행할 지 정의함.
    override func willResignActive() {
        super.willResignActive()
        
    }

    // @ 2-4
    func didLogin(withPlayer1Name player1Name: String, player2Name: String) {
        router?.routeToLoggedIn(withPlayer1Name: player1Name, player2Name: player2Name)
    }
    
    func handle(_ url: URL) {
        print("UrlHandler")
    }
}
