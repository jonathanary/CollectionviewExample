//
//  BookCell.swift
//  StorytelChallenge
//
//  Created by Jonathan on 2019. 05. 15..
//  Copyright © 2019. Jonathan. All rights reserved.
//

import UIKit

class BookCell: UICollectionViewCell {
    
    static var identifier: String {
        return NSStringFromClass(self)
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .gray)
        ai.color = .lightGray
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 8, y: 8, width: 100, height: 100)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let authorsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "By: "
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let narratorsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = ""
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func set(image: UIImage?) {
        imageView.image = image
        
        if image == nil {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    fileprivate func setupView() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        contentView.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        
        contentView.addSubview(authorsLabel)
        authorsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        authorsLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        authorsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        
        contentView.addSubview(narratorsLabel)
        narratorsLabel.topAnchor.constraint(equalTo: authorsLabel.bottomAnchor, constant: 8).isActive = true
        narratorsLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        narratorsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
        authorsLabel.text = "By: "
        narratorsLabel.text = ""
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
