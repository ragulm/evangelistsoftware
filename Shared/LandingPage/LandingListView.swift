//
//  LandingListView.swift
//  EvangelistWeatherApp (iOS)
//
//  Created by Ragul ML on 16/08/22.
//

import SwiftUI

struct LandingListView: View {
    
    @StateObject private var viewModel = LandingViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.weatherData, id: \.id) { coordinate in
                HStack {
                    VStack {
                        HStack {
                            Text(coordinate.city)
                            Text("-")
                            Text(coordinate.weather_description)
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Text("Min: \(coordinate.weather_min_temp)")
                            Text("Max: \(coordinate.weather_max_temp)")
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            viewModel.makeWeatherRequest()
        })
    }
}

struct LandingListView_Previews: PreviewProvider {
    static var previews: some View {
        LandingListView()
    }
}
