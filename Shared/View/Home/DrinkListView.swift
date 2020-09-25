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

    static var previews: some View {
        Group {
            DrinkListView(drinks: drinksData, selection: .constant(1))
                .previewLayout(.sizeThatFits)
            DrinkListView(drinks: drinksData, selection: .constant(2))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier:"ja"))
        }

    }
}
