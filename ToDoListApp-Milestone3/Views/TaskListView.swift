//
//  ContentView.swift
//  ToDoListApp-Milestone3
//
//  Created by Wilson Mungai on 2022-12-10.
//

import SwiftUI
import CoreData

struct TaskListView: View
{
    // The context
    @Environment(\.managedObjectContext) private var viewContext
    
    // Instance of the date model class
    @EnvironmentObject var dateModel: DateModel

    // Fetch request to get all the items to be displayed
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<TaskItem>

    var body: some View
    {
        NavigationView
        {
            VStack
            {
                ZStack
                {
                    List
                    {
                        ForEach(items)
                        {
                            taskItem in
                            NavigationLink(destination: TaskEditView(passedTaskItem: taskItem, initialDate: Date())
                                .environmentObject(dateModel))
                            {
                                Text(taskItem.dueDate!, formatter: itemFormatter)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar
                    {
                        ToolbarItem(placement: .navigationBarTrailing)
                        {
                            EditButton()
                        }
                    }
                    AddNewTaskButton()
                        .environmentObject(dateModel)
                }
            }.navigationTitle("Tasks")
        }
    }



    func saveContext(_ context: NSManagedObjectContext)
    {
        do
        {
            try context.save()
        }
        catch
        {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func deleteItems(offsets: IndexSet)
    {
        withAnimation
        {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            dateModel.saveContext(viewContext)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
