//
//  RealmHelper.swift
//  MakeSchoolNotes
//
//  Created by Guti on 6/24/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    static let realm = try! Realm()
    
    // static helper methods
    
    static func addNote(note: Note) {
        try! realm.write () {
            realm.add(note)
        }
    }
    
    static func deleteNote(note: Note) {
        try! realm.write() {
            realm.delete(note)
        }
    }
    
    static func updateNote(noteToBeUpdated: Note, newNote: Note) {
        // retrive the note, modify its contents, save the new note.
        
        try! realm.write() {
            noteToBeUpdated.title = newNote.title
            noteToBeUpdated.content = newNote.content
            noteToBeUpdated.modTime = newNote.modTime
        }
    }
    
    static func retriveNotes() -> Results<Note> {
        return realm.objects(Note).sorted("modTime", ascending: false)
    }
}
