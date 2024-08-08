//
//  HomeViewController.swift
//  Notes2
//
//  Created by Jozek Andrzej Hajduk Sanchez on 8/08/24.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var table: UITableView!
    
    
    // MARK: - Variables
    private var notes = [Notes]()
    private var fetchResultController: NSFetchedResultsController<Notes>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
        
        showNotes()
    }

}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {}


// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
        
}


// MARK: - NSFetchedResultsControllerDelegate
extension HomeViewController: NSFetchedResultsControllerDelegate {
    func showNotes() {
        let context = Note.shared.getContext()
        let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest() // Get the notes saved
        // Sort data
        let orderTitle = NSSortDescriptor(key: "title", ascending: true) // Order by title
        fetchRequest.sortDescriptors = [orderTitle]
        
        // Create the controller of the fetch data
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch() // Try fetching data
            notes = fetchResultController.fetchedObjects! // Set data into array of data
        } catch let error as NSError {
            print("Error getting data", error.localizedDescription)
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        // We set that the table is searching for updates
        table.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        // We set that the table stop searching for updates
        table.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        // Validate the action we made in the fetch controller to update the table and the data
        switch type {
        case .insert:
            self.table.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            self.table.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            self.table.reloadRows(at: [indexPath!], with: .fade)
        default:
            self.table.reloadData()
        }
        
        self.notes = controller.fetchedObjects as! [Notes] // Load again the data into the array
    }
}
