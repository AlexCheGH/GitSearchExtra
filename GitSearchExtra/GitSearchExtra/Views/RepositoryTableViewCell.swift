//
//  RepositoryTableViewCell.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/26/22.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    private let backgroundContainer = UIView()
    private let avatarImageView = UIImageView()
    private let repoTitle = UILabel()
    private let metadataStackView = UIStackView()
    private let starsStackView = UIStackView()
    private let starsImageView = UIImageView()
    private let starsLabel = UILabel()
    private let rightButton = UIButton()
    private let rightArrowImageView = UIImageView()
    
    private let cornerRadius: CGFloat = 10
    private let standardPadding: CGFloat = 16
    
    static let identifier = "RepositoryTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(repoTitle: String?, image: UIImage?, stars: String?) {
        
        backgroundContainer.layer.cornerRadius = cornerRadius
        backgroundContainer.backgroundColor = Color.lightGray
        
        setupImageView(image: image)
        setupMetadataStackView(stars: stars, repoTitleText: repoTitle)
        
        metadataStackView.translatesAutoresizingMaskIntoConstraints = false
            
        self.addSubview(backgroundContainer)
        backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backgroundContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            backgroundContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            backgroundContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        backgroundContainer.addSubview(rightArrowImageView)
        setupRightArrow()
        rightArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightArrowImageView.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -standardPadding),
            rightArrowImageView.centerYAnchor.constraint(greaterThanOrEqualTo: backgroundContainer.centerYAnchor)
        ])
    }
    
    //MARK: RepoTitle, StarsStackView
    private func setupMetadataStackView(stars: String?, repoTitleText: String?) {
        backgroundContainer.addSubview(metadataStackView)
        metadataStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            metadataStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: standardPadding),
            metadataStackView.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: 26),
            metadataStackView.bottomAnchor.constraint(equalTo: backgroundContainer.bottomAnchor, constant: -26),
            metadataStackView.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -standardPadding)
        ])
        
        metadataStackView.axis = .vertical
        metadataStackView.addSubview(repoTitle)
        metadataStackView.addSubview(starsStackView)
        
        setupRepoTitleLabel(title: repoTitleText)
        
        repoTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            repoTitle.leadingAnchor.constraint(equalTo: metadataStackView.leadingAnchor),
            repoTitle.topAnchor.constraint(equalTo: metadataStackView.topAnchor),
            repoTitle.heightAnchor.constraint(equalToConstant: 20),
            repoTitle.trailingAnchor.constraint(equalTo: metadataStackView.trailingAnchor)
        
        ])
        
        setupStarsStackView(stars: stars)
        starsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starsStackView.leadingAnchor.constraint(equalTo: metadataStackView.leadingAnchor),
            starsStackView.topAnchor.constraint(equalTo: repoTitle.bottomAnchor, constant: 5),
            starsStackView.bottomAnchor.constraint(equalTo: metadataStackView.bottomAnchor),
            starsStackView.trailingAnchor.constraint(equalTo: metadataStackView.trailingAnchor)
        ])
    }
    
    //MARK: Stars Label, Star icon, Star StackView
    private func setupStarsStackView(stars: String?) {
        starsStackView.axis = .horizontal
        starsStackView.addSubview(starsImageView)
        starsStackView.addSubview(starsLabel)

        setupStarsImageView()
        setupStarsLabel(stars: stars)
        
        starsImageView.translatesAutoresizingMaskIntoConstraints = false
        starsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            starsImageView.leadingAnchor.constraint(equalTo: starsStackView.leadingAnchor),
            starsImageView.topAnchor.constraint(equalTo: starsStackView.topAnchor, constant: 3),
            starsImageView.heightAnchor.constraint(equalToConstant: 15),
            starsImageView.widthAnchor.constraint(equalToConstant: 15),
            starsLabel.leadingAnchor.constraint(equalTo: starsImageView.trailingAnchor, constant: 4),
            starsLabel.topAnchor.constraint(equalTo: starsStackView.topAnchor)
        ])
    }
    
    //MARK: AvatarImageView
    private func setupImageView(image: UIImage?) {
        backgroundContainer.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.layer.cornerRadius = cornerRadius
        avatarImageView.backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: standardPadding),
            avatarImageView.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: standardPadding)
            
        ])
        
        guard let image = image else { return }
        avatarImageView.image = image
    }
    
    //MARK: Repo title label
    private func setupRepoTitleLabel(title: String?) {
        repoTitle.text = title
        repoTitle.font = .systemFont(ofSize: 17, weight: .semibold)
    }
    
    //MARK: StarsLabel
    private func setupStarsLabel(stars: String?) {
        starsLabel.text = stars
        starsLabel.font = .systemFont(ofSize: 17, weight: .regular)
        starsLabel.textColor = Color.warmGray
    }
    
    //MARK: StarsImageView
    private func setupStarsImageView() {
        starsImageView.image = UIImage(systemName: "star")
        starsImageView.tintColor = Color.warmGray
    }
    
    //MARK: RightArrow imageview
    private func setupRightArrow() {
        let image = UIImage(systemName: "chevron.right")
        rightArrowImageView.image = image
        rightArrowImageView.tintColor = Color.warmGray
    }
    
}
