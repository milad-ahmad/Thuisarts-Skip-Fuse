package thuisarts.skip


import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp

/**
 * Renders a vertically stacked section of components.
 */
@Composable
fun SectionComponentViewKotlin(viewModel: SectionComponentViewmodel) {
    Column(verticalArrangement = Arrangement.spacedBy(16.dp)) {
        viewModel.section.content?.forEach { item ->
            ComponentView(viewModel = ComponentViewModel(item))
        }
    }
}