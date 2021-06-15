//
//  StopWatchController.swift
//  ios_project
//
//  Created by 陳宥儒 on 2021/6/14.
//

import CoreData

class StopWatchController
{
    var course: Course!
    var courseID: UUID!
    var workoutList: [Workout]
    public var timeLists: [[Float]]
    var recordList: [[Float]]
    var tempRecord: [[Float]]
    var date: String!
    
    init(_courseID: UUID?)
    {
        courseID = _courseID
        course = CoreDataController.Instance()?.getCourse(courseID: courseID!)
        workoutList = (CoreDataController.Instance()?.getWorkoutList(courseID: courseID!))!
        timeLists = []
        recordList = []
        tempRecord = []
        dInit()
        
        var t:[Float] = []
        var r:[Float] = []
        getWorkoutTime(wList: workoutList, tList: &t, rList: &r)
        tempRecord = recordList
    }
    
    func dInit()
    {
        let d = Date.init()
        let f = DateFormatter()
        f.dateFormat = "yyy-MM-dd"
        f.locale = Locale(identifier: "zh_Hant_TW")
        f.timeZone = TimeZone(identifier: "Asia/Taipei")
        date = f.string(from: d)
    }
    func resetRecordList()
    {
        recordList = tempRecord
    }
    func resetRecord(wIndex: Int, lIndex: Int)
    {
        recordList[wIndex][lIndex] = tempRecord[wIndex][lIndex]
    }
    func getWorkoutTime(wList: [Workout], tList: inout [Float], rList: inout [Float])
    {
        for w in wList
        {
            if w.containWorkouts!.count > 0
            {
                for i in 1...w.set
                {
                    getWorkoutTime(wList: w.containWorkouts?.array as! [Workout],tList: &tList, rList: &rList)
                    if i < w.set
                    {
                        tList.append(w.rest)
                        rList.append(-1.0)
                    }
                }
            }
            else
            {
                for _ in 1...w.set
                {
                    tList.append(w.time)
                    rList.append(w.time)
                }
            }
            if workoutList.contains(w)
            {
                timeLists.append(tList)
                recordList.append(rList)
                tList = []
                rList = []
            }
        }
    }
    //MARK: - Record Management
    
    func insertion()
    {
        var i: Int = 0
        print("\(date!)\t\(course.name!)")
        for rlist in recordList
        {
            var s: Int16 = 1
            var tempRList: [Float] = []
            //print("\(i)\t\(workoutList[i].name!)")
            for r in rlist
            {
                if r == -1
                {
                    CoreDataController.Instance()?.insertRecords(_date: date, _cid: courseID, _wid: workoutList[i].wid!, _set: s, _times: tempRList)
                    tempRList.removeAll()
                    s += 1
                }
                else if r == -2
                {
                    tempRList.append(0)
                }
                else
                {
                    tempRList.append(r)
                }
            }
            CoreDataController.Instance()?.insertRecords(_date: date, _cid: courseID, _wid: workoutList[i].wid!, _set: Int16(s), _times: tempRList)
            i += 1;
        }
    }
    
    //MARK: - StopWatch
    
    //status
    var isRunning: Bool = false
    var isRecorded: Bool = false
    var isRest: Bool
    {
        get { return recordList[currentWorkoutIndex][currentLapIndex] == -1 }
    }
    
    //time
    var milliSeconds: Int = 0
    
    //lap info
    var currentWorkoutIndex: Int = 0
    var currentLapIndex: Int = 0
    var currentWorkoutSetCount: Int = 0
    
    func watchInit()
    {
        isRunning = false
        isRecorded = false
        
        currentWorkoutIndex = 0
        currentLapIndex = 0
        currentWorkoutSetCount = 0
        
        milliSeconds = Int(timeLists[currentWorkoutIndex][currentLapIndex]*100)
    }
    func watchStart()
    {
        isRunning = true
    }
    func watchStop()
    {
        isRunning = false
    }
    func watchRecord() -> Float
    {
        isRecorded = true
        recordList[currentWorkoutIndex][currentLapIndex] -= Float(milliSeconds) / 100
        return recordList[currentWorkoutIndex][currentLapIndex]
    }
    func watchErase()
    {
        resetRecord(wIndex: currentWorkoutIndex, lIndex: currentLapIndex)
        isRecorded = false
    }
    func watchReset()
    {
        resetRecordList()
    }
    
    func countDown() -> Bool
    {
        milliSeconds -= 1
        if milliSeconds < 0
        {
            if !isRecorded && !isRest
            {
                recordList[currentWorkoutIndex][currentLapIndex] = -2.0
            }
            currentLapIndex += 1
            if currentLapIndex >= timeLists[currentWorkoutIndex].count
            {
                currentWorkoutIndex += 1
                currentLapIndex = 0
                if currentWorkoutIndex >= timeLists.count
                {
                    print(recordList)
                    insertion()
                }
                else
                {
                    milliSeconds = Int(timeLists[currentWorkoutIndex][currentLapIndex]*100)
                    isRecorded = false
                }
                return false
            }
            milliSeconds = Int(timeLists[currentWorkoutIndex][currentLapIndex]*100)
            isRecorded = false
        }
        return isRunning
    }
    
}
