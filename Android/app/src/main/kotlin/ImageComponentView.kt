package thuisarts.skip

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.BrokenImage
import androidx.compose.material.icons.filled.Person
import androidx.compose.material3.Icon
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import thuisarts.skip.ImageComponent
import thuisarts.skip.ImageComponentStyle
import thuisarts.skip.ImageComponentViewModel

/**
 * Displays an image component based on the provided style within the view model.
 */
@Composable
fun ImageComponentViewKotlin(viewModel: ImageComponentViewModel) {
    val image = viewModel.image
    when (image.style) {
        ImageComponentStyle.header_-> HeaderImageComponentView(image = image)
        ImageComponentStyle.default -> DefaultImageComponentView(image = image)
    }
}

/**
 * Renders the default image component with a rounded corner shape.
 */
@Composable
fun DefaultImageComponentView(image: ImageComponent) {
    if (!image.url.isNullOrEmpty()) {
        AsyncImage(
            model = image.url,
            contentDescription = null,
            contentScale = ContentScale.Crop,
            modifier = Modifier
                .fillMaxWidth()
                .padding(start = 8.dp)
                .clip(RoundedCornerShape(24.dp))
        )
    } else {
        Icon(
            imageVector = Icons.Default.BrokenImage,
            contentDescription = null,
            tint = Color.Gray,
            modifier = Modifier.size(128.dp)
        )
    }
}

/**
 * Renders the header image component.
 */
@Composable
fun HeaderImageComponentView(image: ImageComponent) {
    if (!image.url.isNullOrEmpty()) {
        AsyncImage(
            model = image.url,
            contentDescription = null,
            contentScale = ContentScale.Crop,
            modifier = Modifier
                .fillMaxWidth()
                .padding(start = 8.dp)
                .clip(RoundedCornerShape(24.dp))
        )
    } else {
        Icon(
            imageVector = Icons.Default.BrokenImage,
            contentDescription = null,
            tint = Color.Gray,
            modifier = Modifier.size(128.dp)
        )
    }
}