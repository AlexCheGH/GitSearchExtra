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
    
    var imageViewHeight = NSLayoutConstraint()
    var imageViewBottom = NSLayoutConstraint()
    
    var containerView: UIView!
    var imageView: UIImageView!
    
    private var labelsContainer = UIView()
    private var repoByLabel = UILabel()
    private var authorNameLabel = UILabel()
    private var starsContainer = UIView()
    private var starImageView = UIImageView()
    private var starsNumberLabel = UILabel()
    
    private var actionStackView = UIStackView()
    private var repoTitleLabel = UILabel()
    private var viewOnlineButton = UIButton()
    
    var containerViewHeight = NSLayoutConstraint()
    
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
    
    func createViews() {
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

        actionStackView.axis = .horizontal
        actionStackView.addArrangedSubview(repoTitleLabel)
        actionStackView.addArrangedSubview(viewOnlineButton)
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
        
        
        labelsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelsContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            labelsContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -105),
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
            actionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            actionStackView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            actionStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -48)
        ])
        
        viewOnlineButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewOnlineButton.widthAnchor.constraint(equalToConstant: 120)

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
