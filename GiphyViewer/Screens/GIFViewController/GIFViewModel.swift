//
//  GIFViewModel.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/1/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation

class GIFViewModel: ViewModel {
    
    var gif: BindableValue<GIF>!
    
    init(_ gif:GIF) {
        self.gif = BindableValue(gif)
    }
    
}
