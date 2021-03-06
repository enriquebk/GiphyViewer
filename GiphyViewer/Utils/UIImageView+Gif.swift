//
//  UIImageView+Gif.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation
import UIKit
import SwiftyGif

extension UIImageView {
    
    func loadGif(from url: URL?, loopCount: Int = -1, showLoader: Bool = true) {
        
        self.setGifImage(UIImage())
        
        GifLoadTaskManager.shared.removeTask(for: self, cancelIfExists: true)
        
        if let task = self.loadGifTask(from: url, loopCount: loopCount, showLoader: showLoader) {
            GifLoadTaskManager.shared.setTask(task, for: self)
            task.resume()
        }
    }
    
    private func loadGifTask(from url: URL?, loopCount: Int = -1, showLoader: Bool = true) -> URLSessionDataTask? {
        
        guard let url = url else {
            print("Invalid Gif URL")
            return nil
        }
        
        subviews.forEach {
            if let activityIndicator  = $0 as? UIActivityIndicatorView {
                activityIndicator.removeFromSuperview()
            }
        }
        
        let loader = UIActivityIndicatorView()
        
        if showLoader {
            loader.style = .whiteLarge
            self.addSubview(loader)
            
            loader.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[subview]-0-|",
                options: .directionLeadingToTrailing,
                metrics: nil,
                views: ["subview": loader]))
            self.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[subview]-0-|",
                options: .directionLeadingToTrailing,
                metrics: nil,
                views: ["subview": loader]))
            loader.startAnimating()
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            DispatchQueue.main.async {
                loader.removeFromSuperview()
                if let data = data {
                    if let image = try? UIImage.init(gifData: data) {
                        self.setGifImage(image, manager: SwiftyGifManager.defaultManager, loopCount: loopCount)
                    }
                }
                
                GifLoadTaskManager.shared.removeTask(for: self)
            }
        }
        return task
    }
}

private class GifLoadTaskManager {
    
    static var shared = GifLoadTaskManager()
    
    private var loadingTasks: [Int: URLSessionDataTask] = [:]
    
    func setTask(_ task: URLSessionDataTask, for imageView: UIImageView) {
        self.loadingTasks[imageView.hash] = task
    }
    
    func removeTask(for imageView: UIImageView, cancelIfExists: Bool = false) {
        if cancelIfExists {
            self.loadingTasks[imageView.hash]?.cancel()
        }
        self.loadingTasks[imageView.hash] = nil
    }
}
