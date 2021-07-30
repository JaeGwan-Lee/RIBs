//
//  AppComponent.swift
//  RIBsExample
//
//  Created by imform-mm-2103 on 2021/07/21.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
}
