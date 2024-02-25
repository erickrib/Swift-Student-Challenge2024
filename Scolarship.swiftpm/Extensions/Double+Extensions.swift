//
//  Double+Extensions.swift
//  
//
//  Created by Erick Ribeiro on 25/02/24.
//

import SwiftUI

extension Double {
    func formattedDoubleString() -> String {
            let formattedNumber = String(format: "%.2f", self)
            return formattedNumber.replacingOccurrences(of: ".", with: ",")
        }
}
