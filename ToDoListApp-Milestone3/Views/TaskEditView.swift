//
//  TaskEditView.swift
//  ToDoListApp-Milestone3
//
//  Created by Wilson Mungai on 2022-12-10.
//

import SwiftUI

struct TaskEditView: View
{
    // The context
    @Environment(\.managedObjectContext) private var viewContext
    
    // Instance of the date model class
    @EnvironmentObject var dateModel: DateModel
    
    // Navigation
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Variable that passes the task items
    @State var selectedTaskItem: TaskItem?
    @State var taskName: String
    @State var taskNotes: String
    @State var dueDate: Date
    @State var scheduleTime: Bool
    
    // Overrides init functions with passed item and current date parameters
    init(passedTaskItem: TaskItem?, initialDate: Date)
    {
        // Setting up edit mode
        if let taskItem = passedTaskItem
        {
            // Sets the values to the original value
            _taskName = State(initialValue: taskItem.name ?? "")
            _taskNotes = State(initialValue: taskItem.notes ?? "")
            _dueDate = State(initialValue: taskItem.dueDate ?? initialDate)
            _scheduleTime = State(initialValue: taskItem.scheduleTime)
        }
        else
        {
            // Creates a new task
            _taskName = State(initialValue: "")
            _taskNotes = State(initialValue: "")
            _dueDate = State(initialValue: initialDate)
            _scheduleTime = State(initialValue: false)
        }
    }
    
    // Add list view
    var body: some View
    {
        Form
        {
            Section(header: Text("Task"))
            {
                // Task and notes textfields
                TextField("Task Name", text: $taskName)
                TextField("Notes", text: $taskNotes)
            }
            Section(header: Text("Due Date"))
            {
                // Due date toggle
                Toggle("Schedule Time", isOn: $scheduleTime)
                
                // Due date picker
                DatePicker("Due Date", selection: $dueDate, displayedComponents: displayComponents())
            }
            
            // Completed task view section only runs when the task is completed
            if selectedTaskItem?.isCompleted() ?? false
            {
                Section(header: Text("Completed"))
                {
                    Text(selectedTaskItem?.completedDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                        .foregroundColor(.green)
                }
            }
            
            Section()
            {
                Button("Save Task", action: saveTask)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    // Date picker display components
    // Returns date picker components
    func displayComponents() -> DatePickerComponents
    {
        // Retrun time and date if schedule time toggle is on otherwise just return the date
        return scheduleTime ? [.hourAndMinute, .date] : [.date]
    }
    // Save task button
    func saveTask()
    {
        withAnimation
        {
            //If we are in new task item mode
            if selectedTaskItem == nil
            {
                // Creates a new task item and assigns it to our task item
                selectedTaskItem = TaskItem(context: viewContext)
            }
            
            // Set the created task date to the current date state variable
            selectedTaskItem?.created = Date()
            // Assign the name entity to the task name
            selectedTaskItem?.name = taskName
            // Assign the note entity to the task notes state variable
            selectedTaskItem?.notes = taskNotes
            // Assign the dueDate entity to the dueDate state variable
            selectedTaskItem?.dueDate = dueDate
            // Assign the scheduleTime entity to the scheduleTime state variable
            selectedTaskItem?.scheduleTime = scheduleTime
            
            dateModel.saveContext(viewContext)
            
            // Navigates back to the list view
            self.presentationMode.wrappedValue.dismiss()
        }
        
    }
}

struct TaskEditView_Previews: PreviewProvider
{
    static var previews: some View
    {
        TaskEditView(passedTaskItem: TaskItem(), initialDate: Date())
    }
}
