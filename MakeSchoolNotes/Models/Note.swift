//
//  Note.swift
//  MakeSchoolNotes
//
//  Created by Guti on 6/24/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift


// to use realm mobile database framework there changes need to be made
// imort RealmSwift
// inherit Realm Object class
// all variables need to be declared dynamic
class Note: Object {
    dynamic var title = ""
    dynamic var content = ""
    dynamic var modTime = NSDate() // instantiated, not defined
}