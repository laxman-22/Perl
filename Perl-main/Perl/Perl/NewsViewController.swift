//
//  NewsViewController.swift
//  Perl
//
//  Created by Mac on 2022-09-01.
//

import UIKit

class NewsViewController: UIViewController {
    
    
    @IBOutlet weak var displayLabel: UILabel!
    var displayText: String?
    var index: Int?
    //add image in here
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayText
        
        // Do any additional setup after loading the view.
    }

}
