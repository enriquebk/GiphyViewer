//
//  SearchViewController.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/1/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchViewController: UIViewController, MVVMView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var viewModel: SearchViewModel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func bindViewModel() {
        self.viewModel.isSearching.bind { searching in
            if searching {
                SVProgressHUD.show()
            } else {
                self.collectionView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.registerCell(type: GIFCollectionViewCell.self)

        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = L10n.search
        
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
        self.viewModel.searchGIFs(with: "funny")
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
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchGIFs(with: searchText)
    }
}
