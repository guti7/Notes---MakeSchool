//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class ListNotesTableViewController: UITableViewController {
    
    
    // properties
    //var notes = [Note]() { // has the data for the notes in array
    // needs to be updated to Realm
    var notes: Results<Note>! { // force unwrap it, tell compiler we don't need a init and we will have it initialized before we try to use it.
        
        // Table view in sync with notes data model
        didSet { // a getter method "property observer"
            tableView.reloadData()
        }
    }
    
    // move to bottom once done
    
    /**
    /  Enable the table view to have additional editing modes,
    /  such as the delete option when you swipe left.
    /
    */
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //notes.removeAtIndex(indexPath.row)
            //tableView.reloadData()
            RealmHelper.deleteNote(notes[indexPath.row]) // Object<Note> behaves similarly to array
            notes = RealmHelper.retriveNotes()
        }
    }
    
    
    // Gets called right before the new view is shown
    // It prepares the information to be displayed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(notes)
        if let identifier = segue.identifier { // what is this?
            if identifier == "displayNote" {
                print("Table view cell tapped")
                
                let indexPath = tableView.indexPathForSelectedRow! // unwrap it
                
                let note = notes[indexPath.row]
                
                let displayNoteController = segue.destinationViewController as! DisplayNoteViewController
                
                displayNoteController.note = note
                
            } else if identifier == "addNote" {
                print("+ button tapped")
            }
        }
    }
    
    @IBAction func unwindToListNotesTableViewController(segue: UIStoryboardSegue) {
        
        // body
        
    }
    
    
    ////////////////////////////////////////////////////////////////////////////\
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = RealmHelper.retriveNotes()
    }
    
    // this is where the fun happens
    /**
    / Returns the number of cells in the table view, i.e. the number of notes
    / present in the notes array.
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return notes.count // the count of the notes in array
    }
    
    /**
    /  Gets called by TableView for every row asking for a cell to populate the row
    /  indexPath is the index of the row for which a cell needs to be provided
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // get a cell
        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath) as! ListNotesTableViewCell // downcast from UITableView to ListNotesTableViewCell which is a subclass via UITableViewCell

        let row = indexPath.row
        let note = notes[row]
        
        cell.noteTitleLabel.text = note.title
        cell.noteModificationTimeLabel.text = note.modTime.convertToString()
        
        return cell
    }
}