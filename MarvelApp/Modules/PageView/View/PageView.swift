//
//  PageView.swift
//  MarvelApp
//
//  Created by Victor Marquez on 26/1/24.
//

import UIKit

class PageView: UIViewController {
    
    
    @IBOutlet weak private var imageView: UIImageView!
    private var image: UIImage?
    private var backgroundImage: UIImage?
    private var homeCoordinator:HomeCoordinator?
    
    init(image: UIImage?, backgroundImage: UIImage?) {
        self.image = image
        self.backgroundImage = backgroundImage
        super.init(nibName: nil, bundle: nil)
       
    }
       
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
          super.viewDidLoad()
          imageView.image = image
          addBackground()
    }
    
    private func addBackground(){
        if let backgroundImage = backgroundImage {
            let backgroundImageView = UIImageView(frame: view.bounds)
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.clipsToBounds = true
            backgroundImageView.image = backgroundImage
            view.insertSubview(backgroundImageView, at: 0)
        }
    }
       
 
    @IBAction func skipPage(_ sender: Any) {
        homeCoordinator = HomeCoordinator(viewController: self)
        homeCoordinator?.start()        
    }
    
}
