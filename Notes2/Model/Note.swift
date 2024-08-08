//
//  Note.swift
//  Notes2
//
//  Created by Jozek Andrzej Hajduk Sanchez on 8/08/24.
//

import Foundation
import CoreData
import UIKit

class Note {
    static let shared = Note()
    
    // Context to connect to the DB
    func getContext() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    func saveData(title: String, note: String, date: Date) {
        let context = getContext()
        let entityNote = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: context) as! Notes
        entityNote.title = title
        entityNote.note = note
        entityNote.date = date
        
        do {
            try context.save()
            print("save note")
        } catch let error as NSError {
            print("No save note", error.localizedDescription)
        }
    }
}
