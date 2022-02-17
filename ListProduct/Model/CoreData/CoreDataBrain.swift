//
//  CoreDataBrain.swift
//  ListProduct
//
//  Created by Maul on 17/02/22.
//

import CoreData
import UIKit

class CoreDataBrain {
    /// Core Data context from UIApplication
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    /**
     This method use for saving data to Core Data
    */
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving data")
        }
    }
}
