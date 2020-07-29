import SwiftUI

struct AddToBagButton: View {

    var body: some View {

            
            HStack(alignment: .center) {
                ZStack {
                    Circle().frame(width: 48, height: 48)
                    Image(systemName: "plus")
                        .font(.system(size: 23))
                        .foregroundColor(.white)
                    
                }

                Text("加到购物袋")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .frame(minWidth: 150)
            }
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(lineWidth: 1)
                    .foregroundColor(Color(.opaqueSeparator))
            )
            .foregroundColor(.accentColor)
            .padding()

        
    }
}


struct AddToBagView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddToBagButton().preferredColorScheme(.dark).previewLayout(.sizeThatFits).environment(\.locale, .init(identifier:"en"))
            AddToBagButton().previewLayout(.sizeThatFits).environment(\.locale, .init(identifier:"zh"))
            AddToBagButton().previewLayout(.sizeThatFits).environment(\.locale, .init(identifier:"ja"))
            
        }
    }
}
