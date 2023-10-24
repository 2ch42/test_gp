//
//  MakeRoomView.swift
//  omechu
//
//  Created by 이창현 on 2023/09/17.
//

import SwiftUI
/*
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
*/
struct StartAppView: View {
    @EnvironmentObject var dataStore: AppDataStore
    @State private var isLoading = false

    var body: some View {
        VStack {
            Text("오늘의 메뉴 추천")
                .font(.title)
                .foregroundColor(.blue)
            Spacer()
            Button(action: {
                self.isLoading = true
                sendDataToServer()
            }) {
                Text("음식 고르기 시작!")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            Spacer()
            if isLoading {
                ProgressView()
            }
            Text("오늘의 메뉴 추천")
        }
        .padding()
    }

    func sendDataToServer() {
        // 요청을 보낼 URL을 설정
        guard let url = URL(string: "YOUR_BACKEND_API_URL_HERE") else {
            isLoading = false
            return
        }

        // 요청 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // 요청 본문 (JSON 데이터)
        let requestData = ["someKey": "someValue"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestData)

        URLSession.shared.dataTask(with: request) { data, response, error in
            // 오류 처리
            if let error = error {
                print("Error: \(error)")
                isLoading = false
                return
            }

            // 응답 처리
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ResponseModel.self, from: data)
                    DispatchQueue.main.async {
                        // 응답에서 추출한 roomUuid를 저장
                        dataStore.appData.roomUuid = response.roomUuid
                        isLoading = false
                    }
                } catch {
                    print("JSON decoding error: \(error)")
                    isLoading = false
                }
            }
        }.resume()
    }

    struct ResponseModel: Codable {
        let roomUuid: String
    }
}

struct StartAppView_Previews: PreviewProvider {
    static var previews: some View {
        StartAppView()
    }
}
