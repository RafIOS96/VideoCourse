//
//  CourseModel.swift
//  Video Course
//
//  Created by Rafayel Aghayan on 19.04.21.
//

import Foundation
import Alamofire

var userListFullInfo = NSMutableArray()

var Results: [Any] = []
var ResultDictinoary: NSDictionary!
var selectedDictionary: NSDictionary!

var type: String!
var thumb: String!
var courseTitle: String!
var text: String!
var videoURL: String!

class CourseModel: NSObject {
    
    class func getCourseList() {

        AF.request(course_url, method: .get).responseJSON { (response) in
            if let responseValue = response.value as! [Any]? {
                Results = responseValue
                
                for i in 0..<Results.count {
                    ResultDictinoary = Results[i] as? NSDictionary
                    userListFullInfo.insert(ResultDictinoary ?? [], at: i)
                    savedArray.append(ResultDictinoary["title"] as! String)
                }
                
                if storedImages.count == 0 {
                    LocalStorageModel.saveInLocalStorage(savedArray: savedArray, fileName: "titleArrayAsString")
                }
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadTableView"), object: nil)
            }
        }
    }
    
    class func setUserData(fromMutableArray: NSMutableArray, indexPath: Int) {
                
        selectedDictionary = fromMutableArray[indexPath] as? NSDictionary
        
        type = selectedDictionary.object(forKey: "type") as? String
        
        thumb = selectedDictionary.object(forKey: "thumb") as? String

        courseTitle = selectedDictionary.object(forKey: "title") as? String

        text = selectedDictionary.object(forKey: "text") as? String

        videoURL = selectedDictionary.object(forKey: "url") as? String
    }
}
