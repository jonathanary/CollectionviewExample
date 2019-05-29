//
//  BookCollectionVCDataSource.swift
//  StorytelChallenge
//
//  Created by Jonathan on 2019. 05. 20..
//  Copyright © 2019. Jonathan. All rights reserved.
//

import UIKit

extension BookCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        if elementKind == UICollectionView.elementKindSectionFooter {
            
            if let loadingView = view.viewWithTag(-29) as? UIActivityIndicatorView {
                
                if books.count > 0 && nextPage != "0" {
                    loadingView.startAnimating()
                    self.loadPage(from: nextPage)
                    
                } else {
                    return
                }
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        
        if elementKind == UICollectionView.elementKindSectionFooter {
            
            if let loadingView = view.viewWithTag(-29) as? UIActivityIndicatorView {
                loadingView.stopAnimating()
                loadingView.removeFromSuperview()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.identifier, for: indexPath) as? BookCell else {
            fatalError("Unable to dequeue BookCell.")
        }
        
        var authorCounter = 0
        var narratorCounter = 0
        cell.titleLabel.text = books[indexPath.item].title
        
        if let authors = books[indexPath.item].authors {
            for author in authors {
                authorCounter += 1
                
                if authorCounter == 1 {
                    cell.authorsLabel.text = "By: \(author.name!)"
                    
                } else {
                    cell.authorsLabel.text = "\(cell.authorsLabel.text!), \(author.name!)"
                }
            }
        }
        
        if let narrators = books[indexPath.item].narrators {
            
            for narrator in narrators {
                narratorCounter += 1
                
                if narratorCounter == 1 {
                    cell.narratorsLabel.text = "With: \(narrator.name!)"
                    
                } else if narratorCounter > 1 {
                    cell.narratorsLabel.text = "\(cell.narratorsLabel.text!), \(narrator.name!)"
                }
            }
        }
        let image = imageTasks[indexPath.row]?.image
        cell.set(image: image)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageTasks[indexPath.row]?.resume()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageTasks[indexPath.row]?.pause()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        headerView?.animator.fractionComplete = abs(contentOffsetY)/100
    }
}
