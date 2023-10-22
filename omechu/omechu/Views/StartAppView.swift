//
//  MakeRoomView.swift
//  omechu
//
//  Created by 이창현 on 2023/09/17.
//

import SwiftUI

struct StartAppView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("오늘의 메뉴 추천")
                    .font(.title)
                    .foregroundColor(.blue)
                Spacer()
                NavigationLink(destination: NewRoomView()) {
                    Text("음식 고르기 시작!")
                        .padding()
                        .background(.gray)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                Spacer()
                Text("오늘의 메뉴 추천")
            }
            .padding()
        }
    }
}

struct StartAppView_Previews: PreviewProvider {
    static var previews: some View {
        StartAppView()
    }
}
