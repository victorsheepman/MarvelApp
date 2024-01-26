//
//  ViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 10/1/24.
//

import UIKit

class ViewController: UIViewController {

    var myPageViewController: PageViewController!
    override func viewDidLoad() {
        super.viewDidLoad()        
        initializePageViewController()
    }
    
    private func initializePageViewController (){
        myPageViewController = PageViewController()

        addChild(myPageViewController)
        view.addSubview(myPageViewController.view)
        myPageViewController.didMove(toParent: self)
    }
    
    /*private func buildPage() {
        let nib = UINib(nibName: "PageView", bundle: nil)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                                UIView else {fatalError("Unable to convert nib")}
        pageViewController.addSubview(view)
    }
*/

}

