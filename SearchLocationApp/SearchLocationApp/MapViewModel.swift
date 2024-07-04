//
//  MapViewModel.swift
//  SearchLocationApp
//
//  Created by 황규상 on 7/4/24.
//

import SwiftUI
import MapKit

@Observable
class MapViewModel: NSObject, CLLocationManagerDelegate {
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)    // 카메라 위치 설정 변수
    var searchText: String = "" // 검색어 저장 변수
    var mapStyle: MapStyle = .standard  // 지도 스타일 설정 변수
    var searchResults: [MKMapItem] = [] // 검색 결과 저장 변수
    var selectedPlace: MKMapItem?
    var route: MKRoute?
        
    private var locationManager: CLLocationManager = CLLocationManager() // 위치 관리자 인스턴스
    
    override init() {
        super.init()
        locationManager.delegate = self // 델리게이트 설정
        locationManager.requestWhenInUseAuthorization() // 위치 사용 권한 요청
    }
    
    /// 현재 위치로 이동하는 메서드
    func moveToCurrentLocation() {
        cameraPosition = .userLocation(fallback: .automatic)
    }
    
    /// 위치를 검색하는 메서드
    func searchLocation() {
        print("search!")
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText // 검색어 설정
        request.resultTypes = .pointOfInterest // 검색 결과 유형 설정
        
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] response, error in
            guard let response = response else { return }
            self?.searchResults = response.mapItems // 검색 결과 저장
        }
    }
    
    func getDirection() {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = selectedPlace!
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let response = response else { return }
            self?.route = response.routes.first
        }
    }
    
    func shareLocation() {
        print("share location")
    }
    
    // MARK: CLLocationManagerDelegate
    /// 위치가 업데이트될 때 호출되는 메서드
    /// - Parameters:
    ///   - manager: CLLocationManager 인스턴스
    ///   - locations: 업데이트된 위치 배열
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 위치 업데이트 처리 로직 (현재 비어 있음)
    }
    
    /// 위치 업데이트 실패 시 호출되는 메서드
    /// - Parameters:
    ///   - manager: CLLocationManager 인스턴스
    ///   - error: 발생한 에러
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("error \(error.localizedDescription)")
    }
}
