package thuisarts.skip

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier

/**
 * Renders a specific item style component and handles navigation on click.
 */
@Composable
fun ItemComponentViewKotlin(
    viewModel: ItemComponentViewModel,
    onNavigate: (String) -> Unit
) {
    Box(modifier = Modifier.clickable { onNavigate(viewModel.item.url) }) {
        when (viewModel.item.style) {
            ItemStyle.largeImageTopTitleBottom -> LargeImageTopTitleBottom(viewModel)
            ItemStyle.imageTopTitleBottom -> ImageTopTitleBottom(viewModel)
            ItemStyle.imageLeftTitleRight -> ImageLeftTitleRight(viewModel)
            ItemStyle.titleTopSummaryBottom -> TitleTopSummaryBottom(viewModel)
            ItemStyle.titleLeft -> TitleLeft(viewModel)
            ItemStyle.titleLeftUnderlined -> TitleLeftUnderlined(viewModel)
            ItemStyle.titleLeftArrowRight -> TitleLeftArrowRight(viewModel)
            ItemStyle.titleLeftAccessoryRight -> TitleLeftAccessoryRight(viewModel)
            ItemStyle.iconLeftTitleLeftAccessoryRight -> IconLeftTitleLeftAccessoryRight(viewModel)
            else -> Other(viewModel)
        }
    }
}