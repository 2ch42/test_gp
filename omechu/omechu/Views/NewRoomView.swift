//
//  NewRoomView.swift
//  omechu
//
//  Created by 이창현 on 2023/09/18.
//

import SwiftUI
import Combine

struct RoomResponse: Decodable {
    let roomUuid: String
}

var cancellables = Set<AnyCancellable>()

struct NewRoomView: View {
    @State private var foods: [Food] = []
    @State private var roomUuid: String = "" // Store the roomUuid here
    @State private var selectedFoodIndex1: Int?
    @State private var selectedFoodIndex2: Int?

    var body: some View {
        VStack {
            Text("먹을 음식을 골라보세요!")
                .font(.title)
            Spacer()
                .font(.title)
            ImageSelectView(roomUuid: roomUuid) // Pass roomUuid to ImageSelectView
            Spacer()
        }
        .padding()
        .onAppear {
            fetchRoomUUID() // Make API request when the view appears
        }
    }

    // Function to perform the API request
    func fetchRoomUUID() {
        guard let url = URL(string: "https://yourserver.com/api/room/") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: RoomResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                // Handle error if any
                switch completion {
                    case .failure(let error):
                        print("Error: \(error)")
                    case .finished:
                        break
                }
            }, receiveValue: { response in
                // Update roomUuid with the received value
                self.roomUuid = response.roomUuid
            })
            .store(in: &cancellables)
    }
}


struct NewRoomView_Previews: PreviewProvider {
    static var previews: some View {
        NewRoomView()
    }
}
