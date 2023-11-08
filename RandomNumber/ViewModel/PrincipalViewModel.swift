//
//  PrincipalViewModel.swift
//  RandomNumber
//
//  Created by mateusdias on 06/11/23.
//

import Foundation

protocol PrincipalViewModelDelegate: AnyObject {
    func resultIsTrue(messenger: String)
    func resultIsLower(messenger: String)
    func resultIsHigher(messenger: String)
    func attemptLimit(messenger: String)
    func typeAgain(messenger: String)
    func playAgain()
}

class PrincipalViewModel {
    
    weak var delegate: PrincipalViewModelDelegate?
    let messengerFromModel = PrincipalModel()
    
    let limitedNumberOfTapped: Int = 3
    var numberOfTaps: Int = 0
    var randomNumber = Int.random(in: 0...10)

    func onLoadResult(numberValue: String){
        
        guard let numberValue = Int(numberValue) else {return}
        
        if numberValue == randomNumber {
            delegate?.resultIsTrue(messenger: messengerFromModel.resultIsTrueMessenger)
            delegate?.typeAgain(messenger: messengerFromModel.typeAgainMessenger)
            delegate?.playAgain()
        } else if numberValue > randomNumber && numberOfTaps <= 3 {
            delegate?.resultIsLower(messenger: messengerFromModel.resultIsLowerMessenger)
            delegate?.typeAgain(messenger: messengerFromModel.typeAgainMessenger)
        } else if numberValue < randomNumber && numberOfTaps <= 3 {
            delegate?.resultIsHigher(messenger: messengerFromModel.resultIsHigherMessenger)
            delegate?.typeAgain(messenger: messengerFromModel.typeAgainMessenger)
        }
    }
    
    func onLoadAttempLimited(limitedNumberOfTapped: Int){
        self.numberOfTaps = limitedNumberOfTapped
        if self.limitedNumberOfTapped == numberOfTaps {
            delegate?.attemptLimit(messenger: messengerFromModel.attemptLimitMessenger)
            delegate?.typeAgain(messenger: messengerFromModel.typeAgainMessenger)
            delegate?.playAgain()
        }
    }
    
}
