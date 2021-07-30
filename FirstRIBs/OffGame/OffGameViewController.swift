//
//  OffGameViewController.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/22.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import RxCocoa
import RxGesture
import Hero

protocol OffGamePresentableListener: AnyObject {
    // @ 3-1
    func goToGame(player1Name: String?, player2Name: String?)
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
    
    weak var listener: OffGamePresentableListener?
    
    // @ 2-25
    private let player1Name: String
    private let player2Name: String
    
    // @ 2-28
    private var player1Label = UILabel()
    private var player2Label = UILabel()
    private var player1CountLabel = UILabel()
    private var player2CountLabel = UILabel()
    private var player1ImageView = UIImageView()
    private var player2ImageView = UIImageView()
    
    private var disposeBag = DisposeBag()
    
    // @ 4-12
    private var count: Count?

    // @ 2-26
    init(player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // @ 2-29
        player1ViewInit()
        player2ViewInit()
        rxBind()
        updateCount()
    }
    
    // @ 2-33
    func yellowInteractorToVc(yellow: YellowFlower) {
        let data = try! Data(contentsOf: URL(string: yellow.hits.first!.largeImageURL)!)
        self.player1ImageView.image = UIImage(data: data)
    }
    
    func blueInteractorToVc(blue: BlueFlower) {
        let data = try! Data(contentsOf: URL(string: blue.hits.first!.largeImageURL)!)
        self.player2ImageView.image = UIImage(data: data)
    }
    
    func rxBind() {
        player1ImageView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                // @ 3-3
                self.listener?.goToGame(player1Name: self.player1Name, player2Name: self.player2Name)
            })
            .disposed(by: disposeBag)
        
        player2ImageView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.listener?.goToGame(player1Name: self.player1Name, player2Name: self.player2Name)
            })
            .disposed(by: disposeBag)
    }
    
    // @ 4-13
    func set(count: Count) {
        self.count = count
    }
    
    // @ 4-14
    func updateCount() {
        let player1Count = count?.player1Count
        let player2Count = count?.player2Count
        
        player1CountLabel.text = "Click Count : \(player1Count ?? 0)"
        player2CountLabel.text = "Click Count : \(player2Count ?? 0)"
    }
    
    
    func player1ViewInit() {
        player1ImageView.hero.id = "player1ImageView"
        player1Label.text = player1Name
        player1Label.textAlignment = .center
//        player1CountLabel.text = "Click Count : 0"
        player1CountLabel.textAlignment = .center
        view.addSubview(player1Label)
        view.addSubview(player1ImageView)
        view.addSubview(player1CountLabel)
        
        player1Label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.width.equalTo(80.0.asPercent(with: .WIDTH))
            $0.height.equalTo(10.0.asPercent(with: .HEIGHT))
        }
        
        player1ImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(player1Label.snp.bottom)
            $0.width.height.equalTo(60.0.asPercent(with: .WIDTH))
        }
        
        player1CountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(player1ImageView.snp.bottom).offset(-3.0.asPercent(with: .HEIGHT))
            $0.width.equalTo(80.0.asPercent(with: .WIDTH))
            $0.height.equalTo(10.0.asPercent(with: .HEIGHT))
        }
    }
    
    func player2ViewInit() {
        player2Label.text = player2Name
        player2Label.textAlignment = .center
//        player2CountLabel.text = "Click Count : 0"
        player2CountLabel.textAlignment = .center
        
        view.addSubview(player2Label)
        view.addSubview(player2ImageView)
        view.addSubview(player2CountLabel)
        
        player2Label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(player1ImageView.snp.bottom).offset(5.0.asPercent(with: .HEIGHT))
            $0.width.equalTo(80.0.asPercent(with: .WIDTH))
            $0.height.equalTo(10.0.asPercent(with: .HEIGHT))
        }
        
        player2ImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(player2Label.snp.bottom)
            $0.width.height.equalTo(60.0.asPercent(with: .WIDTH))
        }
        
        player2CountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(player2ImageView.snp.bottom).offset(-3.0.asPercent(with: .HEIGHT))
            $0.width.equalTo(80.0.asPercent(with: .WIDTH))
            $0.height.equalTo(10.0.asPercent(with: .HEIGHT))
        }
        
    }

}

