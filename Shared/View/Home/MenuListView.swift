import SwiftUI

struct MenuListView: View {
    //This view's data source
    var menus : [DrinkMenu]
    
    
    
    @Binding var selection    : Int          // Send to consumer
    @State private var offset : CGFloat = 0  // Offset of the entire swipeview

    let spacing     : CGFloat = 10
    let swipeWidth  : CGFloat = 250
    let swipeHeight : CGFloat = 404

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                        LazyHStack(spacing: spacing) {
                            if !menus.isEmpty {
                                ForEach(menus.indices) { index in
                                    MenuCoverView(imgUrl: menus[index].image[0].url)
                                            .frame(width: swipeWidth, height: swipeHeight)
                                            .scaleEffect(selection == index ? 1 : 0.8)
                                            .animation(.easeOut)
                                            .transition(.slide)
                                }
                            }
                            
                        }
                    }
                    .content.offset(x: offset)
                    .frame(width: swipeWidth, alignment: .leading)
                    .onAppear { //定位到指定序号
                        offset  -= swipeWidth * CGFloat(selection)
                    }
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                offset = value.translation.width - swipeWidth * CGFloat(selection)

                            })
                            .onEnded({ value in

                                if -value.predictedEndTranslation.width > swipeWidth / 2, selection < menus.count - 1 { //easeOut 淡出，结尾减速
                                    withAnimation(.easeOut) {
                                        selection += 1
                                    }
                                }
                                if value.predictedEndTranslation.width > swipeWidth / 2, selection > 0 {
                                    withAnimation(.easeOut) {
                                        selection -= 1
                                    }
                                }
                              
                                withAnimation(.easeOut) {// Let the HStack move
                                    offset = -(swipeWidth + spacing) * CGFloat(selection)
                                }
                            })
                )
        }
    }
}

struct SwipeView_Previews: PreviewProvider {
    struct testSwipeView1 : View {
        @State  private var selection = 1

        var body: some View {
            VStack {
                MenuListView(menus: drinksData[0].menus, selection: $selection)
                Text(selection.description)
            }
        }
    }

    static var previews: some View {
        testSwipeView1()

    }
}
