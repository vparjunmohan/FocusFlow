//
//  CreateTodoViewModel.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 24/08/24.
//

import Foundation
import SwiftUI

class CreateTodoViewModel: ObservableObject {
    @Published var selectedPriority: PriorityModel = PriorityModel()
}
