//
//  MenuSelectView.swift
//  omechu
//
//  Created by 이창현 on 2023/09/17.
//

import SwiftUI

struct Food: Codable {
    var foodId: Int
    var name: String
    var imgUrl: String // 이미지 데이터를 저장하는 Data 타입 추가
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
                            AsyncImage(url: URL(string: foods[selectedFoodIndex1].imgUrl)!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 180, height: 200)
                                    .onTapGesture {
                                        fetchOne()
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                                    //.resizable()
                                    //.scaledToFit()
                                    //.frame(width: 180, height: 200) // 이미지 크기 조절
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
                            AsyncImage(url: URL(string: foods[selectedFoodIndex2].imgUrl)!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 180, height: 200)
                                    .onTapGesture {
                                        fetchTwo()
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                                //.resizable()
                                //.scaledToFit()
                                //.frame(width: 180, height: 200) // 이미지 크기 조절
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
                    let foods = decodedData.values.compactMap { $0 }
                    DispatchQueue.main.async {
                        self.foods = foods
                        self.selectedFoodIndex1 = 0
                        self.selectedFoodIndex2 = 1
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    func fetchOne() {
        guard let roomUrl = URL(string: "http://localhost:8080/api/room/\(roomUuid)/food") else {
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
                    let singleFood = try JSONDecoder().decode(Food.self, from: data)
                    if !self.foods.isEmpty {
                        DispatchQueue.main.async {
                            self.foods[0] = singleFood
                        }
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    func fetchTwo() {
        guard let roomUrl = URL(string: "http://localhost:8080/api/room/\(roomUuid)/food") else {
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
                    let singleFood = try JSONDecoder().decode(Food.self, from: data)
                    if !self.foods.isEmpty {
                        DispatchQueue.main.async {
                            self.foods[1] = singleFood
                        }
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
