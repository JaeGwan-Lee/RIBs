//
//  CountStream.swift
//  FirstRIBs
//
//  Created by imform-mm-2103 on 2021/07/29.
//

import Foundation
import RxSwift
import RxCocoa

struct Count {
    let player1Count: Int
    let player2Count: Int
}

protocol CountStream: AnyObject {
    var count: BehaviorSubject<Count> { get }
}

protocol MutableCountStream: CountStream {
    func updateCount(playerType: PlayerType)
}

class CountStreamClass: MutableCountStream {
    
    var behaviorSubject = BehaviorSubject(value: Count(player1Count: 0, player2Count: 0))
    
    var count: BehaviorSubject<Count> {
        return behaviorSubject
    }
    
    func updateCount(playerType: PlayerType) {
        let newScore: Count = {
            var a = 0
            var b = 0
            let currentScore = behaviorSubject.value
            try! a = currentScore().player1Count
            try! b = currentScore().player2Count
            switch playerType {
            case .player1:
                return Count(player1Count: a + 1, player2Count: b)
            case .player2:
                return Count(player1Count: a, player2Count: b + 1)
            }
        }()
        
        behaviorSubject.on(.next(newScore))
    }
    
}
