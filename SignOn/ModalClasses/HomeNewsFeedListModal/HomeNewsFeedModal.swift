//
//  HomeNewsFeedModal.swift
//  SignOn
//
//  Created by Callsoft on 16/05/19.
//  Copyright © 2019 mobulous. All rights reserved.
//

import Foundation

class HomeNewsFeedList{
 
    var Id = Int()
    var Name = String()
    var UserName = String()
    var Email = String()
    var FcmIds = String()
    var Url = String()
    var LikeCount = Int()
    var CommentCount = Int()
    var message = String()
    var Date = String()
    var imgPost = String()
    var userID = Int()
    
    var feedComment = String()
    var feedCommentImgUrl = String()
    var feedCommentName = String()
    var feedCommentDate = String()
    
    var isSpam = Bool()
    var isLike = Bool()
    var userReactionId = Int()
    
    init(id:Int, name:String, userName:String,email:String, fcmids:String,url:String,likecount:Int,commentcount:Int, date:String,message:String,imgPost:String,feedComment:String,feedCommentImgUrl:String,feedCommentName:String,feedCommentDate:String,isSpam:Bool,isLike:Bool,userReactionId:Int,userID:Int){
        
        self.Id = id
        self.Name = name
        self.UserName = userName
        self.Email = email
        self.FcmIds = fcmids
        self.Url = url
        self.LikeCount = likecount
        self.CommentCount = commentcount
        self.message = message
        self.Date = date
        self.imgPost = imgPost
        
        self.feedComment = feedComment
        self.feedCommentImgUrl = feedCommentImgUrl
        self.feedCommentName = feedCommentName
        self.feedCommentDate = feedCommentDate
        
        self.isLike = isLike
        self.isSpam = isSpam
        self.userReactionId = userReactionId
        self.userID = userID
        
     }
}
