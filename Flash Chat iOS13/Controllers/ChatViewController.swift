//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Евгений Башун on 19.02.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    var messages: [Message] = []
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.appName
        
        tableView.delegate = self
        tableView.dataSource = self
        messageTextfield.delegate = self
        navigationItem.hidesBackButton = true
        navigationItem.title = Constants.appName
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        networkManager.loadMessages { messages in
            self.messages = messages
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                let indexPath = IndexPath(row: messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath,
                                           at: .bottom,
                                           animated: true)
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        guard let messageBody = messageTextfield.text else { return }
        networkManager.updateDB(with: messageBody)
        messageTextfield.text = ""
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? MessageCell else { return UITableViewCell() }
        cell.label.text = messages[indexPath.row].body
        cell.timeLabel.text = messages[indexPath.row].time
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftAvatarImageView.isHidden = true
            cell.rightAvatarImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.purple)
        } else {
            cell.leftAvatarImageView.isHidden = false
            cell.rightAvatarImageView.isHidden = true
            cell.messageBubble
                .backgroundColor = UIColor(named: Constants.BrandColors.blue)
        }
        
        return cell
        
    }
    
    
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let messageBody = textField.text else { return false }
        networkManager.updateDB(with: messageBody)
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
