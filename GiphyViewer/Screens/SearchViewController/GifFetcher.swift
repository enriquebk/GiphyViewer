//
//  GIFFetcher.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation

protocol GifFetcherDelegate: AnyObject {
    
    func fetcher(_ fetcher: GifFetcher, didFinishLoadingPage gifs: [GIF]?)
    
    func fetcher(_ fetcher: GifFetcher, didFinishSearching gifs: [GIF]?)
    
    func fetcher(_ fetcher: GifFetcher, didFailWithError: Error)
}

class GifFetcher {
    
    private enum FetchType {
        case search
        case loadPage
    }
    
    weak var delegate: GifFetcherDelegate?
    
    private var apiClient = APIClient()
    private var page = 0
    private var pageSize = 20
    private var searchText = ""
    private var fetchGifRequest: CancelableRequest?
    
    private func fetchGifs(_ type: FetchType) {
        
        self.fetchGifRequest?.cancel()
        
        self.fetchGifRequest = self.apiClient.searchGIFs(with: self.searchText,
                                                         limit: self.pageSize,
                                                         offset: self.page * self.pageSize) { [weak self](gifs, error) in
                                                            
                                                            guard let strongSelf = self else {
                                                                return
                                                            }
                                                            
                                                            if let error = error {
                                                                strongSelf.delegate?.fetcher(strongSelf, didFailWithError: error)
                                                            } else {
                                                                switch type {     
                                                                case .search:
                                                                    strongSelf.delegate?.fetcher(strongSelf, didFinishSearching: gifs)
                                                                case .loadPage:
                                                                    strongSelf.delegate?.fetcher(strongSelf, didFinishLoadingPage: gifs)
                                                                }
                                                            }
        }
    }
    
    func loadNewPage() {
        self.page += 1
        self.fetchGifs(.loadPage)
    }
    
    func search(query: String) {
        self.page = 0
        self.searchText = query
        self.fetchGifs(.search)
    }
}