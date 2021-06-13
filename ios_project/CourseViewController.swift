//
//  CourseViewController.swift
//  ios_project
//
//  Created by Ann on 2021/6/2.
//

import UIKit

class CourseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - TableView
    
    @IBOutlet weak var courseListTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (CoreDataController.Instance()?.getCourseList())!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell = courseListTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = CoreDataController.Instance()?.getCourseList()[indexPath.row].name
        
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
        if let addCourseView = storyboard?.instantiateViewController(identifier: "addCourse")
        {
            let v = addCourseView as! AddCourseViewController
            v.coursePage = self
            v.currentCourse = CoreDataController.Instance()?.getCourseList()[indexPath.row]
            show(v, sender: self)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "addCourse")
        {
            let coursePage = segue.destination as! AddCourseViewController
            coursePage.coursePage = self
        }
    }
    

}
