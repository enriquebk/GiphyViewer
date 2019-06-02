//
//  GIFCollectionViewCell.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit
import SwiftyGif

struct GIFCollectionViewCellViewState {
    let titleString: String
    let previewURL: URL?
    
    init(_ gif: GIF) {
        self.previewURL = gif.previewGIFUrl
        self.titleString = gif.title
    }
}

class GIFCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var GIFImage: UIImageView!
    
    func setViewState(_ viewState: GIFCollectionViewCellViewState) {
        
        self.GIFImage.setGifFromURL(viewState.previewURL)
    }

}
