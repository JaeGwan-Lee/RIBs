//
//  CountGameViewController.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/28.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import Hero
import RxGesture

protocol CountGamePresentableListener: AnyObject {
    // @ 4-1
    func playerButtonClick(player1Name: String, player2Name: String, clickName: String)
}

final class CountGameViewController: UIViewController, CountGamePresentable, CountGameViewControllable {
   
    weak var listener: CountGamePresentableListener?
    
    // @ 3-15
    private let player2Name: String
    private let player1Name: String
    
    private let titleLabel = UILabel()
    private let player1Button = UIButton()
    private let player2Button = UIButton()
    var disposeBag = DisposeBag()
    
    // @ 3-16
    init(player1Name: String,
         player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        viewInit()
        rxBind()
    }
    
    func rxBind() {
        player1Button.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                // @ 4-2
                self.listener?.playerButtonClick(player1Name: self.player1Name, player2Name: self.player2Name, clickName: self.player1Name)
            })
            .disposed(by: disposeBag)
        
        player2Button.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                // @ 4-2
                self.listener?.playerButtonClick(player1Name: self.player1Name, player2Name: self.player2Name, clickName: self.player2Name)
            })
            .disposed(by: disposeBag)
    }
    
    // @ 4-5
    func showAlert(clickName: String, success: @escaping (() -> Void)) {
        let alert = UIAlertController(title: clickName, message: nil, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "닫기", style: UIAlertAction.Style.default) { _ in
            success()
        }
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
    func viewInit() {
        titleLabel.text = "버튼을 클릭하세요!"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize:40)
        
        player1Button.setTitle(player1Name, for: .normal)
        player1Button.setTitleColor(.white, for: .normal)
        player1Button.backgroundColor = .systemYellow
        player1Button.titleLabel?.font = .systemFont(ofSize: 30)
        
        player2Button.setTitle(player2Name, for: .normal)
        player2Button.setTitleColor(.white, for: .normal)
        player2Button.backgroundColor = .systemBlue
        player2Button.titleLabel?.font = .systemFont(ofSize: 30)
        
        view.addSubview(titleLabel)
        view.addSubview(player1Button)
        view.addSubview(player2Button)
        
        titleLabel.snp.makeConstraints { create in
            create.centerX.equalToSuperview()
            create.centerY.equalToSuperview().offset(-35.0.asPercent(with: .HEIGHT))
            create.width.equalTo(70.0.asPercent(with: .WIDTH))
            create.height.equalTo(10.0.asPercent(with: .HEIGHT))
        }
        
        player1Button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-15.0.asPercent(with: .HEIGHT))
            $0.width.equalTo(80.0.asPercent(with: .WIDTH))
            $0.height.equalTo(20.0.asPercent(with: .HEIGHT))
        }
        
        player2Button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(15.0.asPercent(with: .HEIGHT))
            $0.width.equalTo(80.0.asPercent(with: .WIDTH))
            $0.height.equalTo(20.0.asPercent(with: .HEIGHT))
        }
    }
}
