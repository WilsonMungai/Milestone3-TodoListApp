//
//  CheckBoxView.swift
//  ToDoListApp-Milestone3
//
//  Created by Wilson Mungai on 2022-12-10.
//

import SwiftUI

struct CheckBoxView: View
{
    // Instance of the date model class
    @EnvironmentObject var dateModel: DateModel
    // Stores and passes the task item
    @ObservedObject var passedTaskItem: TaskItem
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View
    {
        Image(systemName: passedTaskItem.isCompleted() ? "checkmark.circle.fill" : "circle")
            .foregroundColor(passedTaskItem.isCompleted() ? .green: .secondary)
            .onTapGesture
            {
                withAnimation
                {
                    if !passedTaskItem.isCompleted()
                    {
                        passedTaskItem.completedDate = Date()
                        dateModel.saveContext(viewContext)
                    }
                }
            }
    }
}

struct CheckBoxView_Previews: PreviewProvider
{
    static var previews: some View
    {
        CheckBoxView(passedTaskItem: TaskItem())
    }
}
