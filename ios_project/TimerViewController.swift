//
//  TimerViewController.swift
//  ios_project
//
//  Created by Ann on 2021/5/30.
//

import UIKit
import CoreData

class TimerViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContext = app.persistentContainer.viewContext
        stopWatchLapView.delegate = self
                stopWatchLapView.dataSource = self
                clickLapButton.isEnabled = false
                clickLapButton.setTitleColor(.lightGray, for: .normal)
        
    }
    
    
    var startStatus = true
       var canLapStatus = false
       var millSeconds = 0
       var timer = Timer()
       var stopWatches = [String]()
     
       
       @IBOutlet weak var stopWatchTime: UILabel!
       @IBOutlet weak var startLapButton: UIButton!
       @IBOutlet weak var clickLapButton: UIButton!
     
    @IBOutlet weak var stopWatchLapView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stopWatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopWatchCell", for: indexPath)
        
        cell.textLabel?.text = "\(stopWatches[indexPath.row])"
    
        return cell
                
    }
    

    @IBAction func startStopWatch(_ sender: Any) {
       
           if startStatus{
               startStatus = false
               canLapStatus = true
            startLapButton.setTitle("Stop" ,for: .normal)
                        startLapButton.setTitleColor(.red, for: .normal)
               clickLapButton.isEnabled = true
               timer = Timer.scheduledTimer(timeInterval: TimeInterval(0.01), target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
               RunLoop.current.add(timer, forMode: .common)
           }else{
            startLapButton.setTitle("Start" ,for: .normal)
                        startLapButton.setTitleColor(.white, for: .normal)
               startStatus = true
               canLapStatus = false

               timer.invalidate()
              }
           
       }
    var showTimeString = ""
         var calcuMilSec = 0
         var calcuSec = 0
         var calcuMin = 0
         var calcuHour = 0
        
        @objc func countDown(){
            
            millSeconds += 1
            
            calcuHour = millSeconds/360000
            calcuMin =  millSeconds/6000
            calcuSec = (millSeconds/100)%60
            calcuMilSec = millSeconds%100
            
            let showHour = calcuHour>9 ? "\(calcuHour)":"0\(calcuHour)"
            let showMin =  calcuMin>9 ? "\(calcuMin)" : "0\(calcuMin)"
            let showSec = calcuSec>9 ? "\(calcuSec)":"0\(calcuSec)"
            let showMilSec = calcuMilSec>9 ?"\(calcuMilSec)":"0\(calcuMilSec)"
            showTimeString = calcuMin>59 ? "\(showHour):\(showMin):\(showSec).\(showMilSec)": "\(showMin):\(showSec):\(showMilSec)"
            stopWatchTime.text = showTimeString
        }

        @IBAction func lapStopWatch(_ sender: UIButton) {
            if canLapStatus{
                stopWatches.insert(stopWatchTime.text!,at: 0)
                stopWatchLapView.reloadData()
            }else{
                stopWatches.removeAll()
                stopWatchLapView.reloadData()
                millSeconds = 0
                calcuMilSec = 0
                calcuSec = 0
                calcuMin = 0
                calcuHour = 0
                stopWatchTime.text = "00:00:00"
                startStatus = true
                canLapStatus = false
               // clickLapButton.setTitle("Lap" ,for: .normal)
                //clickLapButton.setTitleColor(.white, for: .normal)
            }
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //CoreData setup
    let app = UIApplication.shared.delegate as! AppDelegate
    var viewContext: NSManagedObjectContext!
    
    //Storyboard variable

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var record: UIButton!
    @IBOutlet weak var usageInfoBtn: UIButton!
    
    //UI event
    @IBAction func howToUse(_ sender: UIButton)
    {
        alertUsageInfo()
    }

    func alertUsageInfo()
    {
        let alertController = UIAlertController(title: "計時器說明", message: "1. 按start開始計時  2. 按紅色按鈕紀錄（計時器並不會停止計時）  3. 按stop結束計時", preferredStyle: UIAlertController.Style.alert)
        alertController.view.tintColor = UIColor.gray
        let butAction = UIAlertAction(title: "我知道了", style: UIAlertAction.Style.default, handler:nil)
        alertController.addAction(butAction)
        self.present(alertController, animated: true, completion: nil)
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
