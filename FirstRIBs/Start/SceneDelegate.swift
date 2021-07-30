//
//  SceneDelegate.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/21.
//

import UIKit
import RIBs

protocol UrlHandler: AnyObject {
    func handle(_ url: URL)
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var launchRouter: LaunchRouting?
    private var urlHandler: UrlHandler?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let result = RootBuilder(dependency: AppComponent()).build()
        launchRouter = result.launchRouter
        urlHandler = result.urlHandler
        launchRouter?.launch(from: window)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

