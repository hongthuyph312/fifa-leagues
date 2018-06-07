//
//  SetNickNameViewController.swift
//  FootballLeagues
//
//  Created by Thuy Phan on 6/8/18.
//  Copyright © 2018 Thuy Phan. All rights reserved.
//

import UIKit

class SetNickNameViewController: OriginalViewController {

    @IBOutlet weak var nickNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    @IBAction func tappedSetNickName(_ sender: UIButton) {
        if nickNameTextField.text?.count != 0 {
            app_delegate.firebaseObject.initUser(nickName: nickNameTextField.text!, onCompletionHandler: {
                UserDefaults.standard.set(self.nickNameTextField.text!, forKey: "nickName")
                let homeViewController = main_storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.present(homeViewController, animated: true, completion: nil)
            })
        } else {
            view.makeToast("Please input nick name", duration: 1.5, position: .center)
        }
    }
    
    //MARK: - UITextField delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= title_max
    }
}
