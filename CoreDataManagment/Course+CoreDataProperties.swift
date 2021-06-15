//
//  Course+CoreDataProperties.swift
//  ios_project
//
//  Created by 陳宥儒 on 2021/6/16.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var cid: UUID?
    @NSManaged public var name: String?
    @NSManaged public var containWorkouts: NSOrderedSet?
    @NSManaged public var records: NSSet?

}

// MARK: Generated accessors for containWorkouts
extension Course {

    @objc(insertObject:inContainWorkoutsAtIndex:)
    @NSManaged public func insertIntoContainWorkouts(_ value: Workout, at idx: Int)

    @objc(removeObjectFromContainWorkoutsAtIndex:)
    @NSManaged public func removeFromContainWorkouts(at idx: Int)

    @objc(insertContainWorkouts:atIndexes:)
    @NSManaged public func insertIntoContainWorkouts(_ values: [Workout], at indexes: NSIndexSet)

    @objc(removeContainWorkoutsAtIndexes:)
    @NSManaged public func removeFromContainWorkouts(at indexes: NSIndexSet)

    @objc(replaceObjectInContainWorkoutsAtIndex:withObject:)
    @NSManaged public func replaceContainWorkouts(at idx: Int, with value: Workout)

    @objc(replaceContainWorkoutsAtIndexes:withContainWorkouts:)
    @NSManaged public func replaceContainWorkouts(at indexes: NSIndexSet, with values: [Workout])

    @objc(addContainWorkoutsObject:)
    @NSManaged public func addToContainWorkouts(_ value: Workout)

    @objc(removeContainWorkoutsObject:)
    @NSManaged public func removeFromContainWorkouts(_ value: Workout)

    @objc(addContainWorkouts:)
    @NSManaged public func addToContainWorkouts(_ values: NSOrderedSet)

    @objc(removeContainWorkouts:)
    @NSManaged public func removeFromContainWorkouts(_ values: NSOrderedSet)

}

// MARK: Generated accessors for records
extension Course {

    @objc(addRecordsObject:)
    @NSManaged public func addToRecords(_ value: Record)

    @objc(removeRecordsObject:)
    @NSManaged public func removeFromRecords(_ value: Record)

    @objc(addRecords:)
    @NSManaged public func addToRecords(_ values: NSSet)

    @objc(removeRecords:)
    @NSManaged public func removeFromRecords(_ values: NSSet)

}

extension Course : Identifiable {

}
