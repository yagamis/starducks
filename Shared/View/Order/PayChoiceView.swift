import SwiftUI

enum Vendor: CaseIterable {
    case applepay,wepay,alipay
    
    var desc: [String] {
        switch self {
        case .wepay:
            return ["wepay","Wechat"]
        case .alipay:
            return ["alipay","Alipay"]
        case .applepay:
            return ["applepay","Apple Pay"]
        }
    }
}

struct PayChoiceView: View {
    @Binding
    var selection : Int
    
    
    var body: some View {
        HStack(alignment: .bottom) {
            
            ForEach(Vendor.allCases.indices) { (index) in
                VStack {
                    Image(Vendor.allCases[index].desc.first!)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width:60, height: 60)
                    
                    Text(LocalizedStringKey(Vendor.allCases[index].desc[1])).font(.system(size: 20))
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .onTapGesture {
                    selection = index
                }
                .foregroundColor(selection == index ? Color.accentColor : Color("unselect"))
                
            }
            
        }.overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.separator))
        )

    }
}


struct PayChoiceView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            PayChoiceView(selection: .constant(0))
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier:"zh"))
            PayChoiceView(selection: .constant(1))
                .environment(\.locale, .init(identifier:"en"))

        }.previewLayout(.sizeThatFits)
    }
}
