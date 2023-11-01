//
//  NewRoomView.swift
//  omechu
//
//  Created by 이창현 on 2023/09/18.
//

import SwiftUI

struct NewRoomView: View {
    @State private var foods: [Food] = []
    @State private var selectedFoodIndex1: Int?
    @State private var selectedFoodIndex2: Int?
    var body: some View {
        VStack {
            Text("먹을 음식을 골라보세요!")
                .font(.title)
            Spacer()
                .font(.title)
            ImageSelectView()
            Spacer()
        }
        .padding()
    }
}

struct NewRoomView_Previews: PreviewProvider {
    static var previews: some View {
        NewRoomView()
    }
}
