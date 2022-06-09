//
//  SearchBarView.swift
//  try
//
//  Created by Anita Stashevskaya on 04.06.2022.
//

import SwiftUI

struct SearchBarView: View {
    @ObservedObject var cityVM: CityView
    @State private var searchTerm = "Omsk"
   
    var body: some View {
        HStack {
            TextField("", text: $searchTerm)
                .padding(.leading, 20)
            Button {
                cityVM.city = searchTerm
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                    Image(systemName: "location.fill")
                }
            }
            .frame(width: 50, height: 50)
        }
        .foregroundColor(.white)
        .padding()
        .background(ZStack (alignment: .leading) {
            Image(systemName: "magnifyingglass.circle.fill")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .padding()
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue.opacity(0.5))
        })
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
