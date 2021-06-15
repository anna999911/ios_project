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
    
    //MARK: - Course
    
    public func insertCourse(name: String?) -> Course!
    {
        let course = NSEntityDescription.insertNewObject(forEntityName: "Course", into: viewContext) as! Course
        course.cid = UUID.init()
        course.name = name

        return course
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
    public func getCourse(courseID: UUID) -> Course!
    {
        var course: Course!
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cid == %@", courseID as CVarArg)
        do{
            course = try viewContext.fetch(fetchRequest).first
            return course
        } catch{
            print(error)
            return course
        }
    }
    public func getWorkoutList(courseID: UUID) ->[Workout]
    {
        var allWorkouts: [Workout] = []
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cid == %@", courseID as CVarArg)
        do{
            let c = try viewContext.fetch(fetchRequest).first
            allWorkouts = c!.containWorkouts?.array as! [Workout]
            return allWorkouts
        } catch{
            print(error)
            allWorkouts = []
            return allWorkouts
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
    
    public func deleteCourse(courseID: UUID)
    {
        let c: Course! = getCourse(courseID: courseID)
        if c != nil
        {
            viewContext.delete(c)
            app.saveContext()
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
    //MARK: - Workout
    
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
    
    public func getWorkoutList(workoutID: UUID) ->[Workout]
    {
        var allWorkouts: [Workout] = []
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wid == %@", workoutID as CVarArg)
        do{
            let w = try viewContext.fetch(fetchRequest).first
            allWorkouts = w!.containWorkouts?.array as! [Workout]
            return allWorkouts
        } catch{
            print(error)
            allWorkouts = []
            return allWorkouts
        }
    }
    public func getWorkout(workoutID: UUID) -> Workout!
    {
        var workout: Workout!
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wid == %@", workoutID as CVarArg)
        do{
            workout = try viewContext.fetch(fetchRequest).first
            return workout
        } catch{
            print(error)
            return workout
        }
    }
    
    public func editWorkout(workoutID: UUID, name: String?, set: Int16, time: Float, target: Float, rest: Float, info: String?)
    {
        let workout: Workout! = getWorkout(workoutID: workoutID)
        var _time = time
        var _target = target
        if workout != nil
        {
            workout.name = name
            workout.set = set
            if workout.containWorkouts!.count>0
            {
                _time = 0
                _target = 0
            }
            workout.time = _time
            workout.target = _target
            workout.rest = rest
            workout.info = info
        }
    }
    public func editWorkout(workoutID: UUID, _workout: Workout)
    {
        editWorkout(workoutID: workoutID, name: _workout.name, set: _workout.set, time: _workout.time, target: _workout.target, rest: _workout.rest, info: _workout.info)
    }
    
    public func deleteWorkout(workoutID: UUID)
    {
        let w: Workout! = getWorkout(workoutID: workoutID)
        if  w != nil
        {
            viewContext.delete(w)
        }
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
    //MARK: - Record
    
    public func insertRecord(_date: String, _cid: UUID, _wid: UUID, _set: Int16, _lap: Int16, _time: Float)
    {
        let r = NSEntityDescription.insertNewObject(forEntityName: "Record", into: viewContext) as! Record
        r.date = _date
        r.lap = _lap
        r.set = _set
        r.time = _time
        r.course = getCourse(courseID: _cid)
        r.workout = getWorkout(workoutID: _wid)
        
        app.saveContext()
    }
    public func insertRecords(_date: String, _cid: UUID, _wid: UUID,  _set: Int16, _times: [Float])
    {
        /*
        if getWorkout(workoutID: _wid).set != _times.count
        {
            return
        }
        */
        var l = 1
        for _t in _times
        {
            insertRecord(_date: _date, _cid: _cid, _wid: _wid, _set: _set, _lap: Int16(l), _time: _t)
            l += 1
        }
        
        app.saveContext()
    }
    public func editRecord(_date: String, _cid: UUID, _wid: UUID,  _set: Int16, _lap: Int16, _time: Float)
    {
        
    }
    public func deleteRecord(_date: String, _cid: UUID, _wid: UUID,  _set: Int16, _lap: Int16)
    {
        let r: Record! = getRecord(_date: _date, _cid: _cid, _wid: _wid, _set: _set, _lap: _lap)
        if  r != nil
        {
            viewContext.delete(r)
        }
    }
    public func getRecord(_date: String, _cid: UUID, _wid: UUID,  _set: Int16, _lap: Int16) -> Record!
    {
        var record: Record!
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "course.cid == %@ && workout.wid == %@ && date == %@ && set == %@ && lap == %@", _cid as CVarArg, _wid as CVarArg, _date as CVarArg, _set, _lap)
        do{
            record = try viewContext.fetch(fetchRequest).first
            return record
        } catch{
            print(error)
            return record
        }
    }
    public func getRecordList(_date: String, _cid: UUID, _wid: UUID) -> [Record]
    {
        var records: [Record] = []
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "course.cid == %@ && workout.wid == %@ && date == %@", _cid as CVarArg, _wid as CVarArg, _date as CVarArg)
        let sort = NSSortDescriptor(key: "lap", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do{
            records = try viewContext.fetch(fetchRequest)
            return records
        } catch{
            print(error)
            return records
        }
    }
    
}


