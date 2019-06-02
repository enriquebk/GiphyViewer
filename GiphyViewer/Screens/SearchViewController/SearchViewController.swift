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
    
    func bindViewModel() {
        self.viewModel.isSearching.bind { searching in
            if searching {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = L10n.search
        
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchGifs(with: searchText)
    }
}
