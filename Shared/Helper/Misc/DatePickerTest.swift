//
//  DatePickerTest.swift
//  starducks
//
//  Created by MAC on 2020/7/22.
//

import SwiftUI

struct DatePickerTest: View {
    @State private var birthday = Date()
    @State private var alarm = Date()
    
    var body: some View {
        Group {
            DatePicker(selection: $birthday, in: ...Date(), displayedComponents: .date) {
                Text("Birthday")
            }
            

            DatePicker("Alarm", selection: $alarm, displayedComponents: .hourAndMinute)
        }
    }
}

struct DatePickerTest_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerTest()
    }
}
