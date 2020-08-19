//
//  test654.swift
//  starducks (iOS)
//
//  Created by MAC on 2020/7/26.
//

import SwiftUI

struct test654: View {
    var body: some View {
        Menu {
            Button("预览", action: {})
            Button("另存为PDF", action: {})
            Menu {
                Button("本地下载", action: {})
                Button("云端保存", action: {})
            }
            label: {
                Image(systemName: "arrow.down.doc")
                Text("下载")
            }
        }
        label: {
            Image(systemName: "doc")
            Text("PDF")
        }
       
    }


}

struct test654_Previews: PreviewProvider {
    static var previews: some View {
        test654()
            
    }
}
