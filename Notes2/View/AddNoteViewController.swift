//
//  AddNoteViewController.swift
//  Notes2
//
//  Created by Jozek Andrzej Hajduk Sanchez on 8/08/24.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var titleView: UITextField!
    @IBOutlet weak var noteView: UITextView!
    @IBOutlet weak var dateView: UIDatePicker!
    @IBOutlet weak var buttonView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBAction
    @IBAction func onSave(_ sender: UIButton) {
        Note.shared.saveData(title: titleView.text ?? "", note: noteView.text ?? "", date: dateView.date)
    }

}
