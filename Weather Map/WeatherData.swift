//
//  WeatherData.swift
//  Weather Map
//
//  Created by Samyak Pawar on 08/07/20.
//  Copyright © 2020 ArtistSamyak. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let sys: Sys
    let weather: [Weather]
}


struct Main: Decodable {
    let temp: Double
}

struct Sys: Decodable {
    let country: String
}

struct Weather: Decodable {
    let description: String
}
