//
//  MenuSelectView.swift
//  omechu
//
//  Created by 이창현 on 2023/09/17.
//

import SwiftUI

struct Food: Codable {
    var name: String
    var imgData: Data // 이미지 데이터를 저장하는 Data 타입 추가
    var description: String
}


struct ImageSelectView: View {
    @State private var foods: [Food] = []
    @State private var selectedFoodIndex1: Int?
    @State private var selectedFoodIndex2: Int?

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    if let selectedFoodIndex1 = selectedFoodIndex1 {
                        VStack {
                            Text("\(foods[selectedFoodIndex1].name)")
                                .font(.headline)
                                .foregroundColor(.accentColor)
                            Image(uiImage: UIImage(data: foods[selectedFoodIndex1].imgData)!) // 이미지 데이터로 이미지 생성
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
                            Image(uiImage: UIImage(data: foods[selectedFoodIndex2].imgData)!) // 이미지 데이터로 이미지 생성
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
                NavigationLink(destination: SelectView(foods: $foods, selectedFoodIndex1: $selectedFoodIndex1, selectedFoodIndex2: $selectedFoodIndex2)) {
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
        // 이미지 데이터를 미리 다운로드하고 배열에 저장
        let sampleFoods: [Food] = [
                Food(name: "짜장면", imgData: try! Data(contentsOf: URL(string: "https://i.namu.wiki/i/zLCSMHVvvt9_ZJyb33kImeEfmrBewsgNll9AyPyVcyNNX2frg1svs7I-nrm-seExLN7BcJ__RJMJCGKDIUkgPg.webp")!), description: "어제 점심에 가장 많이 먹은 음식"),
                Food(name: "짬뽕", imgData: try! Data(contentsOf: URL(string: "https://wooltariusa.com/cdn/shop/products/55.jpg?v=1684855939&width=1400")!), description: "오늘 점심에 가장 많이 먹은 음식"),
                Food(name: "볶음밥", imgData: try! Data(contentsOf: URL(string: "https://recipe1.ezmember.co.kr/cache/recipe/2022/01/06/baf96f7e006b71ce430605b45b828f231.jpg")!), description: "지난 목요일 저녁에 가장 많이 먹은 음식"),
                Food(name: "피자", imgData: try! Data(contentsOf: URL(string: "https://i.namu.wiki/i/umI-heVYVS9miQNqXM13FRUOHHL4l1nzsZgN9XRLFG7nI_7Dyf-Myr6HmiWf9Qd7SAZQz3WYSQHPXXtGAwLTag.webp")!), description: "지난 금요일 저녁에 가장 많이 먹은 음식"),
                Food(name: "치킨", imgData: try! Data(contentsOf: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_HxlMbWfOsEwahYJMKk-4DQca3aaaODHWHA&usqp=CAU")!), description: "어제 밤에 가장 많이 먹은 음식"),
                Food(name: "햄버거", imgData: try! Data(contentsOf: URL(string: "https://media.istockphoto.com/id/1473452859/ko/%EC%82%AC%EC%A7%84/%EB%A7%9B%EC%9E%88%EB%8A%94-%EC%B9%98%EC%A6%88-%EB%B2%84%EA%B1%B0-%EC%BD%9C%EB%9D%BC-%ED%95%9C-%EC%9E%94-%EA%B0%90%EC%9E%90-%ED%8A%80%EA%B9%80%EC%9D%B4-%EB%82%98%EB%AC%B4-%EC%9F%81%EB%B0%98%EC%97%90-%ED%81%B4%EB%A1%9C%EC%A6%88%EC%97%85%EB%90%A9%EB%8B%88%EB%8B%A4.webp?b=1&s=612x612&w=0&k=20&c=nVle79N57DVy0LoEg3xhyyMbN406n6hj-KMiNGV0Dgc=")!),
                description: "지난 금요일 점심에 가장 많이 먹은 음식"),
                Food(name: "초밥", imgData: try! Data(contentsOf: URL(string: "https://media.istockphoto.com/id/1388044592/ko/%EC%82%AC%EC%A7%84/%EB%B9%84%EA%B1%B4-%EC%B4%88%EB%B0%A5-%EC%82%AC%EC%8B%9C%EB%AF%B8-%EB%A7%88%ED%82%A4-%EB%A1%A4%EC%8A%A4-%EC%8B%9D%EB%AC%BC-%EA%B8%B0%EB%B0%98-%ED%95%B4%EC%82%B0%EB%AC%BC.webp?b=1&s=612x612&w=0&k=20&c=_aXLrsf9wpPzF9fS5cuyn4dhwcW8c3HS4dzCeRalluo=")!),
                description: "지난 수요일 점심에 가장 많이 먹은 음식"),
                Food(name: "삼겹살", imgData: try! Data(contentsOf: URL(string: "https://cdn.pixabay.com/photo/2015/10/28/06/12/pork-1010004_1280.jpg")!), description: "지난 월요일 저녁에 가장 많이 먹은 음식"),
                Food(name: "김치찌개", imgData: try! Data(contentsOf: URL(string: "https://media.istockphoto.com/id/1488099588/ko/%EC%82%AC%EC%A7%84/%EA%B9%80%EC%B9%98%EC%B0%8C%EA%B0%9C.webp?b=1&s=612x612&w=0&k=20&c=1ErrDdq-v5CdsApKMmGWO-kZKy2IaNWNmo8EfNFg85g=")!),
                description: "지난 토요일 아침에 가장 많이 먹은 음식"),
                Food(name: "라면", imgData: try! Data(contentsOf: URL(string: "https://cdn.pixabay.com/photo/2016/03/06/13/04/if-the-1240330_1280.jpg")!), description: "오늘 아침에 가장 많이 먹은 음식")
            ]
        
        // foods 배열에 샘플 데이터 할당
        self.foods = sampleFoods
        
        // 임의의 두 개의 음식 선택 (인덱스)
        self.selectedFoodIndex1 = Int.random(in: 0..<self.foods.count) // 범위 수정
        var temp = Int.random(in: 0..<self.foods.count)
        //self.selectedFoodIndex2 = self.selectedFoodIndex1
        while self.selectedFoodIndex1 == temp {
            temp = Int.random(in: 0..<self.foods.count)
        }
        self.selectedFoodIndex2 = temp
    }
}

struct ImageSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelectView()
    }
}
//비동기 이미지 업로드
/*
import SwiftUI

struct Food: Codable {
    var name: String
    var imgUrl: URL
    var description: String
}

struct ImageSelectView: View {
    @State private var foods: [Food] = []
    @State private var selectedFoodIndex1: Int?
    @State private var selectedFoodIndex2: Int?
    
    var body: some View {
        VStack {
            HStack {
                if let selectedFoodIndex1 = selectedFoodIndex1 {
                    VStack {
                        AsyncImage(url: foods[selectedFoodIndex1].imgUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200) // 이미지 크기 조절
                        } placeholder: {
                            ProgressView() // 이미지 로딩 중에 표시할 뷰
                        }
                        Text("\(foods[selectedFoodIndex1].description)")
                    }
                } else {
                    Text("이미지를 불러오는 중...")
                }
                Spacer()
                if let selectedFoodIndex2 = selectedFoodIndex2 {
                    VStack {
                        AsyncImage(url: foods[selectedFoodIndex2].imgUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200) // 이미지 크기 조절
                        } placeholder: {
                            ProgressView() // 이미지 로딩 중에 표시할 뷰
                        }
                        Text("\(foods[selectedFoodIndex2].description)")
                    }
                } else {
                    Text("이미지를 불러오는 중...")
                }
            }
            .onAppear {
                fetchData()
            }
            Button(action: {
                            fetchData()
                        }) {
                            Text("갈아엎기")
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(Color.black)
                                .cornerRadius(10)
                        }
        }
    }
    
    func fetchData() {
        let sampleFoods = [
            Food(name: "짜장면", imgUrl: URL(string: "https://i.namu.wiki/i/zLCSMHVvvt9_ZJyb33kImeEfmrBewsgNll9AyPyVcyNNX2frg1svs7I-nrm-seExLN7BcJ__RJMJCGKDIUkgPg.webp")!, description: "어제 점심에 가장 많이 먹은 음식"),
            Food(name: "짬뽕", imgUrl: URL(string: "https://wooltariusa.com/cdn/shop/products/55.jpg?v=1684855939&width=1400")!, description: "오늘 점심에 가장 많이 먹은 음식"),
            Food(name: "볶음밥", imgUrl: URL(string: "https://recipe1.ezmember.co.kr/cache/recipe/2022/01/06/baf96f7e006b71ce430605b45b828f231.jpg")!, description: "지난 목요일 저녁에 가장 많이 먹은 음식"),
            Food(name: "피자", imgUrl: URL(string: "https://i.namu.wiki/i/umI-heVYVS9miQNqXM13FRUOHHL4l1nzsZgN9XRLFG7nI_7Dyf-Myr6HmiWf9Qd7SAZQz3WYSQHPXXtGAwLTag.webp")!, description: "지난 금요일 저녁에 가장 많이 먹은 음식"),
            Food(name: "치킨", imgUrl: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_HxlMbWfOsEwahYJMKk-4DQca3aaaODHWHA&usqp=CAU")!, description: "어제 밤에 가장 많이 먹은 음식"),
            Food(name: "햄버거", imgUrl: URL(string: "https://media.istockphoto.com/id/1473452859/ko/%EC%82%AC%EC%A7%84/%EB%A7%9B%EC%9E%88%EB%8A%94-%EC%B9%98%EC%A6%88-%EB%B2%84%EA%B1%B0-%EC%BD%9C%EB%9D%BC-%ED%95%9C-%EC%9E%94-%EA%B0%90%EC%9E%90-%ED%8A%80%EA%B9%80%EC%9D%B4-%EB%82%98%EB%AC%B4-%EC%9F%81%EB%B0%98%EC%97%90-%ED%81%B4%EB%A1%9C%EC%A6%88%EC%97%85%EB%90%A9%EB%8B%88%EB%8B%A4.webp?b=1&s=612x612&w=0&k=20&c=nVle79N57DVy0LoEg3xhyyMbN406n6hj-KMiNGV0Dgc=")!, description: "지난 금요일 점심에 가장 많이 먹은 음식"),
            Food(name: "초밥", imgUrl: URL(string: "https://media.istockphoto.com/id/1388044592/ko/%EC%82%AC%EC%A7%84/%EB%B9%84%EA%B1%B4-%EC%B4%88%EB%B0%A5-%EC%82%AC%EC%8B%9C%EB%AF%B8-%EB%A7%88%ED%82%A4-%EB%A1%A4%EC%8A%A4-%EC%8B%9D%EB%AC%BC-%EA%B8%B0%EB%B0%98-%ED%95%B4%EC%82%B0%EB%AC%BC.webp?b=1&s=612x612&w=0&k=20&c=_aXLrsf9wpPzF9fS5cuyn4dhwcW8c3HS4dzCeRalluo=")!, description: "지난 수요일 점심에 가장 많이 먹은 음식"),
            Food(name: "삼겹살", imgUrl: URL(string: "https://cdn.pixabay.com/photo/2015/10/28/06/12/pork-1010004_1280.jpg")!, description: "지난 월요일 저녁에 가장 많이 먹은 음식"),
            Food(name: "김치찌개", imgUrl: URL(string: "https://media.istockphoto.com/id/1488099588/ko/%EC%82%AC%EC%A7%84/%EA%B9%80%EC%B9%98%EC%B0%8C%EA%B0%9C.webp?b=1&s=612x612&w=0&k=20&c=1ErrDdq-v5CdsApKMmGWO-kZKy2IaNWNmo8EfNFg85g=")!, description: "지난 토요일 아침에 가장 많이 먹은 음식"),
            Food(name: "라면", imgUrl: URL(string: "https://cdn.pixabay.com/photo/2016/03/06/13/04/if-the-1240330_1280.jpg")!, description: "오늘 아침에 가장 많이 먹은 음식")
        ]
        
        // foods 배열에 샘플 데이터 할당
        self.foods = sampleFoods
        
        // 임의의 두 개의 음식 선택 (인덱스)
        self.selectedFoodIndex1 = Int.random(in: 0..<self.foods.count) // 범위 수정
        var temp = 0
        //self.selectedFoodIndex2 = self.selectedFoodIndex1
        while self.selectedFoodIndex1 == temp {
            temp = Int.random(in: 0..<self.foods.count)
        }
        self.selectedFoodIndex2 = temp
    }
}

struct ImageSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelectView()
    }
}
*/

//추후
/*
import SwiftUI

struct Food: Codable {
    var name: String
    var imgUrl: URL
    var description: String
}

struct MenuSelectView: View {
    @State private var imageURL1: URL?
    @State private var imageURL2: URL?
    
    var body: some View {
        VStack {
            HStack {
                if let imageURL1 = imageURL1 {
                    AsyncImage(url: imageURL1) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200) // 이미지 크기 조절
                    } placeholder: {
                        ProgressView() // 이미지 로딩 중에 표시할 뷰
                    }
                } else {
                    Text("이미지를 불러오는 중...")
                }
                if let imageURL2 = imageURL2 {
                    AsyncImage(url: imageURL2) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200) // 이미지 크기 조절
                    } placeholder: {
                        ProgressView() // 이미지 로딩 중에 표시할 뷰
                    }
                } else {
                    Text("이미지를 불러오는 중...")
                }
            }
        }
        .onAppear {
            fetchData()
        }
    }
    
    func fetchData() {
        // 네트워크 요청을 수행하여 백엔드에서 이미지 URL을 가져옵니다.
        if let url = URL(string: "백엔드에서 이미지 URL을 가져올 URL") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(Food.self, from: data)
                        // 이미지 URL을 가져와서 imageURL1 및 imageURL2 변수에 할당합니다.
                        DispatchQueue.main.async {
                            self.imageURL1 = decodedData.imgUrl
                            self.imageURL2 = decodedData.imgUrl // imageURL2 예시
                        }
                    } catch {
                        print("JSON 디코딩 에러: \(error)")
                    }
                }
            }.resume()
        }
    }
}

struct MenuSelectView_Previews: PreviewProvider {
    static var previews: some View {
        MenuSelectView()
    }
}

*/
