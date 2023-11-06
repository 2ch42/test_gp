//
//  ChoiceView.swift
//  omechu
//
//  Created by 이창현 on 2023/09/20.
//

import SwiftUI

struct CommitView: View {
    @Binding var foods: [Food]
    @Binding var selectedFoodIdx: Int?
    @State private var isShowingNewRoomView = false // State for showing NewRoomView

    var body: some View {
        if selectedFoodIdx != nil {
            VStack {
                Spacer()
                Text("\(foods[selectedFoodIdx!].name)")
                    .font(.headline)
                Image(uiImage: UIImage(data: foods[selectedFoodIdx!].imgData)!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 200)
                Text("음식 선정 완료!")
                    .font(.headline)
                Spacer()
                HStack {
                    Spacer()

                    // NavigationLink to NewRoomView
                    NavigationLink(
                        destination: NewRoomView(),
                        isActive: $isShowingNewRoomView,
                        label: {
                            Button(action: {
                                isShowingNewRoomView = true
                            }) {
                                Text("새로 고르기")
                                    .padding()
                                    .background(Color.gray)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10)
                            }
                        }
                    )

                    Spacer()
                    Button(action: {}) {
                        Text("공유하기")
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
            }
            .padding()
        } else {
            Text("이미지를 불러오는 중...")
        }
    }
}


struct CommitView_Previews: PreviewProvider {
    static var previews: some View {
        CommitView(foods: .constant([Food]()), selectedFoodIdx: .constant(nil))
    }
}
