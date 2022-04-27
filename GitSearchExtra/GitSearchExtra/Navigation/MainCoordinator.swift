//
//  MainCoordinator.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/25/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func getCommitHistory(for entry: SearchModel) {
        let vc = CommitsHistoryViewController.instantiate()
        vc.coordinator = self
        vc.searchModel = entry
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openExternalLink(link: String?) {
        guard let link = link else { return }

        let alert = AlertViewController.externalLinkAlert(url: URL(string: link)!)
        navigationController.present(alert, animated: true, completion: nil)
    }
    
    func shareLink(link: String?) {
        guard let link = link else { return }
        let url = URL(string: link)!
        
        let activityViewController = UIActivityViewController(activityItems: [url],
                                     applicationActivities: nil)

        navigationController.present(activityViewController, animated: true)
    }
    
}
