//
//  LoggedInBuilder.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/22.
//

import RIBs

protocol LoggedInDependency: Dependency {
    var loggedInViewController: LoggedInViewControllable { get }
}

final class LoggedInComponent: Component<LoggedInDependency> {

    fileprivate var LoggedInViewController: LoggedInViewControllable {
        return dependency.loggedInViewController
    }
    
    // @ 2-8
    let player1Name: String
    let player2Name: String

    init(dependency: LoggedInDependency, player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(dependency: dependency)
    }
    
    // @ 4-15
    var mutableCountStream: MutableCountStream {
        return shared{ CountStreamClass() }
    }
}

protocol LoggedInBuildable: Buildable {
    // @ 2-9
    func build(withListener listener: LoggedInListener, player1Name: String, player2Name: String) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener, player1Name: String, player2Name: String) -> LoggedInRouting {
        // @ 2-10
        let component = LoggedInComponent(dependency: dependency,
                                          player1Name: player1Name,
                                          player2Name: player2Name)
        // @ 4-16
        let interactor = LoggedInInteractor(mutableCountStream: component.mutableCountStream)
        interactor.listener = listener
        // @ 2-17
        let offGameBuilder = OffGameBuilder(dependency: component)
        // @ 3-14
        let countGameBuilder = CountGameBuilder(dependency: component)
        return LoggedInRouter(interactor: interactor,
                              viewController: component.LoggedInViewController,
                              offGameBuilder: offGameBuilder,
                              countGameBuilder: countGameBuilder)
    }
}

// @ 2-18
extension LoggedInComponent: OffGameDependency {
    
    // @ 4-20
    var countStream: CountStream {
        return mutableCountStream
    }
    
 
}

// @ 3-15
extension LoggedInComponent: CountGameDependency {
    
}
