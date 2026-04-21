package thuisarts.skip

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.width
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.unit.dp

/**
 * Renders an item with an image on the left constrained to 150dp width and a max height, preventing layout jumps.
 */
@Composable
fun ImageLeftTitleRight(viewModel: ItemComponentViewModel) {
    Row(
        verticalAlignment = Alignment.CenterVertically,
        modifier = Modifier.semantics(mergeDescendants = true) {
            contentDescription = viewModel.item.title
        }
    ) {
        viewModel.item.image?.let { image ->
            Box(
                modifier = Modifier
                    .width(150.dp)
                    .heightIn(max = 100.dp)
            ) {
                DefaultImageComponentView(image = image)
            }
            Text(text = viewModel.item.title)
            Spacer(modifier = Modifier.weight(1f))
        }
    }
}