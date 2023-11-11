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
    func typeAValidateNumber()
}

class PrincipalViewModel {
    
    weak var delegate: PrincipalViewModelDelegate?
    let messengerFromModel = PrincipalModel()
    
    let limitedNumberOfTaps: Int = 3
    var numberOfTaps: Int = 0
    var randomNumber = Int.random(in: 0...10)
    var numberValue: String?
    
    
    func setNumberValue(value: String?) {
        self.numberValue = value
    }

    func onLoadResult(){
  
        guard let numberValue = Int(numberValue!), numberValue <= 10 else{
            delegate?.typeAValidateNumber()
            print(numberOfTaps)
            return
        }
        
        if numberValue == randomNumber  {
            delegate?.resultIsTrue(messenger: messengerFromModel.resultIsTrueMessenger)
            delegate?.typeAgain(messenger: messengerFromModel.typeAgainMessenger)
            numberOfTaps = 0
            randomNumber = Int.random(in: 0...10)
            
        } else if numberValue > randomNumber && numberOfTaps < 3 {
            delegate?.resultIsLower(messenger: messengerFromModel.resultIsLowerMessenger)
            delegate?.typeAgain(messenger: messengerFromModel.typeAgainMessenger)
            numberOfTaps += 1
            
        } else if numberValue < randomNumber && numberOfTaps < 3 {
            delegate?.resultIsHigher(messenger: messengerFromModel.resultIsHigherMessenger)
            delegate?.typeAgain(messenger: messengerFromModel.typeAgainMessenger)
            numberOfTaps += 1
        }
        
        print(numberOfTaps)
    }
    
    func onLoadAttempLimited(){
        if  limitedNumberOfTaps == numberOfTaps {
            delegate?.attemptLimit(messenger: messengerFromModel.attemptLimitMessenger)
            delegate?.typeAgain(messenger: messengerFromModel.typeAgainMessenger)
            numberOfTaps = 0
            randomNumber = Int.random(in: 0...10)
        }
    }
}
