//
//  CommitsTableViewCell.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/27/22.
//

import UIKit

class CommitsTableViewCell: UITableViewCell {

    static let identifier = "CommitsTableViewCell"
    
    private let container = UIView()
    private let circleView = UIView()
    private let cellNumberLabel = UILabel()
    
    private let stackView = UIStackView()
    private let authorNameLabel = UILabel()
    private let emailLabel = UILabel()
    private let commentaryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCurrent()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCurrent() {
        
        self.addSubview(container)
        container.addSubview(circleView)
        container.addSubview(stackView)
        
        circleView.addSubview(cellNumberLabel)
        circleView.layer.cornerRadius = 18
        circleView.layer.masksToBounds = true
        circleView.clipsToBounds = true
        circleView.backgroundColor = Color.lightGray
        
        stackView.axis = .vertical
        stackView.addArrangedSubview(authorNameLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(commentaryLabel)
        
    }
    
    func setupCell(cellNumber: Int, authorName: String?, authorEmail: String?, commentary: String?) {
        cellNumberLabel.font = .systemFont(ofSize: 17, weight: .medium)
        cellNumberLabel.text = String(cellNumber)
        
        authorNameLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        authorNameLabel.text = authorName
        authorNameLabel.textColor = Color.blue
        
        emailLabel.font = .systemFont(ofSize: 17, weight: .regular)
        emailLabel.text = authorEmail
       
        commentaryLabel.font = .systemFont(ofSize: 17, weight: .regular)
        commentaryLabel.text = commentary
        commentaryLabel.textColor = Color.warmGray
        commentaryLabel.numberOfLines = 0
    }
    
    func applyConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: container.topAnchor, constant: 26),
            circleView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            circleView.widthAnchor.constraint(equalToConstant: 36),
            circleView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        cellNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellNumberLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            cellNumberLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        
    }

}
