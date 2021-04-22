//
//  LocalStorageModel.swift
//  Video Course
//
//  Created by Rafayel Aghayan on 22.04.21.
//

import Foundation
import CoreData
import UIKit

var arrayCheckedCourse: [Int] = []

var indexArray: [Int: Bool] = [:]
var storedImages: [Image] = []
var savedArray: [String] = []

var stringAsData: String?

class LocalStorageModel: NSObject {
    
    class func saveInLocalStorage(savedArray: [String], fileName: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Title", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        newEntity.setValue(savedArray.description, forKey: fileName)

        do {
            try context.save()
            print("saved")
        } catch  {
            print("error")
        }
    }
    
    class func getFromLocalStorage(fileName: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Title")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                stringAsData = data.value(forKey: fileName) as? String ?? ""
            }
            convertFromString(arrayText: stringAsData ?? "")            
        } catch  {
            print(" error load")
        }
    }
    
    class func convertFromString(arrayText: String) {
        let stringAsData = arrayText.data(using: String.Encoding.utf16)
        let arrayBack: [String] = try! JSONDecoder().decode([String].self, from: stringAsData!)
        savedArray = arrayBack
    }
}
