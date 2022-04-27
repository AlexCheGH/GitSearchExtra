//
//  CommitHistoryView.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/27/22.
//

import UIKit

protocol CommitHistoryViewDelegate {
    
}

class CommitHistoryView: UIView {
    
    var model: [CommitsHistory] = []
    
    let headerView = StreatchyTableHeaderView()
    let tableView = UITableView()
    let sharingButton = UIButton()
    
    
    func setupView(commitsModel: [CommitsHistory], repoSearchModel: SearchModel) {
        self.model = commitsModel
        
        headerView.setupElements(authorName: repoSearchModel.authorName ?? Localization.Label.notAvailable,
                                 starsNumber: String(repoSearchModel.repoStars ?? 0),
                                 avatarImage: repoSearchModel.avatarImage,
                                 repoTitle: repoSearchModel.repoTitle,
                                 repoLink: repoSearchModel.repoLink)
        
        self.addSubview(headerView)
        self.addSubview(tableView)
        self.addSubview(sharingButton)
        
        setupTableView()
        setupSharingButton()
        applyConstraints()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommitsTableViewCell.self, forCellReuseIdentifier: CommitsTableViewCell.identifier)
    }
    
    private func setupSharingButton() {
        let image = UIImage(named: "shareIcon")
        sharingButton.setImage(image, for: .normal)
        sharingButton.imageEdgeInsets.left = -15
        
        sharingButton.setTitle(Localization.Button.shareRepo, for: .normal)
        sharingButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        sharingButton.backgroundColor = Color.greybase
        sharingButton.setTitleColor(Color.blue, for: .normal)
        sharingButton.layer.cornerRadius = 10
    }
    
    
    private func applyConstraints() {
        
        sharingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sharingButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            sharingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            sharingButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            sharingButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.widthAnchor.constraint(equalToConstant: self.bounds.width)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: sharingButton.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

extension CommitHistoryView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommitsTableViewCell.identifier) as! CommitsTableViewCell
        cell.setupCell(cellNumber: indexPath.row + 1,
                       authorName: model[indexPath.row].author,
                       authorEmail: model[indexPath.row].email,
                       commentary: model[indexPath.row].description)
        
        
        return cell
    }
    
    
}

