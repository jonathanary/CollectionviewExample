//
//  ImageTask.swift
//  StorytelChallenge
//
//  Created by Jonathan on 2019. 05. 19..
//  Copyright © 2019. Jonathan. All rights reserved.
//

import UIKit

class ImageTask {
    
    let position: Int
    let url: URL
    let session: URLSession
    let delegate: ImageTaskDownloadedDelegate
    var image: UIImage?
    private var task: URLSessionDownloadTask?
    private var resumeData: Data?
    private var cache: NSCache<AnyObject, AnyObject>?
    private var isDownloading = false
    private var isFinishedDownloading = false
    
    init(position: Int, cache: NSCache<AnyObject, AnyObject>?, url: URL, session: URLSession, delegate: ImageTaskDownloadedDelegate) {
        self.position = position
        self.url = url
        self.session = session
        self.delegate = delegate
        self.cache?.evictsObjectsWithDiscardedContent = false
    }
    
    func resume() {
        
        if !isDownloading && !isFinishedDownloading {
            isDownloading = true
            
            if let resumeData = resumeData {
                task = session.downloadTask(withResumeData: resumeData, completionHandler: downloadTaskCompletionHandler)
                
            } else {
                task = session.downloadTask(with: url, completionHandler: downloadTaskCompletionHandler)
            }
            task?.resume()
        }
    }
    
    func pause() {
        if isDownloading && !isFinishedDownloading {
            
            task?.cancel(byProducingResumeData: { (data) in
                self.resumeData = data
            })
            self.isDownloading = false
        }
    }
    
    private func downloadTaskCompletionHandler(url: URL?, response: URLResponse?, error: Error?) {
        if error != nil {
            return
        }
        guard let url = url else { return }
        guard let data = FileManager.default.contents(atPath: url.path) else { return }
        
        DispatchQueue.global(qos: .utility).async { [weak self] in
            let cachedImage: UIImage? = self?.cache?.object(forKey: url.path as NSString) as? UIImage
            
            if let goodImage = cachedImage {
                
                DispatchQueue.main.async {
                    self!.image = goodImage
                    self!.delegate.imageDownloaded(position: self!.position)
                }
            }
        }
        
        guard let image = UIImage(data: data) else { return }
        self.cache?.setObject(data as AnyObject, forKey: url.path as NSString)
        
        DispatchQueue.main.async { [weak self] in
            self?.image = image
            self?.delegate.imageDownloaded(position: self!.position)
        }
        self.isFinishedDownloading = true
    }
}
