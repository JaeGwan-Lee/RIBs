//
//  OffGameInteractor.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/22.
//

import RIBs
import RxSwift

protocol OffGameRouting: ViewableRouting {
    
}

protocol OffGamePresentable: Presentable {
    var listener: OffGamePresentableListener? { get set }
    
    // @ 2-32
    func yellowInteractorToVc(yellow: YellowFlower)
    func blueInteractorToVc(blue: BlueFlower)
    func set(count: Count)
}

protocol OffGameListener: AnyObject {
    // @ 3-4
    func goToGameRIB(player1Name: String, player2Name: String)
}

final class OffGameInteractor: PresentableInteractor<OffGamePresentable>, OffGameInteractable, OffGamePresentableListener {

    weak var router: OffGameRouting?
    weak var listener: OffGameListener?
    
    // @ 2-30
    private let networkManager = NetworkManager()
    private var yellowFlower: YellowFlower?
    private var blueFlower: BlueFlower?
    
    private let countStream: CountStream
    
    init(presenter: OffGamePresentable, countStream: CountStream) {
        self.countStream = countStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        getAPiData()
        updateCount()
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    // @ 2-31
    func getAPiData() {
        let yellowQuery = ["q":"yellow+flowers",
                           "image_type":"photo",
                           "pretty":"true"]
        networkManager.getYellowFlowers(query: yellowQuery) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let yellowFlower):
                self?.yellowFlower = yellowFlower
                self!.presenter.yellowInteractorToVc(yellow: yellowFlower)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let blueQuery = ["q":"blue+flowers",
                         "image_type":"photo",
                         "pretty":"true"]
        
        networkManager.getBlueFlowers(query: blueQuery) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let blueFlower):
                self!.presenter.blueInteractorToVc(blue: blueFlower)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // @ 3-2
    func goToGame(player1Name: String?, player2Name: String?) {
        // @ 3-5
        listener?.goToGameRIB(player1Name: player1Name!, player2Name: player2Name!)
    }
    
    // @ 4-11
    private func updateCount() {
        countStream.count
            .subscribe(onNext: { (count: Count) in
                self.presenter.set(count: count)
            })
            .disposeOnDeactivate(interactor: self)
    }
}
