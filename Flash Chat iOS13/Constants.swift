//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Евгений Башун on 19.02.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation

struct Constants {
    static let appName = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerID = "FromRegistration"
    static let loginID = "FromLogin"
    static let chatID = "Chat"
    static let welcomeID = "Welcome"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
