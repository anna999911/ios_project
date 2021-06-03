//
//  CourseViewController.swift
//  ios_project
//
//  Created by Ann on 2021/6/2.
//

import UIKit

class CourseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    var names = ["1","2","3","4"]
    
    
    @IBOutlet weak var text: UITextField!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text=names[indexPath.row]
        
        return cell
    }
    

    func tableView(_ tableView:UITableView,editingStyleForRowAt indexPath:IndexPath) ->UITableViewCell.EditingStyle{
        return.none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            names.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        else if editingStyle == .insert{
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isEditing = true
        tableView.allowsSelection = true
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
