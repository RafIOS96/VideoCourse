//
//  DataBaseHelper.swift
//  Video Course
//
//  Created by Rafayel Aghayan on 21.04.21.
//

import Foundation
import UIKit
import CoreData

class DataBaseHelper {
    static let shareInstance = DataBaseHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func saveImage(data: Data) {
        let imageInstance = Image(context: context)
        imageInstance.img = data
        do {
            try context.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage() -> [Image] {
        var fetchingImage = [Image]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        do {
            fetchingImage = try context.fetch(fetchRequest) as! [Image]
        } catch {
            print("Error while fetching the image")
        }
        return fetchingImage
    }
}
