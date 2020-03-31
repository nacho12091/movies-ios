//
//  ReadMoreViewController.swift
//  Movies
//
//  Created by Ignacio Lima on 8/27/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit

class ReadMoreViewController: UIViewController {

    @IBOutlet weak var textDescription: UITextView!
    @IBOutlet weak var titleLabelDescription: UILabel!
    
    private struct keys {
        static let overview = "Overview"
    }
    
    var movie: Movie? = nil
    var person: Person? = nil
    var descriptionTitle: String = ""
    
    @IBAction func onPressDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textDescription.textContainerInset = UIEdgeInsets.zero
        textDescription.textContainer.lineFragmentPadding = 0
        
        if (descriptionTitle == keys.overview) {
            self.title = movie?.title
            textDescription.text = movie?.desc
        } else {
            self.title = person?.personName
            textDescription.text = person?.personDescription
        }
        titleLabelDescription.text = descriptionTitle
    }


}
