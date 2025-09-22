package charly.baquero.pocketmap

import androidx.compose.ui.window.ComposeUIViewController
import charly.baquero.pocketmap.domain.model.Location
import platform.UIKit.UIViewController

fun MainViewController(
    mapUIViewController: (List<Location>?) -> UIViewController
) = ComposeUIViewController {
    mapViewController = mapUIViewController
    App()
}

lateinit var mapViewController: (List<Location>?) -> UIViewController
