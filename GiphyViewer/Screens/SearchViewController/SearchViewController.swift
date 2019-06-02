//
//  SearchViewController.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/1/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit
import SVProgressHUD

//swiftlint:disable line_length
class SearchViewController: UIViewController, MVVMView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
//swiftlint:enable line_length
    
    var viewModel: SearchViewModel!
    @IBOutlet weak private var collectionView: UICollectionView!
    private let searchBar = UISearchBar()
    private let refreshControl = UIRefreshControl()
    
    func bindViewModel() {
        self.viewModel.isSearching.bind { searching in
            if searching {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        self.viewModel.gifs.bind { (_) in
            self.collectionView.reloadData()
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
        
        self.viewModel.searchGIFs(with: "funny")
        
        self.collectionView.addSubview(self.refreshControl)
        self.refreshControl.addTarget(self, action: #selector(reloadItems), for: .valueChanged)
    }
    
    @objc func reloadItems() {
        self.refreshControl.endRefreshing()
        if let searchText = self.searchBar.text {
            self.viewModel.searchGIFs(with: searchText)
        }
    }
    
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.gifs.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(type: GIFCollectionViewCell.self, forIndexPath: indexPath)
        
        if let viewState = self.viewModel.getViewStateforGIF(at: indexPath.item) {
            
            cell.setViewState(viewState)
            cell.backgroundColor = UIColor.cyan
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.selectGIF(at: indexPath.item)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout protocol
    
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
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if indexPath.item == self.viewModel.gifs.value.count - 1 {
                //self.viewModel.loadNewPage()
            }
        }
    }
    
    @objc func search(_ query: String) {
        self.viewModel.searchGIFs(with: query)
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
