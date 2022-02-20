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
        
        // Search view
        let searchViewController = setupSearchView()
        
        tabController.viewControllers = [newsFeedController, countryController, searchViewController]
        tabController.modalPresentationStyle = .fullScreen

        let navigationController = UINavigationController(rootViewController: tabController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    private func setupNewsFeed() -> UIViewController {
        let feedController = FeedViewController(viewModel: FeedViewModel(itemType: .article, channel: nil))
        feedController.tabBarItem = UITabBarItem(title: "Top headlines", image: nil, selectedImage: nil)
        return feedController
    }
    
    private func setupCountriesView() -> UIViewController {
        let countryHeadlinesViewController = FeedViewController(viewModel: FeedViewModel(itemType: .article, channel: nil))
        countryHeadlinesViewController.tabBarItem = UITabBarItem(title: "Country news", image: nil, selectedImage: nil)

        let channelsViewController = FeedViewController(viewModel: FeedViewModel(itemType: .channel, channel: nil))
        channelsViewController.tabBarItem = UITabBarItem(title: "Channels", image: nil, selectedImage: nil)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [countryHeadlinesViewController, channelsViewController]
        tabBarController.tabBarItem = UITabBarItem(title: "Country", image: nil, selectedImage: nil)
        return tabBarController
    }

    private func setupSearchView() -> UIViewController {
        let searchViewController = SearchViewController(viewModel: FeedViewModel(itemType: .article, channel: nil))
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        return searchViewController
    }
}

