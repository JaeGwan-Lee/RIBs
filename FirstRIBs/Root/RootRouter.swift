//
//  RootRouter.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/21.
//

import RIBs

// 자식RIB의 Listner를 채택하고 자식 RIB의 Listener에 정의 된 이벤트만 전달 받을 수 있다.
protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

// ViewController에 구현될 함수를 정의하며, Router에서 present, dismiss, push, pop 정도의 행위만 하도록 정의함.
protocol RootViewControllable: ViewControllable {
    // @ 1-5
    func present(viewController: ViewControllable)
    // @ 2-6
    func dismiss(viewController: ViewControllable)
}

/*
 - Router
 Interactor와 ViewController를 연결 해 주는 역할을 한다.
 RIB 간의 데이터 전달이 이루어 져야 한다면 Router를 통해야만 합니다.
 Buildable을 선택해서 자식 RIB을 만들어 Attach를 하거나 ViewController에게 자식 router에서 나온 ViewController를 Push하거나 Present하는 역할을 한다.
 그리고 자식 router의 ViewController를 dismiss하거나 pop을 하는 역할도 수행합니다.
 */
final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    // @ 1-7 자식 RIB를 연결 할 경우 ViewableRouting 프로토콜에 정의 한 후 사용한다.
    private var loggedOut: ViewableRouting?
    private let loggedOutBuilder: LoggedOutBuildable

    // @ 2-11
    private let loggedInBuilder: LoggedInBuildable
    
    // @ 1-8
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuildable,
         loggedInBuilder: LoggedInBuildable) {
        
        self.loggedOutBuilder = loggedOutBuilder
        // @ 2-12
        self.loggedInBuilder = loggedInBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // viewdidload와 같이 초기화 과정이 필요 할 때 재정의 하여 사용한다.
    // @ 1-9
    override func didLoad() {
        super.didLoad()
        // 자식 RIB인 LoggedOut RIB를 생성하여 연결하는 작업을 함.
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        // 다른 RIB를 연결 할 경우 ViewableRouting 프로토콜에 정의 한 후 사용한다.
        self.loggedOut = loggedOut
        // 자식 RIB 연결 하기
        attachChild(loggedOut)
        // 루트 화면에서 loggedOut 화면으로 변경한다.
        viewController.present(viewController: loggedOut.viewControllable)
    }
    
    
    // @ 2-5
    func routeToLoggedIn(withPlayer1Name player1Name: String, player2Name: String) {
        if let loggedOut = self.loggedOut {
            // 자식 RIB 해제
            detachChild(loggedOut)
            // @ 2-7 자식 RIB 화면 닫기
            viewController.dismiss(viewController: loggedOut.viewControllable)
            self.loggedOut = nil
        }

        // @ 2-13
        // 본인 Interactable에 자식 RIB Listener 추가
        let loggedIn = loggedInBuilder.build(withListener: interactor, player1Name: player1Name, player2Name: player2Name)
        attachChild(loggedIn)
    }
}
