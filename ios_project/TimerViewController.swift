//
//  TimerViewController.swift
//  ios_project
//
//  Created by Ann on 2021/5/30.
//

import UIKit
import CoreData

class TimerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var courseID: UUID!
    var stopWatchCtrl: StopWatchController!
    //stopwatch variable
    var timer = Timer()
    var lapTimeList: [String] = []
    
    //StoryBoard variable
    @IBOutlet weak var stopWatchTime: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var lapResetButton: UIButton!
    @IBOutlet weak var usageInfoBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if courseID != nil
        {
            stopWatchCtrl = StopWatchController(_courseID: courseID)
        }
        viewInit()
        watchInit()
    }
    
    func viewInit()
    {
        stopWatchLapView.delegate = self
        stopWatchLapView.dataSource = self
    }
    // MARK: - TableView
    @IBOutlet weak var stopWatchLapView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        lapTimeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopWatchCell", for: indexPath)
        cell.textLabel?.text = "\(lapTimeList[indexPath.row])"
        
        return cell
    }
    
    func insertLapTime(t: Float)
    {
        lapTimeList.append("\(stopWatchCtrl.currentWorkoutIndex + 1). lap\(stopWatchCtrl.currentLapIndex + 1) \(t)")
        stopWatchLapView.reloadData()
    }
    func eraseLapTime()
    {
        lapTimeList.remove(at: lapTimeList.endIndex - 1)
        stopWatchLapView.reloadData()
    }
    // MARK: - Stopwatch function
    
    func watchInit()
    {
        setStartStopBtn()
        setLapResetBtn()
        lapResetButton.isEnabled = false
        
        stopWatchCtrl.watchInit()
        stopWatchTime.text = getTimeString(millisec: stopWatchCtrl.milliSeconds)
    }
    func watchStart()
    {
        stopWatchCtrl.watchStart()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(0.01), target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
    func watchStop()
    {
        stopWatchCtrl.watchStop()
        timer.invalidate()
        setStartStopBtn()
        setLapResetBtn()
    }
    func watchReset()
    {
        stopWatchCtrl.watchReset()
        lapTimeList.removeAll()
        stopWatchLapView.reloadData()
        watchInit()
    }
    @objc func countDown()
    {
        if !stopWatchCtrl.countDown()
        {
            watchStop()
            return
        }
        setStartStopBtn()
        setLapResetBtn()
        stopWatchTime.text = getTimeString(millisec: stopWatchCtrl.milliSeconds)
    }
    func getTimeString(millisec: Int) -> String
    {
        let calcuHour = millisec/360000
        let calcuMin =  millisec/6000
        let calcuSec = (millisec/100)%60
        let calcuMilSec = millisec%100
        
        let showHour = calcuHour>9 ? "\(calcuHour)":"0\(calcuHour)"
        let showMin =  calcuMin>9 ? "\(calcuMin)" : "0\(calcuMin)"
        let showSec = calcuSec>9 ? "\(calcuSec)":"0\(calcuSec)"
        let showMilSec = calcuMilSec>9 ?"\(calcuMilSec)":"0\(calcuMilSec)"
        let showTimeString = calcuMin>59 ? "\(showHour):\(showMin):\(showSec).\(showMilSec)": "\(showMin):\(showSec):\(showMilSec)"
        
        return showTimeString
    }
    // MARK: - UI Event
    
    @IBAction func startStopWatch(_ sender: Any)
    {
        if !stopWatchCtrl.isRunning
        {
            watchStart()
        }
        else
        {
            watchStop()
        }
       
    }
    @IBAction func lapResetWatch(_ sender: UIButton)
    {
        if stopWatchCtrl.isRunning
        {
            if !stopWatchCtrl.isRecorded
            {
                insertLapTime(t: stopWatchCtrl.watchRecord())
            }
            else
            {
                stopWatchCtrl.watchErase()
                eraseLapTime()
            }
        }
        else
        {
            watchReset()
        }
    }
    
    func setStartStopBtn()
    {
        if stopWatchCtrl.isRunning
        {
            startStopButton.setTitle("Pause" ,for: .normal)
            startStopButton.setTitleColor(.red, for: .normal)
        }
        else
        {
            startStopButton.setTitle("Start" ,for: .normal)
            startStopButton.setTitleColor(.white, for: .normal)
        }
    }
    func setLapResetBtn()
    {
        
        if stopWatchCtrl.isRunning
        {
            lapResetButton.isEnabled = !stopWatchCtrl.isRest
            lapResetButton.setTitleColor(.white, for: .normal)
            if !stopWatchCtrl.isRecorded
            {
                lapResetButton.setTitle("Record", for: .normal)
                lapResetButton.imageView?.tintColor = .red
            }
            else
            {
                lapResetButton.setTitle("Clear", for: .normal)
                lapResetButton.imageView?.tintColor = .lightGray
            }
        }
        else
        {
            lapResetButton.isEnabled = true
            lapResetButton.setTitle("Reset", for: .normal)
            lapResetButton.setTitleColor(.white, for: .normal)
            lapResetButton.imageView?.tintColor = .darkGray
        }
    }
    
    @IBAction func howToUse(_ sender: UIButton)
    {
        alertUsageInfo()
    }
    func alertUsageInfo()
    {
        let alertController = UIAlertController(title: "計時器說明", message: "1. 按start開始計時\n2. 按紅色按鈕紀錄（計時器並不會停止計時\n3. 按stop結束計時", preferredStyle: UIAlertController.Style.alert)
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

