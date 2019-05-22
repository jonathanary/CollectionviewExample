//
//  FooterView.swift
//  StorytelChallenge
//
//  Created by Jonathan on 2019. 05. 16..
//  Copyright © 2019. Jonathan. All rights reserved.
//

import UIKit

class FooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
