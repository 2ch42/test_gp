//
//  CommitView.swift
//  omechu
//
//  Created by 이창현 on 2023/09/18.
//

import SwiftUI

struct CommitView: View {
    @Binding var foods: [Food]
    @Binding var selectedFoodIndex1: Int?
    @Binding var selectedFoodIndex2: Int?
    @State var selectedFoodIdx: Int?

    var body: some View {
        if selectedFoodIndex1 != nil, selectedFoodIndex2 != nil {
                List {
                    NavigationLink(destination: ChoiceView(foods: $foods, selectedFoodIdx: $selectedFoodIndex1)) {
                        Button(action: {}) {
                            Text("\(foods[selectedFoodIndex1!].name)")
                        }
                    }
                    NavigationLink(destination: ChoiceView(foods: $foods, selectedFoodIdx: $selectedFoodIndex2)) {
                        Button(action: {}) {
                            Text("\(foods[selectedFoodIndex2!].name)")
                        }
                    }
                }
        } else {
            Text("알 수 없는 오류가 발생했습니다.")
        }
            
    }
}

struct CommitView_Previews: PreviewProvider {
    static var previews: some View {
        CommitView(foods: .constant([Food]()), selectedFoodIndex1: .constant(nil), selectedFoodIndex2: .constant(nil))
    }
}
