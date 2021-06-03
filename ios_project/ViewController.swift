//
//  ViewController.swift
//  ios_project
//
//  Created by Ann on 2021/5/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var start: UIButton!
    
    @IBOutlet weak var google: UIButton!
    
    @IBAction func start(_ sender: UIButton) {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "Page2")
        {
        present( controller , animated: true, completion: nil)
        
        }
    }
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

