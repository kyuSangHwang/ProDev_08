//
//  MapViewModel.swift
//  SearchLocationApp
//
//  Created by 황규상 on 7/4/24.
//

import SwiftUI
import MapKit

@Observable
class MapViewModel {
    var carmeraPosition: MapCameraPosition = .userLocation(fallback: .automatic)    // 카메라 위치 설정 변수
    var searchText: String = "" // 검색어 저장 변수
    var mapStyle: MapStyle = .standard  // 지도 스타일 설정 변수
}
