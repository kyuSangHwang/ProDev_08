//
//  ContentView.swift
//  MapApp
//
//  Created by 황규상 on 7/4/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let paris = CLLocationCoordinate2D(latitude: 48.856613, longitude: 2.352222)
    static let eiffelTower = CLLocationCoordinate2D(latitude: 48.858370, longitude: 2.294481)
    static let louvre = CLLocationCoordinate2D(latitude: 48.860611, longitude: 2.337644)
    static let notreDame = CLLocationCoordinate2D(latitude: 48.852968, longitude: 2.349902)
    static let arcDeTriomphe = CLLocationCoordinate2D(latitude: 48.873792, longitude: 2.295028)
    static let sacreCoeur = CLLocationCoordinate2D(latitude: 48.886705, longitude: 2.343104)
}

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let name: String
    let location: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.name = ""
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
    
    init(id: UUID = UUID(), _ name: String, _ location: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.location = location
    }
}

struct ContentView: View {
    let locationManager = CLLocationManager()   // CLLocationManager 인스턴스 생성, 이 객체는 사용자 위치를 관리 및 업데이트.
    
    @State var message = "Map of Paris"
    
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion(center: .paris, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: .paris, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    let places: [(String, CLLocationCoordinate2D)] = [
        ("에펠탑", .eiffelTower),
        ("루브르 박물관", .louvre),
        ("노트르담 대성당", .notreDame),
        ("개선문", .arcDeTriomphe),
        ("사크레쾨르 대성당", .sacreCoeur)
    ]
    
    let place = IdentifiablePlace(lat: 48.856613, long: 2.352222)
    
    let identifiablePlaces = [
        IdentifiablePlace("에펠탑", .eiffelTower),
        IdentifiablePlace("루브르 박물관", .louvre),
        IdentifiablePlace("노트르담 대성당", .notreDame),
        IdentifiablePlace("개선문", .arcDeTriomphe),
        IdentifiablePlace("사크레쾨르 대성당", .sacreCoeur)
    ]
    
    var body: some View {
        VStack {
            // iOS 17 이전 코드
            Map(coordinateRegion: $region,
                annotationItems: identifiablePlaces) { place in
                MapPin(coordinate: place.location,
                       tint: Color.purple)
            }
            
            // iOS 17 이후 코드
            Map(position: $position) {
                MapPolygon(coordinates: [.paris, .eiffelTower, .louvre])
                    .stroke(.purple.opacity(0.7), lineWidth: 5)
                    .foregroundStyle(.purple.opacity(0.7))
                ForEach(places, id: \.0) { place in
                    Annotation(place.0, coordinate: place.1) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.purple)
//                            .background(.white)
                            .clipShape(Circle())
                    }
                }
            }
            
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
