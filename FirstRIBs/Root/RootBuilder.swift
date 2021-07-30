//
//  RootBuilder.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/21.
//

import RIBs

/*
 - Dependency
 다른 RIB의 필요한 변수, 함수를 프로토콜에 정의 해야 한다.
 변수는 프로퍼티 get으로 정의하며 RIB의 변수명과 동일하게 기재해야 한다.
 Dependency 프로토콜에 정의된 것들은 Dependency를 따르는 Component Class가 구현 한다.
 */
protocol RootDependency: Dependency {
}

/*
 - Component
 Builder에서 다른 RIB와 소통이 필요한 경우 생성되는 객체이다.
 Component 생성 시 프로토콜에 작성 된 변수만 접근이 가능하다.
 Builder에서 Component에 접근하기 위해 fileprivate으로 범위 설정한다.
 */
final class RootComponent: Component<RootDependency> {
    // @ Root->Login RIB 이동 시작
    // @ 1-1
    let rootViewController: RootViewController
    init(dependency: RootDependency, rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

protocol RootBuildable: Buildable {
    func build() -> (launchRouter: LaunchRouting, urlHandler: UrlHandler)
}

/*
 - Builder
 RIB은 Builder로부터 시작하며 Builder는 Buildable 프로토콜 규칙을 따른다.
 Router, Interactor, ViewController, Component 생성을 담당하는 역할을 한다.
 Builder는 각 구성 요소 클래스와 자식 RIB의 Builder를 만드는 로직을 가지며, 세부 구현에 영향을 미치지 않는다.
 자식 RIB의 Builder는 Router에서 가지고 있으며 Router에서 자식 Builder에 build 함수를 통해 자식 Router를 만들어 attach 한다.
 유닛테스트 시 가상의 클래스가 필요한 경우 Builder에서 작성 해 주면 유닛테스트에 필요한 가상의 클래스를 생성할 수 있다.
 */
final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
    
    // UrlHandler는 외부로 부턴 openUrl 호출이 들어 올 경우 handler 사용
    func build() -> (launchRouter: LaunchRouting, urlHandler: UrlHandler) {
        let viewController = RootViewController()
        // @ 1-2
        let component = RootComponent(dependency: dependency,
                                      rootViewController: viewController)
        let interactor = RootInteractor(presenter: viewController)
        // @ 1-3
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        // @ 2-14
        let loggedInBuilder = LoggedInBuilder(dependency: component)
        let router = RootRouter(interactor: interactor,
                                    viewController: viewController,
                                    loggedOutBuilder: loggedOutBuilder,
                                    loggedInBuilder: loggedInBuilder)
        return (router, interactor)
    }
}

// 자식 RIb의 Builder를 DI 할 때 Component에 자식 RIB의 dependency를 채택 해야 한다.
// @ 1-4
extension RootComponent: LoggedOutDependency {

}

// @ 2-15
extension RootComponent: LoggedInDependency {

    var loggedInViewController: LoggedInViewControllable {
        return rootViewController
    }
    
}
