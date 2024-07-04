//
//  ContentView.swift
//  MapApp
//
//  Created by 황규상 on 7/4/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let locationManager = CLLocationManager()   // CLLocationManager 인스턴스 생성, 이 객체는 사용자 위치를 관리 및 업데이트.
    
    @State var message = "Map of Paris"
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.856613, longitude: 2.352222), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
            TextEditor(text: $message)
                .frame(width: .infinity, height: 100)
        }
        // 뷰가 나타날 때 실행되는 코드(위치 관리자 설정).
        .onAppear {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // 위치 정확도 최대 설정.
            locationManager.distanceFilter = kCLDistanceFilterNone // 위치 업데이트 간격 설정.
            locationManager.requestWhenInUseAuthorization() // 앱이 사용 중일 때 위치 접근 권한 요청.
            locationManager.startUpdatingLocation() // 위치 업데이트 시작.
        }
    }
}

#Preview {
    ContentView()
}
