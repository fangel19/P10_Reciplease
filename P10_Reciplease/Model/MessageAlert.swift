//
//  MessageAlert.swift
//  P10_Reciplease
//
//  Created by angelique fourny on 27/12/2022.
//

import Foundation
import UIKit

class MessageAlert: UIViewController {
    
    //    MARK: - Alert message
    
    func alertMessage(title: String, message: String) {
        
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
