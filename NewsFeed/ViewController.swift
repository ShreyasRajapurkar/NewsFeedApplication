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
        tabController.viewControllers = [FeedViewController(viewModel: FeedViewModel(itemType: .channel, channel: nil))]
        tabController.modalPresentationStyle = .fullScreen
        var navigationController = UINavigationController(rootViewController: tabController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}

