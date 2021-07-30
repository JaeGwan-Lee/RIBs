//
//  OffGameBuilder.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/22.
//

import RIBs

protocol OffGameDependency: Dependency {
    // @ 2-23
    var player1Name: String { get }
    var player2Name: String { get }
    // @ 4-17
    var countStream: CountStream { get }
}

final class OffGameComponent: Component<OffGameDependency> {
    // @ 2-24
    fileprivate var player1Name: String {
        return dependency.player1Name
    }

    fileprivate var player2Name: String {
        return dependency.player2Name
    }
    
    // @ 4-18
    fileprivate var countStream: CountStream {
        return dependency.countStream
    }
}

// MARK: - Builder
protocol OffGameBuildable: Buildable {
    func build(withListener listener: OffGameListener) -> OffGameRouting
}

final class OffGameBuilder: Builder<OffGameDependency>, OffGameBuildable {
    override init(dependency: OffGameDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OffGameListener) -> OffGameRouting {
        let component = OffGameComponent(dependency: dependency)
        // @ 2-27
        let viewController = OffGameViewController(player1Name: component.player1Name,
                                                   player2Name: component.player2Name)
        // @ 4-19
        let interactor = OffGameInteractor(presenter: viewController,
                                           countStream: component.countStream)
        interactor.listener = listener
        return OffGameRouter(interactor: interactor, viewController: viewController)
    }
}
