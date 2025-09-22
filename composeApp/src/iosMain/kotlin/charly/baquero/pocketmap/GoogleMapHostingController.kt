package charly.baquero.pocketmap

import charly.baquero.pocketmap.domain.model.Location
import kotlinx.cinterop.ObjCClassName
import platform.UIKit.UIViewController

@ObjCClassName("GoogleMapHostingController")
external class GoogleMapHostingController : UIViewController {
    fun render(locations: List<Location>)
}
