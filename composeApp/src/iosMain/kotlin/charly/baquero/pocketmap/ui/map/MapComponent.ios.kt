package charly.baquero.pocketmap.ui.map

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.viewinterop.UIKitViewController
import charly.baquero.pocketmap.GoogleMapHostingController
import charly.baquero.pocketmap.domain.model.Location
import charly.baquero.pocketmap.mapViewController
import kotlinx.cinterop.ExperimentalForeignApi

@OptIn(ExperimentalForeignApi::class)
@Composable
actual fun MapComponent(locationList: List<Location>?) {
    UIKitViewController(
        factory = { mapViewController(locationList) },
        modifier = Modifier.fillMaxSize(),
        update = { controller ->
            val hostingController = controller as? GoogleMapHostingController
            hostingController?.render(locationList ?: emptyList())
        },
    )
}
