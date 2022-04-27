//
//  StreatchyHeaderView.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/27/22.
//

import UIKit

class StreatchyTableHeaderView: UIView {
    
    var imageViewHeight = NSLayoutConstraint()
    var imageViewBottom = NSLayoutConstraint()
    
    var containerView: UIView!
    var imageView: UIImageView!
    
    private var stackView = UIStackView()
    private var repoByLabel = UILabel()
    private var authorNameLabel = UILabel()
    private var starsStackView = UIStackView()
    private var starImageView = UIImageView()
    private var starsNumberLabel = UILabel()
    
    var containerViewHeight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createViews() {
        // Container View
        containerView = UIView()
        self.addSubview(containerView)
        
        // ImageView for background
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)
        
        containerView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.addSubview(repoByLabel)
        stackView.addSubview(authorNameLabel)
        stackView.addSubview(starsStackView)
        
        starsStackView.axis = .horizontal
        starsStackView.addSubview(starImageView)
        starImageView.addSubview(starsNumberLabel)
        
    }
    
    func setupElements(authorName: String, starsNumber: String, avatarImage: UIImage?) {
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
        
        
    }
    
    func setViewConstraints() {
        // UIView Constraints
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            self.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        // Container View Constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        // ImageView Constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -105),
        ])
        
        repoByLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            repoByLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            repoByLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            repoByLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: repoByLabel.bottomAnchor, constant: 4),
            authorNameLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
        ])
        
        starsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starsStackView.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 6),
            starsStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor)
        ])
        
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starImageView.topAnchor.constraint(equalTo: starsStackView.topAnchor, constant: 2),
            starImageView.leadingAnchor.constraint(equalTo: starImageView.leadingAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 13),
            starImageView.heightAnchor.constraint(equalToConstant: 13)
        ])
        
        starsNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starsNumberLabel.topAnchor.constraint(equalTo: starsStackView.topAnchor),
            starsNumberLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 5),
            starsNumberLabel.bottomAnchor.constraint(equalTo: starsStackView.bottomAnchor)
        ])
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
}
