//
//  ViewController.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/25/22.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    private let searchView = SearchRepoView()
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchRepoView()
        
    }
    
    private func configureSearchRepoView() {
        searchView.setupView()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchView)
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor), //built for portrait mode only
            searchView.topAnchor.constraint(equalTo: margins.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor) //built for portrait mode only
        ])
    }
}

