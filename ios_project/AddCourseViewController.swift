//
//  AddCourseViewController.swift
//  ios_project
//
//  Created by Ann on 2021/6/2.
//

import UIKit

class AddCourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var courseName: UITextField!
    var coursePage: CourseViewController!
    var currentCourse: Course!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Init()
        if currentCourse != nil
        {
            courseName.text = currentCourse.name
        }
        else
        {
            addCourse()
        }
    }
    func Init()
    {
        courseName.text = "new course"
    }
    func addCourse()
    {
        currentCourse = CoreDataController.Instance()?.insertCourse(name: courseName.text!, workouts: [])
    }
    func editCourse()
    {
        CoreDataController.Instance()?.editCourse(courseID: currentCourse.cid!, name: courseName.text, workouts: [])
    }
    
    // MARK: - TableView
    @IBOutlet weak var workoutListTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return currentCourse.containWorkouts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = workoutListTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = (currentCourse.containWorkouts?.array[indexPath.row] as! Workout).name
        
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
            v.addCoursePage = self
            v.currentWorkout = (currentCourse.containWorkouts?.array[indexPath.row] as! Workout)
            show(v, sender: self)
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func backBtn(_ sender: UIButton) {
        if currentCourse.containWorkouts?.count == 0
        {
            print("course delete \(currentCourse.cid!)")
            CoreDataController.Instance()?.deleteCourse(courseID: currentCourse.cid!)
        }
        else
        {
            print("course edit")
            editCourse()
        }
        
        if coursePage != nil
        {
            print("reload")
            coursePage.courseListTable.reloadData()
        }
        self.navigationController?.popViewController(animated: true);
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "addWorkout")
        {
            let workoutPage = segue.destination as! AddWorkoutViewController
            workoutPage.addCoursePage = self
        }
    }
    

}
