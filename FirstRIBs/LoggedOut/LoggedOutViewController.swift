//
//  LoggedOutViewController.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/21.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import RxCocoa

protocol LoggedOutPresentableListener: AnyObject {
    // @ 2-1 plyerName을 Login RIB -> OffGame Rib
    func login(withPlayer1Name player1Name: String?, player2Name: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    // ViewController와 interactor 클래스와의 소통 프로토콜 변수.
    weak var listener: LoggedOutPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let playerFields = buildPlayerFields()
        buildLoginButton(withPlayer1Field: playerFields.player1Field, player2Field: playerFields.player2Field)
    }
    let loginButton = UIButton()
    var disposeBag = DisposeBag()
    
    private var player1Field: UITextField?
    private var player2Field: UITextField?

    private func buildPlayerFields() -> (player1Field: UITextField, player2Field: UITextField) {
        let player1Field = UITextField()
        self.player1Field = player1Field
        player1Field.borderStyle = UITextField.BorderStyle.line
        view.addSubview(player1Field)
        player1Field.placeholder = "Player 1 name"
        player1Field.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(100)
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(40)
        }

        let player2Field = UITextField()
        self.player2Field = player2Field
        player2Field.borderStyle = UITextField.BorderStyle.line
        view.addSubview(player2Field)
        player2Field.placeholder = "Player 2 name"
        player2Field.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(player1Field.snp.bottom).offset(20)
            maker.left.right.height.equalTo(player1Field)
        }

        return (player1Field, player2Field)
    }

    
    
    private func buildLoginButton(withPlayer1Field player1Field: UITextField, player2Field: UITextField) {
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(player2Field.snp.bottom).offset(20)
            maker.left.right.height.equalTo(player1Field)
        }
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = UIColor.black
        loginButton.rx.tap.bind{ [weak self] _ in
            guard let self = self else { return }
            // @ 2-2 : viewContorller -> Interactor
            self.listener?.login(withPlayer1Name: player1Field.text, player2Name: player2Field.text)
        }.disposed(by: disposeBag)
    }

 
}
