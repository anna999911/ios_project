//
//  AddCourseViewController.swift
//  ios_project
//
//  Created by Ann on 2021/6/2.
//

import UIKit

class AddCourseViewController: UIViewController {
    
    
    @IBAction func addNew(_ sender: Any) {
        alert()
    }
    

    func alert(){
    let alertController = UIAlertController(title: "課表名稱", message: "請輸入欲新增的課表名稱", preferredStyle: UIAlertController.Style.alert)
    alertController.view.tintColor = UIColor.gray
        alertController.addTextField{(textField) in
            textField.text = "Input Name"}
        
    let butAction = UIAlertAction(title: "確定新增", style: UIAlertAction.Style.default, handler:nil)
        
    alertController.addAction(butAction)
     
   
        
    self.present(alertController, animated: true, completion: nil)
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
