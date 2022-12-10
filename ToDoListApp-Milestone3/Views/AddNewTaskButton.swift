//
//  AddNewTaskButton.swift
//  ToDoListApp-Milestone3
//
//  Created by Wilson Mungai on 2022-12-10.
//

import SwiftUI

// Add task button
struct AddNewTaskButton: View
{
    var body: some View
    {
        VStack
        {
            Spacer()
            HStack
            {
                Spacer()
                NavigationLink (destination: TaskEditView())
                {
                    Text("Add Task")
                        .font(.callout)
                }
                .padding(15)
                .foregroundColor(.white)
                .background(Color.purple)
                .cornerRadius(30)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
            }
        }
    }
}

struct AddNewTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskButton()
    }
}
