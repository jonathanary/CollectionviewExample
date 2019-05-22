//
//  BookCollectionViewController.swift
//  StorytelChallenge
//
//  Created by Jonathan on 2019. 05. 15..
//  Copyright © 2019. Jonathan. All rights reserved.
//

import UIKit


class BookCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ImageTaskDownloadedDelegate {
    
    var query = "Harry"
    var books = [Item]()
    var authors = [Creatives]()
    var nextPage = "1"
    var inFetchingMode = false
    let padding: CGFloat = 16
    let headerId = "headerId"
    let footerId = "footerId"
    var headerView: HeaderView?
    var imageTasks = [Int: ImageTask]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupCollectionView()
        setupCollectionViewLayout()
        loadPage(from: nextPage)
    }
    
    func loadPage(from page: String) {
        inFetchingMode = true
        let urlString = "https://api.storytel.net/search?query=\(query)&page=\(page)"
        
        DispatchQueue.global().async {
            
            if let url = URL(string: urlString) {
                
                if let data = try? Data(contentsOf: url) {
                    
                    DispatchQueue.main.async { [weak self] in
                        self!.parse(json: data)
                    }
                }
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        let booksLoaded = try! decoder.decode(StoryTelDatabase.self, from: json)
        
        DispatchQueue.main.async { [weak self] in
            self!.nextPage = booksLoaded.nextPage ?? "0"
            
            if let items = booksLoaded.items {
                
                for item in items {
                    self!.books.append(item)
                }
                let pagesNr = (self?.books.count)!-1
                self!.setupImageTasks(withNumberOfImages: pagesNr)
                self?.collectionView.reloadData()
                self?.collectionView.setNeedsLayout()
                self?.collectionView.layoutIfNeeded()                
                self?.inFetchingMode = false
            }
        }
    }
    
    private func setupImageTasks(withNumberOfImages nr: Int) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        for i in 0...nr {
            let url = URL(string: (books[i].cover?.url ?? ""))!
            let imageTask = ImageTask(position: i, cache: nil, url: url, session: session, delegate: self)
            imageTasks[i] = imageTask
        }
    }
    
    func imageDownloaded(position: Int) {
        self.collectionView?.reloadItems(at: [IndexPath(row: position, section: 0)])
    }
}



