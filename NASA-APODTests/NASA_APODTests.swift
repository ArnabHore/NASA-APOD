//
//  NASA_APODTests.swift
//  NASA-APODTests
//
//  Created by Arnab Hore on 12/11/22.
//

import XCTest
@testable import NASA_APOD

class NASA_APODTests: XCTestCase {
    var homeViewModel: HomeViewModelProtocol?
    var coreDataManager: CoreDataManager?
    
    override func setUpWithError() throws {
        homeViewModel = HomeViewModel()
        coreDataManager = CoreDataManager()
    }

    override func tearDownWithError() throws {
        homeViewModel = nil
        coreDataManager = nil
    }

    func test_fetchDataWithOneResult() {
        let imageData: [String: Any] = firstData
        coreDataManager?.saveData(imgData: imageData)

        let result = coreDataManager?.fetchData(properties: nil)
        XCTAssertEqual(result?.count, 1)
        
        let data = result?.first as? [String: String]
        XCTAssertEqual(data?["date"], "2022-11-10")
        XCTAssertEqual(data?["title"], "Total Lunar Eclipse")
    }
    
    func test_fetchDataWithTwoResults() {
        let imageData: [String: Any] = secondData
        coreDataManager?.saveData(imgData: imageData)

        let result = coreDataManager?.fetchData(properties: nil)
        XCTAssertEqual(result?.count, 2)
        
        let firstData = result?[0] as? [String: String]
        XCTAssertEqual(firstData?["date"], "2022-11-10")
        XCTAssertEqual(firstData?["title"], "Total Lunar Eclipse")

        let secondData = result?[1] as? [String: String]
        XCTAssertEqual(secondData?["date"], "2022-11-13")
        XCTAssertEqual(secondData?["title"], "Flying Saucer Crash Lands in Utah Desert")
    }
    
    func test_deleteData() {
        coreDataManager?.deleteData(date: "2022-11-10")
        
        let result = coreDataManager?.fetchData(properties: nil)
        XCTAssertEqual(result?.count, 1)

        let data = result?.first as? [String: String]
        XCTAssertEqual(data?["date"], "2022-11-13")
        XCTAssertEqual(data?["title"], "Flying Saucer Crash Lands in Utah Desert")
    }

    let firstData: [String: Any] = ["date":"2022-11-10","explanation":"The beginning, middle, and end of a journey through planet Earth's colorful umbral shadow is captured in this timelapse composite image of a total lunar eclipse. Taken on November 8 from Kitt Peak National Observatory this eclipse's 1 hour and 25 minute long total phase starts on the right and finishes on the left. Reddened sunlight, scattered into the central shadow by Earth's dusty atmosphere produces the dramatic dark red hues reflected by the lunar disk. For this eclipse, additional reddening is likely due to scattering from ash lingering in the atmosphere after a large volcanic eruption in the southern Pacific earlier this year. Seen at the right and left, the Earth's shadow is still lighter along its edge though. That faint bluish fringe along the lunar limb is colored by sunlight filtered through Earth's stratospheric ozone layer.   Lunar Eclipse of November 2022: Notable Submissions to APOD  Love Eclipses? (US): Apply to become a NASA Partner Eclipse Ambassador","hdurl":"https://apod.nasa.gov/apod/image/2211/2022_11_08_TLE_Trio_1500px.png","media_type":"image","service_version":"v1","title":"Total Lunar Eclipse","url":"https://apod.nasa.gov/apod/image/2211/2022_11_08_TLE_Trio_1024px.png"]
    
    let secondData: [String: Any] = ["date":"2022-11-13","explanation":"A flying saucer from outer space crash-landed in the Utah desert after being tracked by radar and chased by helicopters.  The year was 2004, and no space aliens were involved.  The saucer, pictured here, was the Genesis sample return capsule, part of a human-made robot Genesis spaceship launched in 2001 by NASA itself to study the Sun.  The unexpectedly hard landing at over 300 kilometers per hour occurred because the parachutes did not open as planned.  The Genesis mission had been orbiting the Sun collecting solar wind particles that are usually deflected away by Earth's magnetic field. Despite the crash landing, many return samples remained in good enough condition to analyze. So far, Genesis-related discoveries include new details about the composition of the Sun and how the abundance of some types of elements differ across the Solar System. These results have provided intriguing clues into details of how the Sun and planets formed billions of years ago.","hdurl":"https://apod.nasa.gov/apod/image/2211/GenesisImpact_nasa_960.jpg","media_type":"image","service_version":"v1","title":"Flying Saucer Crash Lands in Utah Desert","url":"https://apod.nasa.gov/apod/image/2211/GenesisImpact_nasa_960.jpg"]
}
