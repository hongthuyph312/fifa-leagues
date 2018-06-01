//
//  CommentModel.swift
//  japanese
//
//  Created by Hai Dang Nguyen on 1/2/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import UIKit

class CommentModel: NSObject {
    var threadId    = ""
    var id          = ""
    var content     = ""
    var userName    = ""
    var time        = 0.0
    var like        = ""

    func initComment(threadId: String, id: String, content: String, userName: String, time: Double, like: String) {
        self.threadId       = threadId
        self.id             = id
        self.content        = content
        self.userName       = userName
        self.time           = time
        self.like           = like
    }
}
