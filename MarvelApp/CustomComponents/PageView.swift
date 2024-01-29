//
//  PageView.swift
//  MarvelApp
//
//  Created by Victor Marquez on 26/1/24.
//

import UIKit

class PageView: UIViewController {
    @IBOutlet weak private var imageView: UIImageView!
    
        var image: UIImage?
       
       init(image: UIImage?) {
           self.image = image
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
       }
    
    override func viewDidLoad() {
          super.viewDidLoad()
          // Configure your imageView with the provided image
          imageView.image = image
    }
}
