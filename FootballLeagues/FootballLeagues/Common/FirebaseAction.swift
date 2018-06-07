//
//  FirebaseAction.swift
//  LocationTracking
//
//  Created by Nguyen Hai Dang on 6/17/17.
//  Copyright © 2017 Nguyen Hai Dang. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class FirebaseAction: NSObject {
    
    lazy var ref: DatabaseReference = Database.database().reference()

    func initFirebase() {
        FirebaseApp.configure()
        Database.database().reference()
        GADMobileAds.configure(withApplicationID: kApplicationId)
    }
    
    func getTimestamp() {
        let serverTimestamp = ServerValue.timestamp()
        var resultRef: DatabaseReference = Database.database().reference()

        resultRef = ref.child("discuss").child("threads")
        //comform to waiting share property
        resultRef.childByAutoId().setValue(serverTimestamp)
    }
    
    //MARK: - USERS
    
    func updateNickName() {
        var nickName = "Ẩn danh"
        if UserDefaults.standard.object(forKey: "nickName") != nil {
            nickName = UserDefaults.standard.object(forKey: "nickName") as! String
        }
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("users")
        //comform to waiting share property
    resultRef.child((UIDevice.current.identifierForVendor?.uuidString)!).child("nickName").setValue(nickName)
    }
    
    func getUser(max: NSInteger, onCompletionHandler: @escaping ([String : String]) -> ()) {
        ref.child("users").queryLimited(toLast: UInt(max)).observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String : String] ?? [:]
        
            onCompletionHandler(snapDict)
        })
    }
    
    func addPoint(point: Int) {
        var nickName = "Ẩn danh"
        if UserDefaults.standard.object(forKey: "nickName") != nil {
            nickName = UserDefaults.standard.object(forKey: "nickName") as! String
        }
        var resultRef: DatabaseReference = Database.database().reference()
        ref.child("users").child(kUUID).child("point").observeSingleEvent(of: .value, with: { (snapshot) in
            if let currentPoint = snapshot.value {
                return
            }
            resultRef.child(kUUID).child("point").setValue(currentPoint + point)
        })
    }
    
    //MARK: - THREADS
    
    func createNewThread(title: String, content: String, onCompletionHandler: @escaping () -> ()) {
        //comform to contact id
        let serverTimestamp = ServerValue.timestamp()
        
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("discuss").child("threads")
        //comform to waiting share property
        resultRef.childByAutoId().setValue(["title": title, "content": content, "userName": (UIDevice.current.identifierForVendor?.uuidString)!,"time": serverTimestamp, "lastComment": serverTimestamp])
        onCompletionHandler()
    }
    
    func editThread(threadId: String, newTitle: String) {
        ref.child("discuss").child("threads").child(threadId).setValue(newTitle)
    }
    
    func getThread(max: NSInteger, onCompletionHandler: @escaping ([ThreadModel]) -> ()) {
        self.getUser(max: 10000, onCompletionHandler: { userDict in
            self.ref.child("discuss").child("threads").queryLimited(toLast: UInt(max)).observe(.value, with: { (snapshot) in
                let snapDict = snapshot.value as? [String : AnyObject] ?? [:]
                var threadArray = [ThreadModel]()
                for dict in snapDict as! [String: [String: AnyObject]]{
                    let thread = ThreadModel()
                    
                    let title       = dict.value["title"] != nil ? dict.value["title"] as! String : ""
                    let content     = dict.value["content"] != nil ? dict.value["content"] as! String : ""
                    let userName    = dict.value["userName"] != nil ? dict.value["userName"] as! String : "Ẩn danh"
                    let time        = dict.value["time"] as! Double
                    let lastComment = dict.value["lastComment"] as! Double

                    thread.initThread(id: dict.key, title: title, content: content, time: time, userName: userDict[userName]!, lastComment: lastComment)
                    if threadArray.count > 0 {
                        threadArray.insert(thread, at: 0)
                    } else {
                        threadArray.append(thread)
                    }
                }
                onCompletionHandler(threadArray.sorted(by: {$0.lastComment > $1.lastComment}))
            })
        })
    }
    
    //MARK: - COMMENTS
    
    func createNewComment(threadId: String, comment: String, onCompletionHandler: @escaping () -> ()) {
        //comform to contact id
        let serverTimestamp = ServerValue.timestamp()
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("discuss").child("comment").child(threadId)
        //comform to waiting share property

        let commentDict = ["userName": (UIDevice.current.identifierForVendor?.uuidString)!, "content":comment, "time":serverTimestamp, "like": ""] as [String : Any]
        resultRef.childByAutoId().setValue(commentDict)
        
        //update last comment time
        ref.child("discuss").child("threads").child(threadId).child("lastComment").setValue(serverTimestamp)
        onCompletionHandler()
    }
    
    func deleteComment(threadId: String, commentId: String, onCompletionHandler: @escaping () -> ()) {
        ref.child("discuss").child("comment").child(threadId).child(commentId).removeValue()
    }
    
    func editComment(threadId: String, commentId:String, newComment: String) {
        ref.child("discuss").child("comment").child(threadId).child(commentId).setValue(newComment)
    }
    
    func getComment(threadId: String, onCompletionHandler: @escaping ([CommentModel]) -> ()) {
        self.getUser(max: 10000, onCompletionHandler: { userDict in
            self.ref.child("discuss").child("comment").child(threadId).queryOrderedByKey().observe(.value, with: { (snapshot) in
                let snapDict = snapshot.value as? [String : AnyObject] ?? [:]
                var commentArray = [CommentModel]()
                for dict in snapDict as! [String: [String: AnyObject]]{
                    let comment = CommentModel()
                    let detail: [String: AnyObject] = dict.value
                    
                    let content     = detail["content"] != nil ? detail["content"] as! String : ""
                    let userName    = detail["userName"] != nil ? detail["userName"] as! String : ""
                    let time        = detail["time"] as! Double
                    let like        = detail["like"] as! String
                    
                    comment.initComment(threadId: dict.key, id: dict.key, content: content, userName: userDict[userName]!, time: time, like: like)
                    commentArray.append(comment)
                }
                
                onCompletionHandler(commentArray.sorted(by: {$0.id < $1.id}))
            })
        })
    }
    
    func editCommentLike(threadId: String, commentId:String, newLike: String) {
        ref.child("discuss").child("comment").child(threadId).child(commentId).child("like").setValue(newLike)
    }
    
    // MARK: - Clubs
    func getResultList(onCompletionHandler: @escaping ([ResultModel]) -> ()) {
        ref.child("result_list").observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String: [String : AnyObject]] ?? [:]
            var resultArray = [ResultModel]()
            for resultDict in snapDict {
                let result = ResultModel()
                
                result.initResultModel(resultDict: resultDict.value)
                resultArray.append(result)
            }
            
            onCompletionHandler(resultArray.sorted{$0.time < $1.time})
        })
    }
    
    // MARK: - Clubs
    func getClubList(onCompletionHandler: @escaping ([ClubModel]) -> ()) {
        ref.child("club_list").observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String: [String : AnyObject]] ?? [:]
            var clubArray = [ClubModel]()
            for clubDict in snapDict {
                let club = ClubModel()
                
                club.initClubModel(club: clubDict.value)
                clubArray.append(club)
            }
            
            onCompletionHandler(clubArray)
        })
    }
    
    // MARK: - Clubs
    func getPlayerList(clubId: String, onCompletionHandler: @escaping ([PlayerModel]) -> ()) {
        ref.child("player_list").child(clubId).observe(.value, with: { (snapshot) in
            let snapDict = snapshot.value as? [String: [String : AnyObject]] ?? [:]
            var playerArray = [PlayerModel]()
            for playerDict in snapDict {
                let player = PlayerModel()
                
                player.initPlayerModel(playerDict: playerDict.value)
                playerArray.append(player)
            }
            onCompletionHandler(playerArray)
        })
    }
    
    func getDoctorComment(doctorId: String, onCompletionHandler: @escaping ([CommentModel]) -> ()) {
        self.getUser(max: 10000, onCompletionHandler: { userDict in
            self.ref.child("doctor").child(doctorId).queryOrderedByKey().observe(.value, with: { (snapshot) in
                let snapDict = snapshot.value as? [String : AnyObject] ?? [:]
                var commentArray = [CommentModel]()
                for dict in snapDict as! [String: [String: AnyObject]]{
                    let comment = CommentModel()
                    let detail: [String: AnyObject] = dict.value
                    
                    let content     = detail["content"] != nil ? detail["content"] as! String : ""
                    let userName    = detail["userName"] != nil ? detail["userName"] as! String : ""
                    let time        = detail["time"] as! Double
                    let like        = detail["like"] as! String
                    
                    comment.initComment(threadId: dict.key, id: dict.key, content: content, userName: userDict[userName]!, time: time, like: like)
                    commentArray.append(comment)
                }
                
                onCompletionHandler(commentArray.sorted(by: {$0.id < $1.id}))
            })
        })
    }
    
    func createDoctorComment(doctorId: String, comment: String, onCompletionHandler: @escaping () -> ()) {
        //comform to contact id
        let serverTimestamp = ServerValue.timestamp()
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("doctor").child(doctorId)
        //comform to waiting share property
        let commentDict = ["userName": (UIDevice.current.identifierForVendor?.uuidString)!, "content":comment, "time":serverTimestamp, "like": ""] as [String : Any]
        resultRef.childByAutoId().setValue(commentDict)
        onCompletionHandler()
    }
    
    func editDoctorCommentLike(doctorId: String, commentId:String, newLike: String) {
        ref.child("doctor").child(doctorId).child(commentId).child("like").setValue(newLike)
    }
    
    func rankDoctor(doctorId: String, star: String,rank: String, onCompletionHandler: @escaping () -> ()) {
        //comform to contact id
        var resultRef: DatabaseReference = Database.database().reference()
        resultRef = ref.child("doctor_list").child(doctorId)
        //comform to waiting share property
        resultRef.child("star").setValue(star)
        resultRef.child("rank").setValue(rank)
        onCompletionHandler()
    }
}
