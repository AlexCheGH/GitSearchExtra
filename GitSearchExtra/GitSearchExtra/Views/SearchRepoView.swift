//
//  SearchRepoView.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/26/22.
//

import UIKit

protocol SearchRepoViewDelegate {
    func cellAppeared(index: Int)
    func cellTapped(index: Int)
    func loadMoreCells()
    func didEnterQuerry(text: String)
}

class SearchRepoView: UIView {
    
    var model = [SearchModel]()
    
    private let searchBar = TextFieldSearchView()
    private let tableView = UITableView()
    var delegate: SearchRepoViewDelegate?
        
    func setupView() {
        self.addSubview(searchBar)
        self.addSubview(tableView)
        
        searchBar.delegate = self
        
        searchBar.setupView()
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
    
    func updateModel(model: [SearchModel]) {
        self.model = model
        self.tableView.reloadData()
    }
    
    func updateCell(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: CustomHeaderView.identifier)
    }
}

extension SearchRepoView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.identifier) as! CustomHeaderView
        let text = Localization.Label.repository
        view.title.text = text
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier) as! RepositoryTableViewCell
        cell.setupCell(repoTitle: model[indexPath.row].repoTitle,
                       image: model[indexPath.row].avatarImage,
                       stars: String(model[indexPath.row].repoStars ?? 0))
        
        //Cell has been drawn, but lacks image. Requests manager to provide it with the image
        if model[indexPath.row].avatarImage == nil {
            delegate?.cellAppeared(index: indexPath.row)
        }
        
        if model.count - 15 == indexPath.row {
            delegate?.loadMoreCells()
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.cellTapped(index: indexPath.row)
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

extension SearchRepoView: TextFieldSearchViewDelegate {
    func returnQuery(text: String) {
        delegate?.didEnterQuerry(text: text)
    }
}
