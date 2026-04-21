package thuisarts.skip

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import thuisarts.skip.DefaultImageComponent
import thuisarts.skip.ItemComponentViewModel


/**
 * Renders an item with an image on top and a title below.
 */
@Composable
fun ImageTopTitleBottom(viewModel: ItemComponentViewModel) {
    Column(modifier = Modifier.fillMaxWidth()) {
        viewModel.item.image?.let { image ->
            DefaultImageComponent(image = image)
        }
        Text(text = viewModel.item.title)
    }
}