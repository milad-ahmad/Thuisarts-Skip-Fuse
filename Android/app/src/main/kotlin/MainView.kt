package thuisarts.skip

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import thuisarts.skip.AppConstants
import thuisarts.skip.MainViewModel
import thuisarts.skip.TabViewsKotlin
import thuisarts.skip.UrlPath

/**
 * The main entry point view that handles data loading states.
 */
@Composable
fun MainViewKotlin(viewModel: MainViewModel) {
    when (val state = viewModel.state) {
        is AppConstants.PageState.LoadingCase -> {
            Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                CircularProgressIndicator()
            }
            LaunchedEffect(Unit) {
                viewModel.getData(UrlPath.Companion.news)
            }
        }
        is AppConstants.PageState.LoadedCase -> {
            TabViewsKotlin()
        }
        is AppConstants.PageState.ErrorCase -> {
            Text(text = state.associated0)
        }
    }
}