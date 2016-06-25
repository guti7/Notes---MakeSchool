//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class DisplayNoteViewController: UIViewController {
    
    var note: Note? // optional Note type - may or maynot contain a value
    // cause we can also add new notes so the not might not be created yet.
    
    

    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteContentTextView: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
    /  Called when a new segue to display a new view will be displayed 
    /  functionality for moving back and forth through screens
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            
            // send the note with the segue! returns reference to the instance of the view destination
            let listController = segue.destinationViewController as! ListNotesTableViewController
            
            if identifier == "Save" {
                print("Save button tapped")
                
                if let note = note {
                    
                    let updateNote = Note()
                    updateNote.title = noteTitleTextField.text ?? ""
                    updateNote.content = noteContentTextView.text ?? ""
                    
                    //listController.tableView.reloadData()
                    
                    RealmHelper.updateNote(note, newNote: updateNote)
                    
                } else { // add new note
                    let newNote = Note()
                    
                    // use of the nil coalescing operator
                    newNote.title = noteTitleTextField.text ?? "" // the outlet is optional String type
                    newNote.content = noteContentTextView.text //?? ""
                    newNote.modTime = NSDate()
                    
                    //listController.notes.append(newNote)
                    RealmHelper.addNote(newNote)
                }
                
                listController.notes = RealmHelper.retriveNotes()
                
            }
        }
    }
    
    
    /**
    /  The system calls this method right before a view
    /  will appear to update the view with necessary data
    /  to be displayed.
    /  
    */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // optional binding technique
        if let note = note {
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        } else {
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }

}
