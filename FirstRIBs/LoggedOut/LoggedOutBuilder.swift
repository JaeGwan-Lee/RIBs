//
//  LoggedOutBuilder.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/21.
//

import RIBs

protocol LoggedOutDependency: Dependency {
    
}

final class LoggedOutComponent: Component<LoggedOutDependency> {

}

protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {

    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        _ = LoggedOutComponent(dependency: dependency)
        let viewController = LoggedOutViewController()
        let interactor = LoggedOutInteractor(presenter: viewController)
        interactor.listener = listener
        return LoggedOutRouter(interactor: interactor, viewController: viewController)
    }
}
