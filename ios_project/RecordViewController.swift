//
//  BeforeViewController.swift
//  ios_project
//
//  Created by Ann on 2021/5/31.
//

import UIKit
import CoreData

class RecordViewController: UIViewController {


    //UI Event
    @IBAction func Edit(_ sender: UIBarButtonItem)
    {
    }
    
    
 
    let fullScreenSize = UIScreen.main.bounds.size
    var myLabel = UILabel(frame: CGRect(
      x: 200, y: 200,
    width:100, height: 50))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var myDatePicker: UIDatePicker!
       
        myDatePicker = UIDatePicker(frame: CGRect(
         x: 0, y: 0,
         width: fullScreenSize.width, height: 100))
        
        let formatter = DateFormatter()
        myDatePicker.datePickerMode = .date
        formatter.dateFormat = "yyyy-MM-dd"
        let fromDateTime = formatter.date(from: "2019-01-02")
        myDatePicker.minimumDate = fromDateTime
        let endDateTime = formatter.date(from: "2020-06-16")
        myDatePicker.maximumDate = endDateTime
        myDatePicker.locale = NSLocale(
            localeIdentifier: "zh_TW") as Locale
        myDatePicker.addTarget(self,
                               action:
                                #selector(RecordViewController.datePickerChanged),
                               for: .valueChanged)
        
        myDatePicker.center = CGPoint(
          x: fullScreenSize.width * 0.5,
          y: fullScreenSize.height * 0.33)
        self.view.addSubview(myDatePicker)
        // Do any additional setup after loading the view.
        let chooseDate = UILabel(frame: CGRect(
                                    x: 200, y: 200,
                                  width:200, height: 100))
        let GuestchooseDate = UILabel(frame: CGRect(
                                    x: 200, y: 200,
                                  width:200, height: 100))
        myLabel.backgroundColor = UIColor.lightGray
        myLabel.textColor = UIColor.black
        myLabel.textAlignment = .center
        myLabel.center = CGPoint(
          x: fullScreenSize.width * 0.5,
          y: fullScreenSize.height * 0.42)
        GuestchooseDate.text = "請點選日期"
        GuestchooseDate.center = CGPoint(
            x: fullScreenSize.width * 0.6,
            y: fullScreenSize.height * 0.28)
        GuestchooseDate.textColor = UIColor.white
        chooseDate.text = "選擇的日期："
        chooseDate.center = CGPoint(
            x: fullScreenSize.width * 0.6,
            y: fullScreenSize.height * 0.37)
        chooseDate.textColor = UIColor.white
        self.view.addSubview(GuestchooseDate)
        self.view.addSubview(chooseDate)
        self.view.addSubview(myLabel)
        
    }
   
    @objc func datePickerChanged(datePicker:UIDatePicker) {
        // 設置要顯示在 UILabel 的日期時間格式
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd "

        // 更新 UILabel 的內容
        myLabel.text = formatter.string(
            from: datePicker.date)
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
