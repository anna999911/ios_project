//
//  MenuViewController.swift
//  ios_project
//
//  Created by Ann on 2021/5/30.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var backToPage1: UIButton!
    
    @IBOutlet weak var chosseCourse: UIButton!
    @IBOutlet weak var before: UIButton!
    
    @IBOutlet weak var timer: UIButton!
    

    @IBAction func chooseCourse(_ sender: UIButton) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "page5")
        {
        present( controller , animated: true, completion: nil)
        
        }
        
    }
    @IBAction func backToPage1(_ sender: UIButton) {
        dismiss (animated: true, completion: nil)
    }
    
    @IBAction func changeToBefore(_ sender: UIButton) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "Page4")
        {
        present( controller , animated: true, completion: nil)
        
        }
    }
    @IBAction func Timer(_ sender: UIButton) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "Page3")
        {
        present( controller , animated: true, completion: nil)
        
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
