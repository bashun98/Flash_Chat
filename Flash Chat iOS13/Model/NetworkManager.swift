//
//  NetworkManager.swift
//  Flash Chat iOS13
//
//  Created by Евгений Башун on 19.02.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import Firebase

protocol NetworkManagerDescription {
    func updateDB(with messageBody: String)
    func loadMessages(completion: @escaping ([Message])->())
}

struct NetworkManager: NetworkManagerDescription {
    
    
    static let shared: NetworkManagerDescription = NetworkManager()
    let db = Firestore.firestore()
    
    func updateDB(with messageBody: String) {
        let date = Date().timeIntervalSince1970
        
        guard let messageSender = Auth.auth().currentUser?.email else { return }
        db.collection(Constants.FStore.collectionName).addDocument(data: [
            Constants.FStore.senderField : messageSender,
            Constants.FStore.bodyField: messageBody,
            Constants.FStore.dateField: date
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            }
        }
    }
    
    func loadMessages(completion: @escaping ([Message])->()) {
        
        
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            
            guard let documents = querySnapshot?.documents else { return }
            
            let messages = documents.compactMap { converter(from: $0) }
            completion(messages)
        }
    }
}

extension NetworkManager {
    func converter(from data: DocumentSnapshot) -> Message? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        guard let document = data.data(),
              let messageSender = document[Constants.FStore.senderField] as? String,
              let messageBody = document[Constants.FStore.bodyField] as? String,
              let time = document[Constants.FStore.dateField] as? Double else {
                  return nil }
        let date = Date(timeIntervalSince1970: time)
        return Message(sender: messageSender,
                       body: messageBody,
                       time: formatter.string(from: date))
    }
}
