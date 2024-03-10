//
//  ApiFetcher.swift
//  RunRide Studio Widgets
//
//  Created by Stoyan Delev on 10.03.24.
//

import Foundation

struct StravaData: Decodable {
    let v: Double
    let a: Int
}


struct ApiFetcher {
    static func fetchData(sport: String, interval: String, metric: String) async throws -> StravaData {
        
        //let useMetric = !UserDefaults(suiteName: "group.runride_studio")!.bool(forKey: "useImperial")
        //let token = UserDefaults(suiteName: "group.runride_studio")!.string(forKey: "token")
        //let stravaID = UserDefaults(suiteName: "group.runride_studio")!.string(forKey: "strava_id")
        var token = ""
        if  let cToken = UserDefaults(suiteName: "group.runride_studio")!.string(forKey: "token")  {
            token = cToken
        }
        
        let url = URL(string: "https://api-izq36taffa-uc.a.run.app/mobile/simple?type=" + sport + "&token=" + token + "&interval=" + interval + "&metric=" + metric)!
        print(url);
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let stravaData = try JSONDecoder().decode(StravaData.self, from: data)
            print("fetch:OK")
            return stravaData
        } catch {
            print("fetch:Error", error);
            throw error // Rethrow the error for handling at a higher level
        }
    }
}
