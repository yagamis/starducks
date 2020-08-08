//
//  MenuTitleView.swift
//  starducks
//
//  Created by MAC on 2020/8/9.
//

import SwiftUI

struct MenuTitle: View {
    var name = ""

    var body: some View {
        Text(name)
            .font(.system(size: 36))
            .foregroundColor(.accentColor)
            .lineLimit(2) //文字两行显示
            .frame(maxWidth: .infinity,minHeight: 125)
    }
}

struct MenuTitle_Previews: PreviewProvider {
    static var previews: some View {
        MenuTitle(name: "草莓🍓星冰乐")
    }
}
