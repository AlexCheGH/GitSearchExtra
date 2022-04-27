//
//  CommitsHistoryViewController.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/27/22.
//

import UIKit
import Combine

class CommitsHistoryViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    var searchModel: SearchModel?
    
    let commitHistoryView = CommitHistoryView()
    private var manager: CommitsHistoryManager?
    private var subscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(commitHistoryView)
        commitHistoryView.delegate = self
        
        manager = CommitsHistoryManager(searchModel: searchModel)
        setupSubscriber()
        manager?.loadCommitHistory()
        applyConstraints()
    }
    
    private func applyConstraints() {
        let margins = view.layoutMarginsGuide
        
        commitHistoryView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commitHistoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commitHistoryView.topAnchor.constraint(equalTo: view.topAnchor),
            commitHistoryView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            commitHistoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupSubscriber() {
        subscriber = manager?.commitHistoryModelPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { commitsHistory in
                guard let commitsHistory = commitsHistory, let searchModel = self.searchModel else { return }
                
                self.commitHistoryView.setupView(commitsModel: commitsHistory, repoSearchModel: searchModel)
                self.commitHistoryView.tableView.reloadData()
            })
    }
}

extension CommitsHistoryViewController: CommitHistoryViewDelegate {
    func openRepoExternaly(link: String?) {
        print(link)
    }
    
    func share() {
        print("sharing")
    }
    
    
}
