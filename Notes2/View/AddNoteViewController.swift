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
    
    // MARK: - Variables
    var note : Notes?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setFieldsValues()
        validateButtonState(buttonEnabled: note != nil)
    }
    
    func setFieldsValues() {
        self.title = note != nil ? "Edit note" : "Add note"
        titleView.text = note?.title
        noteView.text = note?.note
        dateView.date = note?.date ?? Date()
    }
    
    // MARK: - IBAction
    @IBAction func onSave(_ sender: UIButton) {
        if note == nil {
            Note.shared.saveData(title: titleView.text ?? "", note: noteView.text ?? "", date: dateView.date)
        } else {
            Note.shared.editData(title: titleView.text ?? "", note: noteView.text ?? "", date: dateView.date, noteData: note!)
        }
        // Go back to previus page
        navigationController?.popViewController(animated: true)
    }
    
    func changeButtonState(isEnabled: Bool = false) {
        buttonView.isEnabled = isEnabled
        buttonView.backgroundColor = isEnabled ? .systemTeal : .systemGray2
    }
    
    func validateButtonState(buttonEnabled: Bool) {
        changeButtonState(isEnabled: buttonEnabled)
        // Create an observable to validate data and set values
        titleView.addTarget(self, action: #selector(validateTextField), for: .editingChanged)
    }

    @objc func validateTextField(sender: UITextField) {
        guard let titleData = titleView.text, !titleData.isEmpty else {
            changeButtonState()
            return
        }
        changeButtonState(isEnabled: true)
    }
}
