//
//  StreatchyHeaderView.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/27/22.
//

import UIKit

protocol StreatchyTableHeaderViewDelegate {
    func viewOnline(link: String?)
}

class StreatchyTableHeaderView: UIView {
    
    private var containerView: UIView!
    private var imageView: UIImageView!
    
    private var labelsContainer = UIView()
    private var repoByLabel = UILabel()
    private var authorNameLabel = UILabel()
    private var starsContainer = UIView()
    private var starImageView = UIImageView()
    private var starsNumberLabel = UILabel()
    
    private var actionStackView = UIView()
    private var repoTitleLabel = UILabel()
    private var viewOnlineButton = UIButton()
    
    var delegate: StreatchyTableHeaderViewDelegate?
    var link: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   private func createViews() {
        // Container View
        containerView = UIView()
        self.addSubview(containerView)
        
        // ImageView for background
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)
        
        containerView.addSubview(labelsContainer)
        
        
        labelsContainer.addSubview(repoByLabel)
        labelsContainer.addSubview(authorNameLabel)
        labelsContainer.addSubview(starsContainer)
        
        
        starsContainer.addSubview(starImageView)
        starImageView.addSubview(starsNumberLabel)
        
        containerView.addSubview(actionStackView)
        
        
        actionStackView.addSubview(repoTitleLabel)
        self.addSubview(viewOnlineButton) // otherwise is untapable
        actionStackView.backgroundColor = .white
    }
    
    func setupElements(authorName: String, starsNumber: String, avatarImage: UIImage?, repoTitle: String?, repoLink: String?) {
        link = repoLink
        
        repoByLabel.text = Localization.Label.repoBy
        repoByLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        repoByLabel.textColor = Color.white
        repoByLabel.layer.opacity = 0.6
        
        authorNameLabel.text = authorName
        authorNameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        authorNameLabel.textColor = Color.white
        
        
        let text = String(format: Localization.Texts.nummberOfStars, starsNumber)
        starsNumberLabel.text = text
        starsNumberLabel.font = .systemFont(ofSize: 13, weight: .regular)
        starsNumberLabel.textColor = Color.white
        starsNumberLabel.layer.opacity = 0.5
        
        let image = UIImage(named: "starIcon")
        starImageView.image = image
        
        imageView.image = avatarImage
        
        repoTitleLabel.text = repoTitle
        repoTitleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        repoTitleLabel.numberOfLines = 0
        
        viewOnlineButton.setTitle(Localization.Button.viewOnline, for: .normal)
        viewOnlineButton.layer.cornerRadius = 17
        viewOnlineButton.backgroundColor = Color.greybase
        viewOnlineButton.setTitleColor(Color.blue, for: .normal)
        viewOnlineButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        viewOnlineButton.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
    }
    
    @objc private func onButtonTap() {
        delegate?.viewOnline(link: link)
    }
    
   private func setViewConstraints() {
        // Container View Constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // ImageView Constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            
        ])
        
        
        labelsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelsContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            labelsContainer.topAnchor.constraint(equalTo: actionStackView.topAnchor, constant: -105),
        ])
        
        repoByLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            repoByLabel.topAnchor.constraint(equalTo: labelsContainer.topAnchor),
            repoByLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor),
            repoByLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor)
        ])
        
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: repoByLabel.bottomAnchor, constant: 4),
            authorNameLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor),
        ])
        
        starsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starsContainer.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 6),
            starsContainer.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor)
        ])
        
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starImageView.topAnchor.constraint(equalTo: starsContainer.topAnchor, constant: 2),
            starImageView.leadingAnchor.constraint(equalTo: starImageView.leadingAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 13),
            starImageView.heightAnchor.constraint(equalToConstant: 13)
        ])
        
        starsNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starsNumberLabel.topAnchor.constraint(equalTo: starsContainer.topAnchor),
            starsNumberLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 5),
            starsNumberLabel.bottomAnchor.constraint(equalTo: starsContainer.bottomAnchor)
        ])
        
        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            actionStackView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            actionStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            actionStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        
        
        repoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            repoTitleLabel.centerYAnchor.constraint(equalTo: actionStackView.centerYAnchor),
            repoTitleLabel.leadingAnchor.constraint(equalTo: actionStackView.leadingAnchor, constant: 20)
        ])
        
        viewOnlineButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewOnlineButton.centerYAnchor.constraint(equalTo: actionStackView.centerYAnchor),
            viewOnlineButton.trailingAnchor.constraint(equalTo: actionStackView.trailingAnchor, constant: -20),
            viewOnlineButton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        
        
    }
    
    
}
