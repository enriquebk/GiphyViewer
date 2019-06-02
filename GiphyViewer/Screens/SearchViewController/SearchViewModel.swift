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
    private var searchQuery = ""// TODO: Move to a fetcher
    private var page = 0 // TODO: Move to a fetcher
    private var pageSize = 20 // TODO: Move to a fetcher
    private var fetchGifRequest: CancelableRequest? // Move to API CLient
    
    private func fetchGifs(showLoading: Bool = false) {
        
        self.fetchGifRequest?.cancel()
        
        guard self.searchQuery.count > 0 else {
            self.isSearching.value = false
            return
        }
        
        if showLoading {
            self.isSearching.value = true
        }
        
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
    
    func searchGIFs(with query: String) {
        self.searchQuery = query
        self.page = 0
        self.gifs.value = []
        
        fetchGifs(showLoading: true)
    }
    
    func loadNewPage() {
        self.page += 1
        self.fetchGifs()
    }
    
    func getViewStateforGIF(at index: Int) -> GIFCollectionViewCellViewState? {
        
        guard index < self.gifs.value.count else {
            return nil
        }
        
        let gif = self.gifs.value[index]
        
        return GIFCollectionViewCellViewState(gif)
    }
    
    func selectGIF(at index: Int) {
        guard index < self.gifs.value.count else {
            return
        }
        
        let gif = self.gifs.value[index]
        
        self.coordinator.navigate(to: .show(gif))
    }
}
