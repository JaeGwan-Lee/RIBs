//
//  CountGameBuilder.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/28.
//

import RIBs

protocol CountGameDependency: Dependency {
    // @ 3-14
    var player1Name: String { get }
    var player2Name: String { get }
}

final class CountGameComponent: Component<CountGameDependency> {
    fileprivate var player1Name: String {
        return dependency.player1Name
    }

    fileprivate var player2Name: String {
        return dependency.player2Name
    }
}

// MARK: - Builder

protocol CountGameBuildable: Buildable {
    func build(withListener listener: CountGameListener) -> CountGameRouting
}

final class CountGameBuilder: Builder<CountGameDependency>, CountGameBuildable {

    override init(dependency: CountGameDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: CountGameListener) -> CountGameRouting {
        let component = CountGameComponent(dependency: dependency)
        // @ 3-17
        let viewController = CountGameViewController(player1Name: component.player1Name,
                                                     player2Name: component.player2Name)
        let interactor = CountGameInteractor(presenter: viewController)
        interactor.listener = listener
        return CountGameRouter(interactor: interactor, viewController: viewController)
    }
}
