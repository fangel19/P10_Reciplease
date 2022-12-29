//
//  UIViewExtension.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 27/12/2022.
//

import Foundation
import UIKit

extension UIView{
    
    // MARK: methods to add Gradient Layer
    
    func addBlackGradient(frame: CGRect, colors:[UIColor]){
        
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.colors = colors.map{$0.cgColor}
        gradient.locations = [0.5,1]
        self.layer.sublayers?.removeAll()
        gradient.removeFromSuperlayer()
        self.layer.insertSublayer(gradient, at: 0)
    }
}
