//
//  TaskViewModel.swift
//  Task ManagementUI
//
//  Created by eyh.mac on 18.09.2023.
//

import SwiftUI

class TaskViewModel: ObservableObject{
    
    @Published var storedTasks: [Task] = [
        Task(taskTitle: "Grocery Shopping", tasDescription: "Buy bread, milk, eggs, and other basic necessities.", taskDate: Date()),
        
        Task(taskTitle: "Exercise", tasDescription: "Exercise for at least 30 minutes.", taskDate: Date()),
        
        Task(taskTitle: "Read a Book", tasDescription: "Read a few chapters during the day.", taskDate: Date()),
        
        Task(taskTitle: "Check Emails", tasDescription: "Check and respond to work or personal emails.", taskDate: Date()),
        
        Task(taskTitle: "Lunch Planning", tasDescription: "Plan a healthy menu for lunch.", taskDate: Date()),
        
        Task(taskTitle: "House Cleaning", tasDescription: "Clean the room, dust, and organize.", taskDate: Date()),
        
        Task(taskTitle: "Learning Time", tasDescription: "Allocate time to learn a new skill or topic.", taskDate: Date())
        
    ]
    
    @Published var currentWeek: [Date] = []
    
    @Published var currentDay: Date = Date()
    
    @Published var filteredTasks: [Task]?
    
    init(){
        fetchCurrentWeek()
    }
    
    func filterTodayTasks(){
        DispatchQueue.global(qos: .userInteractive).async {
            
            let calendar = Calendar.current
            let filtered = self.storedTasks.filter {
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek(){
        
        let today = Date()
        
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else{
            return
        }
        (1...7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                
                currentWeek.append(weekday)
                
            }
        }
    }
    
    func extractDate(date: Date,format: String) -> String {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    func isToday(date: Date)->Bool{
        
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
        
    }
    
    
    
}
