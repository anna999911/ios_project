//
//  CoreDataController.swift
//  ios_project
//
//  Created by 陳宥儒 on 2021/6/12.
//

import UIKit
import CoreData

class CoreDataController
{
    static var instance: CoreDataController? = nil
    public static func Instance() -> CoreDataController?
    {
        if(instance == nil)
        {
            instance = CoreDataController()
        }
        return instance
    }
    
    
    //CoreData setup
    let app = UIApplication.shared.delegate as! AppDelegate
    var viewContext: NSManagedObjectContext!
    
    init()
    {
        viewContext = app.persistentContainer.viewContext
        print(NSPersistentContainer.defaultDirectoryURL())
    }
    
    public func insertCourse(name: String?, workouts: [Workout]) -> Course?
    {
        let course = NSEntityDescription.insertNewObject(forEntityName: "Course", into: viewContext) as! Course
        course.id = UUID.init()
        course.name = name
        for workout in workouts
        {
            course.addToContainWorkouts(workout)
        }
        app.saveContext()
        return course
    }
    public func insertWorkout(name: String?, set: Int16, time: Float, target: Float, rest: Float, info: String?, workouts: [Workout]) -> Workout?
    {
        let workout = NSEntityDescription.insertNewObject(forEntityName: "Workout", into: viewContext) as! Workout
        workout.id = UUID.init()
        workout.name = name
        workout.set = set
        workout.time = time
        workout.target = target
        workout.rest = rest
        workout.info = info
        for w in workouts
        {
            workout.addToContainWorkouts(w)
        }
        
        //app.saveContext()
        return workout
    }
}
