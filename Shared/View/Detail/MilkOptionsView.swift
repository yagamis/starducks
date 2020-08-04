import SwiftUI

struct MilkOptionsView: View {
    @Binding
    var selection : Int
    var options : [MilkOption]

    var body: some View {
        VStack(alignment: .leading) {
            
            ForEach(options.indices) { (index) in
                HStack(spacing: 25) {
                    Image(systemName:selection == index ? "checkmark.square.fill" : "square")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .foregroundColor(selection == index ? Color.accentColor : Color("unselect"))
                   
                    Text(LocalizedStringKey(options[index].name))
                        .font(.system(size: 20))
//                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.accentColor)
                }
                .padding()
                .onTapGesture {
                    selection = index
                }
                if ( index != options.count - 1) {
                    Divider()
                    .padding(.horizontal)
                        
                }
               
            }
            
        }.overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.separator))
        )

    }
}


struct MilkOptionView_Previews: PreviewProvider {
    
    struct testView1: View {
        @State var selection :Int
        var body: some View {
            VStack {
                MilkOptionsView(selection: $selection, options: drinksData[0].menus[1].milk)
                Text(selection.description)
            }
        }
    }
    
    static var previews: some View {
        Group {
            testView1(selection: 0)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .environment(\.locale, .init(identifier:"zh"))
            testView1(selection: 1)
                .previewLayout(.sizeThatFits)
                .environment(\.locale, .init(identifier:"en"))

        }
    }
}

