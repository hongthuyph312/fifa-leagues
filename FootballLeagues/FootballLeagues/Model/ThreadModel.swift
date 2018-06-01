//
//  ThreadModel.swift
//  japanese
//
//  Created by Hai Dang Nguyen on 1/2/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import UIKit

class ThreadModel: NSObject {
    var id          = ""
    var title       = ""
    var content     = ""
    var userName    = ""
    var time        = 0.0
    var lastComment = 0.0
    func initThread(id: String, title: String, content: String, time: Double, userName: String, lastComment: Double) {
        self.id             = id
        self.title          = title
        self.content        = content
        self.time           = time
        self.userName       = userName
        self.lastComment    = lastComment
    }
}
