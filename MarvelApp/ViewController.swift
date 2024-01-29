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
        myPageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
      
        addChild(myPageViewController)
        view.addSubview(myPageViewController.view)
        myPageViewController.didMove(toParent: self)
    }


}

