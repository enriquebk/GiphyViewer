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
    
    func fetcher(_ fetcher: GifFetcher, didFailWithError error: Error)
}

class GifFetcher {
    
    private enum FetchType {
        case search
        case loadPage
    }
    
    weak var delegate: GifFetcherDelegate?
    
    var apiClient = APIClient()
    private var page = 0
    private var pageSize = 20
    private var searchText = ""
    private var fetchGifRequest: CancelableRequest?
    
    private func fetchGifs(_ type: FetchType) {
        
        self.fetchGifRequest?.cancel()
        
        if searchText.count > 0 {
        
            self.fetchGifRequest = self.apiClient.searchGIFs(with: self.searchText,
                                                         limit: self.pageSize,
                                                         offset: self.page * self.pageSize) { [weak self](gifs, error) in
                                                            
                                                            guard let strongSelf = self else {
                                                                return
                                                            }
                                                            strongSelf.handleResponse(gifs: gifs, error: error, type: type)
            }
        } else {
            self.fetchGifRequest = self.apiClient.getTrendingGifs( limit: self.pageSize,
                                                                   offset: self.page * self.pageSize) { [weak self](gifs, error) in
                                                                
                                                                guard let strongSelf = self else {
                                                                    return
                                                                }
                                                                strongSelf.handleResponse(gifs: gifs, error: error, type: type)
            }
        }
    }
    
    private func handleResponse(gifs: [GIF]?, error: Error?, type: FetchType) {
        if let error = error {
            self.delegate?.fetcher(self, didFailWithError: error)
        } else {
            switch type {
            case .search:
                self.delegate?.fetcher(self, didFinishSearching: gifs)
            case .loadPage:
                self.delegate?.fetcher(self, didFinishLoadingPage: gifs)
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
