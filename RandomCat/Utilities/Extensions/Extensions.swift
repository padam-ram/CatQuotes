//
//  Extensions.swift
//  RandomCat
//
//  Created by sai sitaram on 07/02/25.
//

import Foundation
import UIKit

extension UIView {
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 40, width: self.frame.size.width , height: 30))
        toastLabel.backgroundColor = .darkGray
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 12.0)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.clipsToBounds  =  true
        self.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 3, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

class Utility{
    class func classNameAsString(_ obj: Any) -> String {
        return String(describing: obj)
    }
}

