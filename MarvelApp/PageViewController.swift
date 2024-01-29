//
//  PageViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 26/1/24.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate {
    var pages = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self

        createPages()
        configureIndicatorStyle(defaultColor: .gray, activeColor: .white)
        // Establecer la primera página
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
       
    
    }

    
    
    private func createPages(){
        
        
        let page1 = PageView(image: UIImage(named: "imageOne"), backgroundImage: UIImage(named: "bg1"))
        let page2 = PageView(image: UIImage(named: "imageTwo"), backgroundImage: UIImage(named: "bg2"))
        
        let page3 = PageView(image: UIImage(named: "imageThree"), backgroundImage: UIImage(named: "bg3"))
        
        let page4 = PageView(image: UIImage(named: "imageFour"), backgroundImage: UIImage(named: "bg4"))

        pages = [page1, page2, page3, page4]
    }

    private func configureIndicatorStyle(defaultColor:UIColor, activeColor:UIColor){
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [PageViewController.self])
        
        pageControl.pageIndicatorTintColor = defaultColor
        pageControl.currentPageIndicatorTintColor = activeColor
        
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
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = pages.first,
              let firstViewControllerIndex = pages.firstIndex(of: firstViewController) else {
            return 0
        }

        print("Presentation Index:", firstViewControllerIndex)
        return firstViewControllerIndex
    }

}
