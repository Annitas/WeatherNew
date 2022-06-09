//
//  TodayWeather.swift
//  try
//
//  Created by Anita Stashevskaya on 04.06.2022.
//

import SwiftUI

struct TodayWeather: View {
    @ObservedObject var cityVM: CityView
    
    var body: some View {
        VStack (spacing: 10) {
            Text("Today")
                .font(.largeTitle)
                .bold()
            
            HStack(spacing: 20) {
                cityVM.getWeatherIconFor(icon: cityVM.weatherIcon)
                    .frame(width: 100, height: 100)
                
                VStack (alignment: .leading) {
                    Text("\(cityVM.temperature)ºC")
                        .font(.system(size: 42))
                    Text("\(cityVM.conditions)")
                }
            }
            HStack {
                Spacer()
                widgetView(image: "wind", color: .green, title: "\(cityVM.windSpeed)")
                Spacer()
                widgetView(image: "drop.fill", color: .blue, title: "\(cityVM.humidity)")
                Spacer()
                widgetView(image: "umbrella.fill", color: .red, title: "\(cityVM.rainChance)")
                Spacer()
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)).opacity(0.3))
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
    }
    
    private func widgetView(image: String, color: Color, title: String) -> some View {
        VStack {
            Image(systemName: image)
                .padding()
                .font(.title3)
                .foregroundColor(color)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white)) //kvadrat
            
            Text(title)
        }
    }
}

struct TodayWeather_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
