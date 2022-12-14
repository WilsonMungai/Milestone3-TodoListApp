//
//  ToDoListApp_Milestone3App.swift
//  ToDoListApp-Milestone3
//
//  Created by Wilson Mungai on 2022-12-10.
//

import SwiftUI

@main
struct ToDoListApp_Milestone3App: App
{
    let persistenceController = PersistenceController.shared

    var body: some Scene
    {
        WindowGroup
        {
            let context = persistenceController.container.viewContext
            let dateModel = DateModel(context)
            
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dateModel)
        }
    }
}
