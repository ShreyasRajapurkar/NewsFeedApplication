//
//  ViewController.swift
//  NewsFeed
//
//  Created by Shreyas Rajapurkar on 16/02/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tabController = UITabBarController()
        
        // News feed
        let newsFeedController = setupNewsFeed()
        
        // Country feed
        let countryController = setupCountriesView()
        
        tabController.viewControllers = [newsFeedController, countryController]
        tabController.modalPresentationStyle = .fullScreen

        var navigationController = UINavigationController(rootViewController: tabController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    private func setupNewsFeed() -> UIViewController {
        let feedController = FeedViewController(viewModel: FeedViewModel(itemType: .article, channel: nil))
        feedController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        return feedController
    }
    
    private func setupCountriesView() -> UIViewController {
        let countryHeadlinesViewController = FeedViewController(viewModel: FeedViewModel(itemType: .article, channel: nil))
        countryHeadlinesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)

        let channelsViewController = FeedViewController(viewModel: FeedViewModel(itemType: .channel, channel: nil))
        channelsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [countryHeadlinesViewController, channelsViewController]
        tabBarController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        return tabBarController
    }
}

