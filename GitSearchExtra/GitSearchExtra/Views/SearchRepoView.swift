//
//  SearchRepoView.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/26/22.
//

import UIKit

class SearchRepoView: UIView {
    
    private var model = [SearchModel]()
    
    let searchBar = TextFieldSearchView().setupView()
    let tableView = UITableView()
    
    func setupView() {
        self.addSubview(searchBar)
        self.addSubview(tableView)
        
        configureTableView()
        
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: self.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 100),
            
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
        ])
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
    }
    
}

extension SearchRepoView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! CustomHeaderView
        let text = Localization.Label.repository
        view.title.text = text
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier) as! RepositoryTableViewCell
        cell.setupCell(repoTitle: "Repo", image: nil, stars: "123")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 10
        
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
}
