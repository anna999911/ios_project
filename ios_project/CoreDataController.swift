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
    
    public func insertCourse(name: String?) -> Course!
    {
        let course = NSEntityDescription.insertNewObject(forEntityName: "Course", into: viewContext) as! Course
        course.cid = UUID.init()
        course.name = name

        return course
    }
    public func insertWorkout(name: String?, set: Int16, time: Float, target: Float, rest: Float, info: String?) -> Workout!
    {
        let workout = NSEntityDescription.insertNewObject(forEntityName: "Workout", into: viewContext) as! Workout
        workout.wid = UUID.init()
        workout.name = name
        workout.set = set
        workout.time = time
        workout.target = target
        workout.rest = rest
        workout.info = info
        
        return workout
    }
    public func insertWorkout(workout: Workout) -> Workout!
    {
        let w: Workout! = workout
        
        return insertWorkout(name: w.name, set: w.set, time: w.time, target: w.target, rest: w.rest, info: w.info)
    }
    public func getCourseList() ->[Course]
    {
        var allCouses: [Course] = []
        do{
            allCouses = try viewContext.fetch(Course.fetchRequest()) as! [Course]
            return allCouses
        } catch{
            print(error)
            allCouses = []
            return allCouses
        }
    }
    public func getWorkoutList(courseID: UUID) ->[Workout]
    {
        var allWorkouts: [Workout] = []
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cid == %@", courseID as CVarArg)
        do{
            let c = try viewContext.fetch(fetchRequest)[0]
            allWorkouts = c.containWorkouts?.array as! [Workout]
            return allWorkouts
        } catch{
            print(error)
            allWorkouts = []
            return allWorkouts
        }
    }
    public func getWorkoutList(workoutID: UUID) ->[Workout]
    {
        var allWorkouts: [Workout] = []
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wid == %@", workoutID as CVarArg)
        do{
            let w = try viewContext.fetch(fetchRequest)[0]
            allWorkouts = w.containWorkouts?.array as! [Workout]
            return allWorkouts
        } catch{
            print(error)
            allWorkouts = []
            return allWorkouts
        }
    }
    public func getCourse(courseID: UUID) -> Course!
    {
        var course: Course!
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cid == %@", courseID as CVarArg)
        do{
            course = try viewContext.fetch(fetchRequest)[0]
            return course
        } catch{
            print(error)
            return course
        }
    }
    public func getWorkout(workoutID: UUID) -> Workout!
    {
        var workout: Workout!
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wid == %@", workoutID as CVarArg)
        do{
            workout = try viewContext.fetch(fetchRequest)[0]
            return workout
        } catch{
            print(error)
            return workout
        }
    }
    public func editCourse(courseID: UUID, name: String?)
    {
        let course: Course! = getCourse(courseID: courseID)
        
        if(course != nil)
        {
            course.name = name
            app.saveContext()
        }
    }
    public func editCourse(courseID: UUID, _course: Course)
    {
        editCourse(courseID: courseID, name: _course.name)
    }
    public func editWorkout(workoutID: UUID, name: String?, set: Int16, time: Float, target: Float, rest: Float, info: String?)
    {
        let workout: Workout! = getWorkout(workoutID: workoutID)
        if workout != nil
        {
            workout.name = name
            workout.set = set
            workout.time = time
            workout.target = target
            workout.rest = rest
            workout.info = info
        }
    }
    public func editWorkout(workoutID: UUID, _workout: Workout)
    {
        editWorkout(workoutID: workoutID, name: _workout.name, set: _workout.set, time: _workout.time, target: _workout.target, rest: _workout.rest, info: _workout.info)
    }
    public func deleteCourse(courseID: UUID)
    {
        let c: Course! = getCourse(courseID: courseID)
        if c != nil
        {
            viewContext.delete(c)
            app.saveContext()
        }
    }
    public func deleteWorkout(workoutID: UUID)
    {
        let w: Workout! = getWorkout(workoutID: workoutID)
        if  w != nil
        {
            viewContext.delete(w)
        }
    }
    public func addCourseContainWorkout(courseID: UUID, wID: UUID)
    {
        let c: Course! = getCourse(courseID: courseID)
        
        c.addToContainWorkouts(getWorkout(workoutID: wID))
    }
    public func deleteCourseContainWorkout(courseID: UUID, wID: UUID)
    {
        let c: Course! = getCourse(courseID: courseID)
        
        c.removeFromContainWorkouts(getWorkout(workoutID: wID))
    }
    public func addWorkoutContainWorkout(workoutID: UUID, wID: UUID)
    {
        let w: Workout! = getWorkout(workoutID: workoutID)
        
        w.addToContainWorkouts(getWorkout(workoutID: wID))
    }
    public func deleteWorkoutContainWorkout(workoutID: UUID, wID: UUID)
    {
        let w: Workout! = getWorkout(workoutID: workoutID)
        
        w.removeFromContainWorkouts(getWorkout(workoutID: wID))
    }
}
