//
//  HeaderView.swift
//  StorytelChallenge
//
//  Created by Jonathan on 2019. 05. 15..
//  Copyright © 2019. Jonathan. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "cover-1"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let queryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray
        addSubview(imageView)
        imageView.fillSuperview()
        addSubview(queryLabel)
        queryLabel.layer.zPosition = 1
        queryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        queryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        queryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        setupBlur()
        setupGradientLayer()
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.gray.cgColor]
        gradientLayer.locations = [0.6, 1]
        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        gradientContainerView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        gradientContainerView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.bounds
        gradientLayer.frame.origin.y -= bounds.height
    }
    
    var animator: UIViewPropertyAnimator!
    
    fileprivate func setupBlur() {
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear, animations: { [weak self] in
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            self?.addSubview(visualEffectView)
            visualEffectView.fillSuperview()
        })
        animator.fractionComplete = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
