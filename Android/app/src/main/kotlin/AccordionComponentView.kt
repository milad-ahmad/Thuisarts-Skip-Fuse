package thuisarts.skip

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import thuisarts.skip.AccordionComponentViewModel
import thuisarts.skip.SectionComponentViewKotlin
import thuisarts.skip.SectionComponentViewmodel

/**
 * Renders an accordion consisting of multiple sections.
 */
@Composable
fun AccordionComponentViewKotlin(viewModel: AccordionComponentViewModel) {
    Column(verticalArrangement = Arrangement.spacedBy(16.dp)) {
        viewModel.accordion.content.forEach { section ->
            SectionComponentViewKotlin(viewModel = SectionComponentViewmodel(section))
        }
    }
}