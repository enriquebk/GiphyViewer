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
    var gifFetcher = GifFetcher()
    
    init() {
        self.gifFetcher.delegate = self
    }
    
    func searchGIFs(with query: String) {
        
        self.gifs.value = []
        self.isSearching.value = true
        self.gifFetcher.search(query: query)
    }
    
    func loadNewPage() {
        self.gifFetcher.loadNewPage()
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

extension SearchViewModel: GifFetcherDelegate {
    
    func fetcher(_ fetcher: GifFetcher, didFinishLoadingPage gifs: [GIF]?) {
        
        self.gifs.value += gifs ?? []
    }
    
    func fetcher(_ fetcher: GifFetcher, didFinishSearching gifs: [GIF]?) {
        
        self.gifs.value = gifs ?? []
        
        if self.isSearching.value == true {
            self.isSearching.value = false
        }
    }
    
    func fetcher(_ fetcher: GifFetcher, didFailWithError error: Error) {
        self.coordinator.navigate(to: .showError(error))
        if self.isSearching.value == true {
            self.isSearching.value = false
        }
    }
}
