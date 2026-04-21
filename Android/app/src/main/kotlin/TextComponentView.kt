package thuisarts.skip


import androidx.compose.material3.Text
import androidx.compose.runtime.Composable

/**
 * Renders text content, parsing standard HTML link tags into Markdown format.
 */
@Composable
fun TextComponentViewKotlin(viewModel: TextComponentViewModel) {
    val text = convertHTMLLinks(viewModel.text.content)
    Text(text = text)
}

private fun convertHTMLLinks(html: String): String {
    val regex = "<a\\s+[^>]*href=\"([^\"]+)\"[^>]*>(.*?)</a>".toRegex()
    return regex.replace(html) { matchResult ->
        val url = matchResult.groupValues[1]
        val text = matchResult.groupValues[2]
        "[$text]($url)"
    }
}