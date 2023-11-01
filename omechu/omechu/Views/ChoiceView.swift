//
//  ChoiceView.swift
//  omechu
//
//  Created by 이창현 on 2023/09/20.
//

import SwiftUI

struct ChoiceView: View {
    @Binding var foods: [Food]
    @Binding var selectedFoodIdx: Int?
    
    var body: some View {
        if selectedFoodIdx != nil {
            VStack {
                Spacer()
                Text("\(foods[selectedFoodIdx!].name)")
                    .font(.headline)
                Image(uiImage: UIImage(data: foods[selectedFoodIdx!].imgUrl)!) // 이미지 데이터로 이미지 생성
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 200) // 이미지 크기 조절
                Text("음식 선정 완료!")
                    .font(.headline)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("새로 고르기")
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                    }
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

struct ChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceView(foods: .constant([Food]()), selectedFoodIdx: .constant(nil))
    }
}
