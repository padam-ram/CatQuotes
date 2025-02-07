//
//  CatViewModel.swift
//  RandomCat
//
//  Created by sai sitaram on 07/02/25.
//

import Foundation
import UIKit

// MARK: - Protocols
protocol CatInfoViewModelDelegate {
    func CatDataDisplay(userInfoModel: [CatModel]?)
}


class CatsInfoViewModel:CatsInfoServiceLayerDelegate {
   
    var serviceLayer: CatsInfoServiceLayer = CatsInfoServiceLayer()
    var delegate: CatInfoViewModelDelegate? = nil
    
    func getCatsQuotesData(){
        self.serviceLayer.delegate = self
        self.serviceLayer.getRandomCatQuotes()
    }
    
    func responseOfRandomCatQuotes(data: [CatModel]?) {
        delegate?.CatDataDisplay(userInfoModel: data)
    }
    
}
