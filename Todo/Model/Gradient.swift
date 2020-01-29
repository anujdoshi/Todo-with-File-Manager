//
//  Gradient.swift
//  Todo
//
//  Created by Anuj Doshi on 29/01/20.
//  Copyright © 2020 Anuj Doshi. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    
    func gradientSetColor(colorOne:UIColor,colorTwo:UIColor){
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [colorOne.cgColor,colorTwo.cgColor]
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradient,at:0)
    }
    
}
