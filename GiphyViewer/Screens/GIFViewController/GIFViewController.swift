//
//  GIFViewController.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/1/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit

class GIFViewController: UIViewController, MVVMView {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var gifImageView: UIImageView!
    var viewModel: GIFViewModel!
    
    func bindViewModel() {
        self.viewModel.gif.bind { [weak self] gif in
            if let url = gif.originalGIFURL, let previewImageUrl = gif.previewGIFUrl {
                self?.previewImageView.loadGif(from: previewImageUrl, loopCount: 0, showLoader: false)
                self?.gifImageView.loadGif(from: url)
            }
        }
    }
    
    @IBAction func pinchAction(_ pinchGestureRecognizer: UIPinchGestureRecognizer) {
    
        if pinchGestureRecognizer.state == .ended {
            UIView.animate(withDuration: 0.3) {
                pinchGestureRecognizer.view?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }
            return
        }
        
        if let transformation = pinchGestureRecognizer.view?.transform.scaledBy(x: pinchGestureRecognizer.scale, y: pinchGestureRecognizer.scale) {
            
            pinchGestureRecognizer.view?.transform = transformation
            pinchGestureRecognizer.scale = 1.0
        }
    }
}
