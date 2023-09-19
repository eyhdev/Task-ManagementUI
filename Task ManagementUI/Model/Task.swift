//
//  Task.swift
//  Task ManagementUI
//
//  Created by eyh.mac on 18.09.2023.
//

import SwiftUI

struct Task: Identifiable {
    
    var id = UUID().uuidString
    var taskTitle: String
    var tasDescription: String
    var taskDate: Date
}

