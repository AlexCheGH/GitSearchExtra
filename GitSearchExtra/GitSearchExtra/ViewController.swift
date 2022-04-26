//
//  ViewController.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/25/22.
//

import UIKit
import Combine

class ViewController: UIViewController, Storyboarded {
    
    private let searchView = SearchRepoView()
    private let manager = SearchRepoManager()
    weak var coordinator: MainCoordinator?
    
    private var subscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchRepoView()
        setupSubscriber()
    }
    
    private func setupSubscriber() {
        subscriber = manager.modelPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { model in
                guard let model = model else { return }
                self.searchView.updateModel(model: model)
            })
    }
    
    private func configureSearchRepoView() {
        searchView.setupView()
        searchView.delegate = self
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

extension ViewController: SearchRepoViewDelegate {
    func didEnterQuerry(text: String) {
        manager.loadSearchResults(matching: text, pageNumber: 1)
    }
    
    func cellAppeared(index: Int) {
        manager.loadAvatar(for: index) {
            DispatchQueue.main.async {
                self.searchView.updateCell(at: index)
            }
        }
    }
    
    func cellTapped(index: Int) {
        print("cell tapped: \(index)")
    }
    
    func loadMoreCells() {
        manager.getMoreEntries()
    }
    
    
}
