//
//  AddCourseViewController.swift
//  ios_project
//
//  Created by Ann on 2021/6/2.
//

import UIKit

class AddCourseViewController: UIViewController/*,UITableViewDelegate,UITableViewDataSource*/
{
    @IBOutlet weak var courseName: UITextField!
    var workoutList: [Workout] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func addCourse()
    {
        CoreDataController.Instance()?.insertCourse(name: courseName.text!, workouts: workoutList)
    }

    
    // MARK: - TableView
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
 */
    
    // MARK: - Navigation
    
    @IBAction func backBtn(_ sender: UIButton) {
        addCourse()
        self.navigationController?.popViewController(animated: true);
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "addWorkout")
        {
            let workoutPage = segue.destination as! AddWorkoutViewController
        }
    }
    

}
