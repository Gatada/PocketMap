import UIKit
import SwiftUI
import ComposeApp
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    var locations: [Location]

    func makeUIView(context: Context) -> GMSMapView {
        let options = GMSMapViewOptions()
        if let firstLocation = locations.first {
            options.camera = GMSCameraPosition.camera(
                withLatitude: firstLocation.latitude,
                longitude: firstLocation.longitude,
                zoom: 10.0
            )
        } else {
            options.camera = GMSCameraPosition.camera(
                withLatitude: 0.0,
                longitude: 0.0,
                zoom: 1.0
            )
        }

        return GMSMapView(options: options)
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.clear()

        for location in locations {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            )
            marker.title = location.title
            marker.snippet = location.description_ ?? ""
            marker.map = uiView
        }

        if let firstLocation = locations.first {
            let camera = GMSCameraPosition.camera(
                withLatitude: firstLocation.latitude,
                longitude: firstLocation.longitude,
                zoom: 10.0
            )
            uiView.animate(to: camera)
        }
    }
}

@MainActor
final class GoogleMapHostingController: UIHostingController<GoogleMapView> {
    init(locations: [Location]) {
        super.init(rootView: GoogleMapView(locations: locations))
    }

    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func render(_ locations: [Location]) {
        rootView = GoogleMapView(locations: locations)
    }
}

struct ComposeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        MainViewControllerKt.MainViewController(
            mapUIViewController: { locationList in
                let locations = locationList?.compactMap { $0 as? Location } ?? []
                return GoogleMapHostingController(locations: locations)
            }
        )
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct ContentView: View {
    var body: some View {
        ComposeView()
                .ignoresSafeArea(.keyboard) // Compose has own keyboard handler
    }
}
