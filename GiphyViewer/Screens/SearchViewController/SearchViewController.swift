//
//  SearchViewController.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/1/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, MVVMView {

    var viewModel: SearchViewModel!
    
    func bindViewModel() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APIClient().searchGIFs(with: "funny") { (gifs, error) in
            
            print(gifs)
        }
        
        // Do any additional setup after loading the view.
    }

}
