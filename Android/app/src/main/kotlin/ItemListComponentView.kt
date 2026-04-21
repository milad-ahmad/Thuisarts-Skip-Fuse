package thuisarts.skip

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp

/**
 * Iterates through a list of items without wrapping them in an additional scroll view.
 */
@Composable
fun ItemListComponentViewKotlin(
    viewModel: ItemListComponentViewModel,
    onNavigate: (String) -> Unit
) {
    Column(verticalArrangement = Arrangement.spacedBy(16.dp)) {
        viewModel.itemList.items.forEach { item ->
            ItemComponentViewKotlin(
                viewModel = ItemComponentViewModel(item),
                onNavigate = onNavigate
            )
        }
    }
}