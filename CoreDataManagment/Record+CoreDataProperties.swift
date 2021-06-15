//
//  Record+CoreDataProperties.swift
//  ios_project
//
//  Created by 陳宥儒 on 2021/6/16.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var date: String?
    @NSManaged public var lap: Int16
    @NSManaged public var time: Float
    @NSManaged public var set: Int16
    @NSManaged public var course: Course?
    @NSManaged public var workout: Workout?

}

extension Record : Identifiable {

}
