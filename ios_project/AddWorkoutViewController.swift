//
//  AddWorkoutViewController.swift
//  ios_project
//
//  Created by 陳宥儒 on 2021/6/11.
//

import UIKit

class AddWorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    //CoreData variable
    var currentWorkout: Workout!
    var isNew: Bool!
    var fromW: Bool!
    var fromC: Bool!
    var superID: UUID!
    //Navigation variable
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
        Init()
        navigationController?.title = name.text
        isNew = currentWorkout == nil
        fromW = addWorkPage != nil
        fromC = addCoursePage != nil
        superID = (fromW) ? addWorkPage.currentWorkout.wid : addCoursePage.currentCourse.cid
        if !isNew
        {
            navigationController?.title = currentWorkout.name
            showWorkout()
        }
        else
        {
            addWorkout()
        }
    }
    func Init()
    {
        name.text = "new workout"
        set.text = String(0)
        timeMin.text = String(0)
        timeSec.text = String(0)
        timeMilisec.text = String(0)
        targetMin.text = String(0)
        targetSec.text = String(0)
        targetMilisec.text = String(0)
        restMin.text = String(0)
        restSec.text = String(0)
        restMilisec.text = String(0)
        info.text = "enter info here"
    }
    func addWorkout()
    {
        let time: Float = Float(timeMin.text!)!*Float(60) + Float(timeSec.text!)! + Float(0.01)*Float(timeMilisec.text!)!
        let target: Float = Float(targetMin.text!)!*Float(60) + Float(targetSec.text!)! + Float(0.01)*Float(targetMilisec.text!)!
        let rest: Float = Float(restMin.text!)!*Float(60) + Float(restSec.text!)! + Float(0.01)*Float(restMilisec.text!)!
        currentWorkout = (CoreDataController.Instance()?.insertWorkout(name: name.text!, set: Int16(Int(set.text!)!), time: time, target: target, rest: rest, info: info.text!, workouts: []))
        addContainWorkouts()
    }
    func editWorkout()
    {
        let time: Float = Float(timeMin.text!)!*Float(60) + Float(timeSec.text!)! + Float(0.01)*Float(timeMilisec.text!)!
        let target: Float = Float(targetMin.text!)!*Float(60) + Float(targetSec.text!)! + Float(0.01)*Float(targetMilisec.text!)!
        let rest: Float = Float(restMin.text!)!*Float(60) + Float(restSec.text!)! + Float(0.01)*Float(restMilisec.text!)!
        CoreDataController.Instance()?.editWorkout(workoutID: currentWorkout.wid!, name: name.text!, set: Int16(Int(set.text!)!), time: time, target: target, rest: rest, info: info.text!, workouts: [])
    }
    func showWorkout()
    {
        name.text = currentWorkout.name
        set.text = String(currentWorkout.set)
        
        let t: Float = currentWorkout.time
        timeMin.text = String(Int(t) / 60)
        timeSec.text = String(Int(t) % 60)
        timeMilisec.text = String(Int(Float(t - Float(Int(t))) * Float(100)))
        
        let g: Float = currentWorkout.target
        targetMin.text = String(Int(g) / 60)
        targetSec.text = String(Int(g) % 60)
        targetMilisec.text = String(Int(Float(g - Float(Int(g))) * Float(100)))
        
        let r: Float = currentWorkout.rest
        restMin.text = String(Int(r) / 60)
        restSec.text = String(Int(r) % 60)
        restMilisec.text = String(Int(Float(r - Float(Int(r))) * Float(100)))
        
        info.text = currentWorkout.info
    }
    func addContainWorkouts()
    {
        if fromW
        {
            CoreDataController.Instance()?.addWorkoutContainWorkout(workoutID: superID, wID: currentWorkout.wid!)
        }
        else if fromC
        {
            CoreDataController.Instance()?.addCourseContainWorkout(courseID: superID, wID: currentWorkout.wid!)
        }
    }
    func deleteContainWorkouts()
    {
        if fromW
        {
            CoreDataController.Instance()?.deleteWorkoutContainWorkout(workoutID: superID, wID: currentWorkout.wid!)
        }
        else if fromC
        {
            CoreDataController.Instance()?.deleteCourseContainWorkout(courseID: superID, wID: currentWorkout.wid!)
        }
    }
    func reloadPreviousTable()
    {
        if fromW
        {
            addWorkPage.workoutListTable.reloadData()
        }
        else if fromC
        {
            addCoursePage.workoutListTable.reloadData()
        }
    }
    // MARK: - TableView
    @IBOutlet weak var workoutListTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentWorkout.containWorkouts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workoutListTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = (currentWorkout.containWorkouts?.array[indexPath.row] as! Workout).name
        return cell
    }
    func tableView(_ tableView:UITableView,editingStyleForRowAt indexPath:IndexPath) ->UITableViewCell.EditingStyle{
        return .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //courseList.remove(at: indexPath.row)
            
            //tableView.deleteRows(at: [indexPath], with: .fade)
            //tableView.reloadData()
        }
        else if editingStyle == .insert{
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let addWorkoutView = storyboard?.instantiateViewController(identifier: "addWorkout")
        {
            let v = addWorkoutView as! AddWorkoutViewController
            v.addWorkPage = self
            v.currentWorkout = (currentWorkout.containWorkouts?.array[indexPath.row] as! Workout)
            show(v, sender: self)
        }
    }
    
    // MARK: - Navigation
    @IBAction func backBtn(_ sender: UIButton) {
        if Int(set.text!) == 0
        {
            print("workout delete \(currentWorkout.wid!)")
            deleteContainWorkouts()
            CoreDataController.Instance()?.deleteWorkout(workoutID: currentWorkout.wid!)
        }
        else
        {
            print("workout edit")
            editWorkout()
        }
        
        reloadPreviousTable()
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

