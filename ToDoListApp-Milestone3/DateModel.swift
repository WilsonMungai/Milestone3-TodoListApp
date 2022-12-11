import SwiftUI
import CoreData

// Class can be accessed in views to keep track of changes
class DateModel: ObservableObject
{
    
    init(_ context: NSManagedObjectContext)
    {
        
    }
    
    func saveContext(_ context: NSManagedObjectContext)
    {
        do
        {
            try context.save()
        } catch
        {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
}

