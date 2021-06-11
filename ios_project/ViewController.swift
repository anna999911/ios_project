//
//  ViewController.swift
//  ios_project
//
//  Created by Ann on 2021/5/27.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    //CoreData setup
    let app = UIApplication.shared.delegate as! AppDelegate
    var viewContext: NSManagedObjectContext!
    
    //Storyboard Variable
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var google: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewContext = app.persistentContainer.viewContext
        
    }


}

