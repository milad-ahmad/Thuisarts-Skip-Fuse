//package thuisarts.skip
//
//
//import androidx.compose.foundation.background
//import androidx.compose.foundation.layout.*
//import androidx.compose.foundation.lazy.LazyColumn
//import androidx.compose.foundation.shape.RoundedCornerShape
//import androidx.compose.material.icons.Icons
//import androidx.compose.material.icons.filled.Bookmark
//import androidx.compose.material.icons.filled.Home
//import androidx.compose.material.icons.filled.Person
//import androidx.compose.material.icons.filled.Search
//import androidx.compose.material3.*
//import androidx.compose.runtime.*
//import androidx.compose.ui.Alignment
//import androidx.compose.ui.Modifier
//import androidx.compose.ui.graphics.Color
//import androidx.compose.ui.unit.dp
//
///**
// * Main entry point for the Android UI featuring a bottom navigation bar.
// *
// * @param viewModel The main view model handling the global state.
// * @param pageViewModel The view model containing the fetched page data.
// */
//@Composable
//fun AndroidMainTabView(
//    viewModel: MainViewModel = remember { MainViewModel() },
//    pageViewModel: PageViewModel = remember { PageViewModel() }
//) {
//    var selectedTab by remember { mutableIntStateOf(0) }
//
//    Scaffold(
//        bottomBar = {
//            NavigationBar(containerColor = Color.White) {
//                NavigationBarItem(
//                    selected = selectedTab == 0,
//                    onClick = { selectedTab = 0 },
//                    icon = { Icon(Icons.Default.Home, contentDescription = "Home") },
//                    label = { Text("Home") },
//                    colors = NavigationBarItemDefaults.colors(selectedIconColor = Color(0xFF6366F1))
//                )
//                NavigationBarItem(
//                    selected = selectedTab == 1,
//                    onClick = { selectedTab = 1 },
//                    icon = { Icon(Icons.Default.Search, contentDescription = "Search") },
//                    label = { Text("Zoeken") }
//                )
//                NavigationBarItem(
//                    selected = selectedTab == 2,
//                    onClick = { selectedTab = 2 },
//                    icon = { Icon(Icons.Default.Bookmark, contentDescription = "Bookmarks") },
//                    label = { Text("Bewaar") }
//                )
//                NavigationBarItem(
//                    selected = selectedTab == 3,
//                    onClick = { selectedTab = 3 },
//                    icon = { Icon(Icons.Default.Person, contentDescription = "Profile") },
//                    label = { Text("Profiel") }
//                )
//            }
//        }
//    ) { paddingValues ->
//        Box(modifier = Modifier.padding(paddingValues)) {
//            when (selectedTab) {
//                0 -> NewsFeedTab(viewModel, pageViewModel)
//                1 -> PlaceholderTab("Zoekscherm")
//                2 -> PlaceholderTab("Bewaarde artikelen")
//                3 -> PlaceholderTab("Profiel instellingen")
//            }
//        }
//    }
//}
//
///**
// * Displays the news feed and handles the state from the ViewModels.
// *
// * @param viewModel The main view model.
// * @param pageViewModel The page view model.
// */
//@Composable
//fun NewsFeedTab(viewModel: MainViewModel, pageViewModel: PageViewModel) {
//    when (val state = viewModel.state) {
//        is AppConstants.PageState.LoadingCase -> {
//            Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
//                CircularProgressIndicator(color = Color(0xFF6366F1))
//            }
//            LaunchedEffect(Unit) {
//                viewModel.getData(UrlPath.news)
//                pageViewModel.getData(UrlPath.news)
//            }
//        }
//        is AppConstants.PageState.LoadedCase -> {
//            NewsListContent(pageViewModel)
//        }
//        is AppConstants.PageState.ErrorCase -> {
//            Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
//                Text(text = "Fout: ${state.associated0}", color = Color.Red)
//            }
//        }
//    }
//}
//
///**
// * Iterates over the loaded Page models and renders the appropriate Compose components.
// *
// * @param viewModel The view model containing the loaded page content.
// */
//@Composable
//fun NewsListContent(viewModel: PageViewModel) {
//    val page = viewModel.page ?: return
//    val contentList = page.content ?: emptyList()
//
//    LazyColumn(
//        modifier = Modifier.fillMaxSize(),
//        contentPadding = PaddingValues(16.dp),
//        verticalArrangement = Arrangement.spacedBy(16.dp)
//    ) {
//        contentList.forEach { contentItem ->
//            when (contentItem) {
//                is PageContentItem.ItemListCase -> {
//                    val itemList = contentItem.associated0
//                    val items = itemList.items ?: emptyList()
//
//                    items.forEach { newsItem ->
//                        item {
//                            NewsItemRow(newsItem)
//                        }
//                    }
//                }
//                is PageContentItem.TextCase -> {
//                    val textComponent = contentItem.associated0
//                    item {
//                        Text(
//                            text = textComponent.content,
//                            style = MaterialTheme.typography.bodyMedium,
//                            modifier = Modifier.padding(8.dp)
//                        )
//                    }
//                }
//                is PageContentItem.ItemCase -> {
//                    val itemComponent = contentItem.associated0
//                    item {
//                        NewsItemRow(itemComponent)
//                    }
//                }
//
//                else -> {}
//            }
//        }
//    }
//}
//
///**
// * Renders a single item component row.
// *
// * @param item The data component to display.
// */
//@Composable
//fun NewsItemRow(item: ItemComponent) {
//    Card(
//        modifier = Modifier.fillMaxWidth(),
//        shape = RoundedCornerShape(12.dp),
//        colors = CardDefaults.cardColors(containerColor = Color(0xFFF3F4F6))
//    ) {
//        Row(
//            modifier = Modifier
//                .padding(12.dp)
//                .fillMaxWidth(),
//            verticalAlignment = Alignment.CenterVertically
//        ) {
//            Box(
//                modifier = Modifier
//                    .size(60.dp)
//                    .background(Color.LightGray, RoundedCornerShape(8.dp)),
//                contentAlignment = Alignment.Center
//            ) {
//                Text("IMG", style = MaterialTheme.typography.labelSmall)
//            }
//
//            Spacer(modifier = Modifier.width(16.dp))
//
//            Column {
//                Text(
//                    text = item.title,
//                    style = MaterialTheme.typography.titleMedium
//                )
//                Text(
//                    text = "Stijl: ${item.style}",
//                    style = MaterialTheme.typography.bodySmall,
//                    color = Color.DarkGray
//                )
//            }
//        }
//    }
//}
//
///**
// * A simple placeholder view for inactive tabs.
// *
// * @param title The text to display in the center of the screen.
// */
//@Composable
//fun PlaceholderTab(title: String) {
//    Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
//        Text(text = title, style = MaterialTheme.typography.headlineMedium)
//    }
//}