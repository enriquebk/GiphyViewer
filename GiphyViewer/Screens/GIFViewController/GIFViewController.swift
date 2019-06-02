//
//  GIFViewController.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/1/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import UIKit
import SwiftyGif

class GIFViewController: UIViewController, MVVMView {

    @IBOutlet weak var gifImageView: UIImageView!
    var viewModel: GIFViewModel!
    
    func bindViewModel() {
        self.viewModel.gif.bind { [weak self] gif in
            if let url = gif.originalGIFURL {
                self?.gifImageView.loadGif(from: url)
            }
        }
    }
    
    @IBAction func pinchAction(_ pinchGestureRecognizer: UIPinchGestureRecognizer) {
    
        if pinchGestureRecognizer.state == .ended {
            UIView.animate(withDuration: 0.3) {
                self.view.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }
            return
        }
        
        if let transformation = pinchGestureRecognizer.view?.transform.scaledBy(x: pinchGestureRecognizer.scale, y: pinchGestureRecognizer.scale) {
            
            pinchGestureRecognizer.view?.transform = transformation
            pinchGestureRecognizer.scale = 1.0
        }
    }
}
