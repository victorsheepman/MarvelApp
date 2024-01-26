//
//  ViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 10/1/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var pageViewController: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
       buildPage()
        
    }
    
    private func buildPage() {
        let nib = UINib(nibName: "PageView", bundle: nil)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                                UIView else {fatalError("Unable to convert nib")}
        pageViewController.addSubview(view)
    }


}

