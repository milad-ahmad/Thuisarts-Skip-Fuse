package thuisarts.skip

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable

/**
 * Renders a list of items with bullet points.
 */
@Composable
fun UnorderedListComponentViewKotlin(viewModel: UnorderdListComponentViewmodel) {
    Column {
        viewModel.unorderedList.items.forEach { item ->
            Row {
                Text("- ")
                item.content.forEach { content ->
                    ComponentViewKotlin(viewModel = ComponentViewModel(content))
                }
            }
        }
    }
}