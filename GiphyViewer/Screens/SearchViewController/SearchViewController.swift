//
//  SearchViewController.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/1/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchViewController: UIViewController, MVVMView {
    
    var viewModel: SearchViewModel!
    @IBOutlet weak private var collectionView: UICollectionView!
    private let searchBar = UISearchBar()
    private let refreshControl = UIRefreshControl()
    private var showingCellsCount = 0
    
    func bindViewModel() {
        self.viewModel.isSearching.bind { searching in
            if searching {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        self.viewModel.gifs.bind { [weak self] (gifs) in
            
            guard let strongSelf = self else {
                return
            }
            
            if strongSelf.showingCellsCount < gifs.count && strongSelf.showingCellsCount > 0 {
                //Load new page
                strongSelf.collectionView?.performBatchUpdates({
                    var indexPaths:[IndexPath] = []
                    for index in strongSelf.showingCellsCount..<gifs.count {
                        indexPaths.append(IndexPath(row: index, section: 0))
                    }
                    strongSelf.collectionView?.insertItems(at: indexPaths)
                }, completion: nil)
            } else {
                //Show new search
                strongSelf.collectionView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.registerCell(type: GIFCollectionViewCell.self)

        searchBar.sizeToFit()
        searchBar.placeholder = L10n.search
        searchBar.returnKeyType = .done
        searchBar.showsCancelButton = true
        
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
        self.collectionView.addSubview(self.refreshControl)
        self.refreshControl.addTarget(self, action: #selector(reloadItems), for: .valueChanged)
    }
    
    @objc private func reloadItems() {
        self.refreshControl.endRefreshing()
        if let searchText = self.searchBar.text {
            self.viewModel.searchGIFs(with: searchText)
        }
    }
    
    @objc private func search(_ query: String) {
        self.viewModel.searchGIFs(with: query)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.showingCellsCount = self.viewModel.gifs.value.count
        return showingCellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(type: GIFCollectionViewCell.self, forIndexPath: indexPath)
        
        if let viewState = self.viewModel.getViewStateforGIF(at: indexPath.item) {
            cell.setViewState(viewState)
        }
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.selectGIF(at: indexPath.item)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewMargin = CGFloat(4)
        let itemsSpacing = CGFloat(4)
        let numberOfItems = CGFloat(2)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.sectionInset =  UIEdgeInsets(top: collectionViewMargin,
                                                left: collectionViewMargin,
                                                bottom: collectionViewMargin,
                                                right: collectionViewMargin)
            layout.minimumInteritemSpacing = itemsSpacing
            layout.minimumLineSpacing = itemsSpacing
            layout.invalidateLayout()
        }
        
        let size = collectionView.frame.width / CGFloat(numberOfItems) - (collectionViewMargin / 2.0 + itemsSpacing)
        return CGSize(width: size, height: size)
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        if indexPaths.first(where: { return $0.item == self.viewModel.gifs.value.count - 1 }) != nil {
            self.viewModel.loadNewPage()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.perform(#selector(self.search), with: searchBar.text, afterDelay: 0.5)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let previousText = searchBar.text {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.search), object: previousText)
        }
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
