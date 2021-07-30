//
//  RootViewController.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/21.
//

import RIBs
import RxSwift
import UIKit

// 뷰 콘트롤러와 interactor 클래스와의 소통 프로토콜.
protocol RootPresentableListener: AnyObject {
    
}

// RootPresentable와 RootViewControllable 프로토콜을 받는다.
final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    // 뷰 콘트롤러와 interactor 클래스와의 소통 프로토콜 변수.
    weak var listener: RootPresentableListener?
    
    // @ 1-6
    func present(viewController: ViewControllable) {
        viewController.uiviewController.modalPresentationStyle = .fullScreen
        self.present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    // @ 2-7-1
    func dismiss(viewController: ViewControllable) {
        if presentedViewController === viewController.uiviewController {
            dismiss(animated: true, completion: nil)
        }
    }
}

// @ 2-16
extension RootViewController: LoggedInViewControllable {

}


