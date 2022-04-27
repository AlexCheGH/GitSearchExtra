//
//  AlertViewController.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/27/22.
//

import Foundation
import UIKit


class AlertViewController {
    
    static func externalLinkAlert(url: URL) -> UIAlertController {
        let localization = Localization.self
        
        let open = localization.Button.open
        let cancel = localization.Button.cancel
        let prompt = localization.AlertPrompt.externalLink
        let title = localization.Label.alert
        
        let alert = UIAlertController(title: title, message: prompt, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: open, style: .default,
                                      handler: {action in
            UIApplication.shared.open(url)
        }))
        alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
        
        
        return alert
        
    }
    
}
