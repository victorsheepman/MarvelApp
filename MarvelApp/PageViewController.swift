//
//  PageViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 26/1/24.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate {
    var pages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self

        createPages()
        // Establecer la primera página
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
    }

    
    private func createPages(){
        
        let page1 = UIViewController()
        page1.view.backgroundColor = UIColor.red

        let page2 = UIViewController()
        page2.view.backgroundColor = UIColor.blue

        let page3 = UIViewController()

        pages = [page1, page2, page3]
    }

}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        if currentIndex > 0 {
            return pages[currentIndex - 1]
        } else {
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
       
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }
}
