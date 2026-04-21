package thuisarts.skip

import androidx.compose.runtime.Composable

/**
 * A routing view that renders the appropriate component based on the available data.
 * Passes the onNavigate callback down to components that support user interaction.
 */
@Composable
fun ComponentViewKotlin(
    viewModel: ComponentViewModel,
    onNavigate: (String) -> Unit = {}
) {
    when {
        viewModel.text != null -> TextComponentViewKotlin(
            viewModel = TextComponentViewModel(viewModel.text!!)
        )
        viewModel.image != null -> ImageComponentViewKotlin(
            viewModel = ImageComponentViewModel(viewModel.image!!)
        )
        viewModel.itemList != null -> ItemListComponentViewKotlin(
            viewModel = ItemListComponentViewModel(viewModel.itemList!!),
            onNavigate = onNavigate
        )
        viewModel.accordion != null -> AccordionComponentViewKotlin(
            viewModel = AccordionComponentViewModel(viewModel.accordion!!)
        )
        viewModel.section != null -> SectionComponentViewKotlin(
            viewModel = SectionComponentViewmodel(viewModel.section!!)
        )
        viewModel.unorderedList != null -> UnorderedListComponentViewKotlin(
            viewModel = UnorderdListComponentViewmodel(viewModel.unorderedList!!)
        )
    }
}