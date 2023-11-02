//
//  MenuSelectView.swift
//  omechu
//
//  Created by 이창현 on 2023/09/17.
//

import SwiftUI

struct Food: Codable {
    var name: String
    var imgUrl: Data // 이미지 데이터를 저장하는 Data 타입 추가
    var description: String
}


struct ImageSelectView: View {
    @State private var foods: [Food] = []
    @State private var selectedFoodIndex1: Int?
    @State private var selectedFoodIndex2: Int?
    var roomUuid: String

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    if let selectedFoodIndex1 = selectedFoodIndex1 {
                        VStack {
                            Text("\(foods[selectedFoodIndex1].name)")
                                .font(.headline)
                                .foregroundColor(.accentColor)
                            Image(uiImage: UIImage(data: foods[selectedFoodIndex1].imgUrl)!) // 이미지 데이터로 이미지 생성
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 200) // 이미지 크기 조절
                            Text("\(foods[selectedFoodIndex1].description)")
                        }
                    } else {
                        Text("이미지를 불러오는 중...")
                    }
                    if let selectedFoodIndex2 = selectedFoodIndex2 {
                        VStack {
                            Text("\(foods[selectedFoodIndex2].name)")
                                .font(.headline)
                                .foregroundColor(.accentColor)
                            Image(uiImage: UIImage(data: foods[selectedFoodIndex2].imgUrl)!) // 이미지 데이터로 이미지 생성
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 200) // 이미지 크기 조절
                            Text("\(foods[selectedFoodIndex2].description)")
                        }
                    } else {
                        Text("이미지를 불러오는 중...")
                    }
                }
                .padding()
                HStack {
                    Spacer()
                    Button(action: {
                        fetchData()
                    }) {
                        Text("갈아엎기")
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                NavigationLink(destination: CommitView(foods: $foods, selectedFoodIndex1: $selectedFoodIndex1, selectedFoodIndex2: $selectedFoodIndex2)) {
                    Text("확정하기")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(Color.black)
                        .cornerRadius(10)
                }
            }
            .onAppear {
                fetchData()
            }
        }
        .navigationBarHidden(true)
    }
    func fetchData() {
        guard let roomUrl = URL(string: "http://localhost:8080/api/room/\(roomUuid)/foods") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: roomUrl) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response")
                return
            }

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([String: Food].self, from: data)
                    
                    if let food1 = decodedData["food1"], let food2 = decodedData["food2"] {
                        DispatchQueue.main.async {
                            // Update foods array with received food data
                            self.foods = [food1, food2]

                            // Update the UI with received food data
                            self.selectedFoodIndex1 = 0
                            self.selectedFoodIndex2 = 1
                        }
                    } else {
                        print("Failed to decode food data.")
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
}

struct ImageSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelectView(roomUuid: "Prwview Room UUID")
    }
}
