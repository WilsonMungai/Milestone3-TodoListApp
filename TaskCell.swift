//
//  TaskCell.swift
//  ToDoListApp-Milestone3
//
//  Created by Wilson Mungai on 2022-12-10.
//

import SwiftUI

struct TaskCell: View
{
    // Instance of the date model class
    @EnvironmentObject var dateModel: DateModel
    @ObservedObject var passedTaskItem: TaskItem
    
    var body: some View
    {
        CheckBoxView(passedTaskItem: passedTaskItem)
            .environmentObject(dateModel)
        
        Text(passedTaskItem.name ?? "")
            .padding(.horizontal)
        
        if !passedTaskItem.isCompleted() && passedTaskItem.scheduleTime
        {
            Spacer()
            Text(passedTaskItem.dueDateTimeOnly())
                .font(.footnote)
                .foregroundColor(passedTaskItem.overDueColor())
                .padding(.horizontal)
        }
    }
}

struct TaskCell_Previews: PreviewProvider
{
    static var previews: some View
    {
        TaskCell(passedTaskItem: TaskItem())
    }
}
