//
//  CatServiceLayer.swift
//  RandomCat
//
//  Created by sai sitaram on 07/02/25.
//

import Foundation

// MARK: - Protocols
protocol CatsInfoServiceLayerDelegate: AnyObject{
    func responseOfRandomCatQuotes(data: [CatModel]?)
}

class CatsInfoServiceLayer {
    
    weak var delegate:CatsInfoServiceLayerDelegate?
    
    // MARK: - API Call
    func getRandomCatQuotes() {
               
        guard let requestUrl = URL(string: UrlStrings.catQuotesURL) else { return }
        APIWapperClass.shared.getCall(url: RequestURL(url:requestUrl), [CatModel].self, nil) { [self] result in
            switch result {
            case .success(let model):
                delegate?.responseOfRandomCatQuotes(data: model)
            case .failure(let error):
                print(error)
            }
        }
    }
}
