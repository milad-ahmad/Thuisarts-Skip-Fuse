package thuisarts.skip

import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.width
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp


/**
 * Placeholder for IconLeftTitleLeftAccessoryRight style.
 */
@Composable
fun IconLeftTitleLeftAccessoryRight(viewModel: ItemComponentViewModel) {
    Row {
        viewModel.item.image?.let { image ->
            DefaultImageComponent(image = image)
            Spacer(modifier = Modifier.width(16.dp))
        }
        Text(text = viewModel.item.title)
        Spacer(modifier = Modifier.weight(1f))
    }
}

/**
 * Placeholder for TitleLeftUnderlined style.
 */
@Composable
fun TitleLeftUnderlined(viewModel: ItemComponentViewModel) {
    Row {
        viewModel.item.image?.let { image ->
            DefaultImageComponent(image = image)
            Spacer(modifier = Modifier.width(16.dp))
        }
        Text(text = viewModel.item.title)
    }
}

/**
 * Placeholder for TitleLeftAccessoryRight style.
 */
@Composable
fun TitleLeftAccessoryRight(viewModel: ItemComponentViewModel) {
    Row {
        viewModel.item.image?.let { image ->
            DefaultImageComponent(image = image)
            Spacer(modifier = Modifier.width(16.dp))
        }
        Text(text = viewModel.item.title)
        Spacer(modifier = Modifier.weight(1f))
    }
}

/**
 * Placeholder for LargeImageTopTitleBottom style.
 */
@Composable
fun LargeImageTopTitleBottom(viewModel: ItemComponentViewModel) {
    Row {
        viewModel.item.image?.let { image ->
            DefaultImageComponent(image = image)
            Spacer(modifier = Modifier.width(16.dp))
        }
        Text(text = viewModel.item.title)
        Spacer(modifier = Modifier.weight(1f))
    }
}

/**
 * Placeholder for Other style.
 */
@Composable
fun Other(viewModel: ItemComponentViewModel) {
    Row {
        viewModel.item.image?.let { image ->
            DefaultImageComponent(image = image)
            Spacer(modifier = Modifier.width(16.dp))
        }
        Text(text = viewModel.item.title)
        Spacer(modifier = Modifier.weight(1f))
    }
}

/**
 * Placeholder for TitleLeftArrowRight style.
 */
@Composable
fun TitleLeftArrowRight(viewModel: ItemComponentViewModel) {
    Row {
        viewModel.item.image?.let { image ->
            DefaultImageComponent(image = image)
            Spacer(modifier = Modifier.width(16.dp))
        }
        Text(text = viewModel.item.title)
        Spacer(modifier = Modifier.weight(1f))
    }
}

/**
 * Placeholder for TitleTopSummaryBottom style.
 */
@Composable
fun TitleTopSummaryBottom(viewModel: ItemComponentViewModel) {
    Row {
        viewModel.item.image?.let { image ->
            DefaultImageComponent(image = image)
            Spacer(modifier = Modifier.width(16.dp))
        }
        Text(text = viewModel.item.title)
        Spacer(modifier = Modifier.weight(1f))
    }
}