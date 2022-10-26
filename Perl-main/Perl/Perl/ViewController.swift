//
//  ViewController.swift
//  Perl
//
//  Created by Mac on 2022-08-25.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var contentView: UIView!
    
    let dataSource = ["Page 1", "Page 2", "Page 3"]
    var currentViewController = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        
    }
    
    func configurePageViewController() {
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: CustomPageViewController.self)) as? CustomPageViewController else {
            return
        }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        pageViewController.view.backgroundColor = UIColor.gray
        
        
        contentView.addSubview(pageViewController.view)
        
        let views: [String: Any] = ["pageView": pageViewController.view as Any]
        
        contentView.addConstraints((NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
        
        guard let startingViewController = detailViewControllerAt(index: currentViewController) else {
            return
        }
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
        
    }
    
    func detailViewControllerAt(index: Int) ->  NewsViewController? {
        
        if index >= dataSource.count || dataSource.count == 0 {
            return nil
        }
        
        guard let newsViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: NewsViewController.self)) as? NewsViewController else {
            return nil
        }
        newsViewController.index = index
        newsViewController.displayText = dataSource[index]
        return newsViewController
    }

}

extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewController
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSource.count
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let newsViewController = viewController as? NewsViewController
        
        guard var currentIndex = newsViewController?.index else {
            return nil
        }
        
        currentViewController = currentIndex
        
        if currentIndex == 0 {
            return nil
        }
        
        currentIndex -= 1
        
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let newsViewController = viewController as? NewsViewController
        
        guard var currentIndex = newsViewController?.index else {
            return nil
        }
        
        if currentIndex == dataSource.count {
            return nil
        }
        currentIndex += 1
        currentViewController = currentIndex
        
        return detailViewControllerAt(index: currentIndex)
    }
    
}
