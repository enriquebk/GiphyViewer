//
//  SearchViewModel.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/1/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation

class SearchViewModel: ViewModel, CoordinatorManager {
    
    var coordinator: Coordinator<SearchRoute>!
    var gifs = BindableValue([GIF]())
    var isSearching = BindableValue(false)
    private var apiClient = APIClient()
    private var searchQuery = ""
    private var page = 0
    private var pageSize = 20
    private var fetchGifRequest: CancelableRequest?
    
    private func fetchGifs(showLoading: Bool = false) {
        
        if showLoading {
            self.isSearching.value = true
        }
        
        self.fetchGifRequest?.cancel()
        
        self.fetchGifRequest = self.apiClient.searchGIFs(with: self.searchQuery,
                                                         limit: self.pageSize,
                                                         offset: self.page * self.pageSize) { [weak self] (gifs, error) in
            
            if let error = error {
                self?.coordinator.navigate(to: .showError(error))
            } else {
                
                var fetchedGifs: [GIF] = []
                
                if let gifs = gifs {
                    fetchedGifs = gifs
                }
                
                self?.gifs.value += fetchedGifs
                
                if showLoading {
                    self?.isSearching.value = false
                }
            }
            self?.isSearching.value = false
        }
    }
    
    func searchGifs(with query: String) {
        self.searchQuery = query
        self.page = 0
        self.gifs.value = []
        
        fetchGifs(showLoading: true)
    }
    
    func loadNewPage() {
        self.page += 1
        self.fetchGifs()
    }
    
    func selectGif(at index: Int) {
        
    }
}
