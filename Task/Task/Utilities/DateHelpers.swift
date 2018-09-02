//
//  DateHelpers.swift
//  Task
//
//  Created by Eric Andersen on 8/29/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import Foundation

extension Date {
    
    func stringValue() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        
        return dateFormatter.string(from: self)
    }
}
