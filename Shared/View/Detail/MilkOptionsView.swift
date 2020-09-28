import SwiftUI

struct MilkOptionsView: View {
    @Binding var selection : Int
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
                    Spacer()
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
    
    static var previews: some View {

            MilkOptionsView(selection: .constant(0), options: drinksData[0].menus[1].milk)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)

    }
}

