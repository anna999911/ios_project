//
//  TimerViewController.swift
//  ios_project
//
//  Created by Ann on 2021/5/30.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var redButton: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var backToPage2: UIButton!
    @IBOutlet weak var record: UIButton!
    
    @IBOutlet weak var howToUse: UIButton!
    
    @IBAction func howToUse(_ sender: UIButton) {
        
        alert()
    }
    @IBAction func backToPage2(_ sender: UIButton) {
        dismiss (animated: true, completion: nil)
    }
    func alert(){
    let alertController = UIAlertController(title: "計時器說明", message: "1. 按start開始計時  2. 按中間紅色按鈕紀錄（計時器並不會停止計時）  3. 按stop結束計時", preferredStyle: UIAlertController.Style.alert)
    alertController.view.tintColor = UIColor.gray
    let butAction = UIAlertAction(title: "我知道了", style: UIAlertAction.Style.default, handler:nil)
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
