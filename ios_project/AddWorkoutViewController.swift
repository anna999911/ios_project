//
//  AddWorkoutViewController.swift
//  ios_project
//
//  Created by 陳宥儒 on 2021/6/11.
//

import UIKit

class AddWorkoutViewController: UIViewController {
    
    var workoutList: [Workout] = []
    var addWorkPage: AddWorkoutViewController!
    var addCoursePage: AddCourseViewController!
    //StoryBoard variable
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var set: UITextField!
    @IBOutlet weak var timeMin: UITextField!
    @IBOutlet weak var timeSec: UITextField!
    @IBOutlet weak var timeMilisec: UITextField!
    @IBOutlet weak var targetMin: UITextField!
    @IBOutlet weak var targetSec: UITextField!
    @IBOutlet weak var targetMilisec: UITextField!
    @IBOutlet weak var restMin: UITextField!
    @IBOutlet weak var restSec: UITextField!
    @IBOutlet weak var restMilisec: UITextField!
    @IBOutlet weak var info: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func addWorkout() -> Workout
    {
        let time: Float = Float(timeMin.text!)!*Float(60) + Float(timeSec.text!)! + Float(0.01)*Float(timeMilisec.text!)!
        let target: Float = Float(targetMin.text!)!*Float(60) + Float(targetSec.text!)! + Float(0.01)*Float(targetMilisec.text!)!
        let rest: Float = Float(restMin.text!)!*Float(60) + Float(restSec.text!)! + Float(0.01)*Float(restMilisec.text!)!
        return (CoreDataController.Instance()?.insertWorkout(name: name.text!, set: Int16(Int(set.text!)!), time: time, target: target, rest: rest, info: info.text!, workouts: workoutList))!
    }
    // MARK: - Navigation
    @IBAction func backBtn(_ sender: UIButton) {
        let workout = addWorkout()
        if addWorkPage != nil
        {
            addWorkPage.workoutList.append(workout)
        }
        else if addCoursePage != nil
        {
            addCoursePage.workoutList.append(workout)
        }

        self.navigationController?.popViewController(animated: true);
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "addWorkout")
        {
            let workouPage = segue.destination as! AddWorkoutViewController
            workouPage.addWorkPage = self
        }
    }
}

