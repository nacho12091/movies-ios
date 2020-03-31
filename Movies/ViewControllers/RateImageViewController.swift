//
//  RateImageViewController.swift
//  Movies
//
//  Created by Ignacio Lima on 8/20/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class RateImageViewController: UIViewController {
    
    var screenTitle: String = ""
    var image: String = ""

    @IBOutlet weak var moviePoster: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = screenTitle
        moviePoster.sd_setImage(with: URL(string: image))
    }
    
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        if navigationController?.isNavigationBarHidden ?? false {
            dismissFullscreenImage(sender: sender)
        } else {
            showFullscreenImage(sender: sender)
        }
    }

    @objc func showFullscreenImage(sender: UITapGestureRecognizer) {
        
        self.navigationController?.isNavigationBarHidden = true
        
        UIView.animate(withDuration: 0.5) {
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
}
