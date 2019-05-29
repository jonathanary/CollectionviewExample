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
        return label
    }()
    
    let authorsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "By: "
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let narratorsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = ""
        label.textColor = UIColor.lightGray
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
        
        [imageView, activityIndicator, titleLabel, authorsLabel, narratorsLabel].forEach { self.addSubview($0) }
        
        activityIndicator.centerInView(view: imageView)
        titleLabel.anchor(top: self.topAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: -24))
        authorsLabel.anchor(top: titleLabel.bottomAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: -24))
        narratorsLabel.anchor(top: authorsLabel.bottomAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: -24))
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
        authorsLabel.text = ""
        narratorsLabel.text = ""
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
