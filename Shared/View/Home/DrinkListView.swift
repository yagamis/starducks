//
//  DrinkListView.swift
//  starducks
//
//  Created by MAC on 2020/7/17.
//

import SwiftUI

struct DrinkListView: View {
    let drinks : [Drink]

    @Binding var selection : Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {

            HStack(spacing: 42,  content: {
                ForEach(drinks.indices) { (index) in
                    DrinkView(drink: drinks[index])
                        .foregroundColor(selection == index ? Color.accentColor : Color("unselect"))
                        .scaleEffect(selection == index ? 1.05 : 1)
                        .onTapGesture {
                            withAnimation(Animation.interactiveSpring()) {
                                selection = index
                            }
                        }
                }
            })
            .frame(height: 108)
            .padding([.leading, .bottom], 15)
        })
    }
}

struct DrinkListView_Previews: PreviewProvider {
    
    //对于有绑定的View，创建一个容器，包含一个实例提供给预览
    struct testView1: View {
        @State var selection :Int
        
        var body: some View {
            VStack {
                DrinkListView(drinks: drinksData, selection: $selection)
                Text(selection.description).font(.largeTitle)
            }
        }
     }

    static var previews: some View {
        Group {
            testView1(selection: 0)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            testView1(selection: 0)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier:"ja"))
            testView1(selection: 0)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier:"zh_hant"))
            testView1(selection: 0)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier:"zh_hans"))
        }

    }
}
