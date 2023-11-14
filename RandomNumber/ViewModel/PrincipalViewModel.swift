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
    private var randomNumber = Int.random(in: 0...10)
    private var numberOfTaps: Int = 0
    
    func onLoadResult(value: String?){
        
        let messengerFromModel = PrincipalModel()
        
        guard let numberValue = Int(value!), numberValue <= 10 else{
            delegate?.typeAValidateNumber()
            print(numberOfTaps)
            return
        }
        
        if numberValue == randomNumber  {
            delegate?.resultIsTrue(messenger: messengerFromModel.resultIsTrueMessenger)
            delegate?.typeAgain(messenger: messengerFromModel.typeAgainMessenger)
            numberOfTaps = 0
            randomNumber = Int.random(in: 0...10)
        } else if numberOfTaps >= 2 {
            delegate?.attemptLimit(messenger: messengerFromModel.attemptLimitMessenger)
            delegate?.typeAgain(messenger: messengerFromModel.typeAgainMessenger)
            numberOfTaps = 0
            randomNumber = Int.random(in: 0...10)
        } else if numberValue < randomNumber  {
            delegate?.resultIsHigher(messenger: messengerFromModel.resultIsHigherMessenger)
            delegate?.typeAgain(messenger: messengerFromModel.typeAgainMessenger)
            numberOfTaps += 1
        } else {
            delegate?.resultIsLower(messenger: messengerFromModel.resultIsLowerMessenger)
            delegate?.typeAgain(messenger: messengerFromModel.typeAgainMessenger)
            numberOfTaps += 1
        }
        print(numberOfTaps)
    }
}
