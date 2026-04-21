package thuisarts.skip


import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.width
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

/**
 * Renders an item with a left-aligned title.
 */
@Composable
fun TitleLeft(viewModel: ItemComponentViewModel) {
    Row {
        viewModel.item.image?.let { image ->
            DefaultImageComponent(image = image)
            Spacer(modifier = Modifier.width(16.dp))
        }
        Text(text = viewModel.item.title)
        Spacer(modifier = Modifier.weight(1f))
    }
}