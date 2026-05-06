package thuisarts.skip

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material3.Button
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.LifecycleStartEffect
import kotlinx.coroutines.launch

/**
 * A scrollable view that renders dynamic page content and provides a top navigation bar for backward navigation.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PageViewKotlin(
    initialUrlPath: UrlPath? = UrlPath.Companion.news
) {
    var navStack by remember { mutableStateOf(listOfNotNull(initialUrlPath)) }
    val currentUrlPath = navStack.lastOrNull()

    val viewModel = remember(currentUrlPath) { PageViewModel() }
    val scrollState = rememberScrollState()
    val canGoBack = navStack.size > 1

    BackHandler(enabled = canGoBack) {
        navStack = navStack.dropLast(1)
    }
    var showEffect by remember { mutableStateOf(false) }



    LaunchedEffect(currentUrlPath) {
        if (currentUrlPath != null) {
            viewModel.getData(currentUrlPath)
        }
    }


    LaunchedEffect(Unit) {
        println("KOTLIN: LaunchedEffect started")
        try {
            viewModel.slowTask()
            println("KOTLIN: LaunchedEffect reached end")
        } finally {
            println("KOTLIN: LaunchedEffect disposed")
        }
    }
    Scaffold(
        topBar = {
            if (canGoBack) {
                TopAppBar(
                    title = { Text("") },
                    navigationIcon = {
                        IconButton(onClick = { navStack = navStack.dropLast(1) }) {
                            Icon(
                                imageVector = Icons.Default.ArrowBack,
                                contentDescription = "Terug"
                            )
                        }
                    }
                )
            }
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues)
                .verticalScroll(scrollState),
            verticalArrangement = Arrangement.spacedBy(24.dp)
        ) {
            Button(onClick = { showEffect = !showEffect }) {
                Text(if (showEffect) "Cancel Effect" else "Start 5s Task")
            }
            viewModel.page?.content?.forEach { content ->
                ComponentViewKotlin(
                    viewModel = ComponentViewModel(content),
                    onNavigate = { url ->
                        navStack = navStack + UrlPath.Companion.detail(url)
                    }
                )
            }
        }
    }
}

/**
 * Displays the search interface.
 */
@Composable
fun SearchView() {
    Text("search")
}

/**
 * Displays the bookmarks view.
 */
@Composable
fun BookmarkView() {
    Text("Bookmark")
}

/**
 * Displays the user account interface.
 */
@Composable
fun AccountView() {
    Text("Account")
}