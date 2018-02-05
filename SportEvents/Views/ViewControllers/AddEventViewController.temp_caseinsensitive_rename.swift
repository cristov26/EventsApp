//
//  addEventViewController.swift
//  SportEvents
//
//  Created by Cristian Tovar on 2/4/18.
//  Copyright © 2018 Cristian Tovar. All rights reserved.
//

import UIKit

class addEventViewController: UIViewController {
    
    var presenter: AddEventPresenter!

    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var publicSwitch: UISwitch!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var forumTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var initialDateTextField: UITextField!
    @IBOutlet weak var eventTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forumTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectActionButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func didSelectCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func loadPresenter(lastEventId: Int) {
        if presenter == nil {
            presenter = AddEventPresenter(lastEventId: lastEventId)
        }
    }


}

extension addEventViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
