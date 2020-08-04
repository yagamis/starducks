//
//  test234.swift
//  starducks
//
//  Created by MAC on 2020/7/25.
//

import SwiftUI

struct test234: View {
    @State private var isPresented = false

        var body: some View {
            Button("Present!") {
                self.isPresented.toggle()
            }
            .fullScreenCover(isPresented: $isPresented, content: FullScreenModalView.init)
        }
}

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("This is a modal view")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct test234_Previews: PreviewProvider {
    static var previews: some View {
        test234()
    }
}
