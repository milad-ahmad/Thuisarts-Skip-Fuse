import SwiftUI

public struct MainView: View {

    @State internal var viewModel: MainViewModel = MainViewModel()
    
    public init() {
    }

    public var body: some View {
            switch viewModel.state {
            case .loading:
                    ProgressView()
                    .task {
                        await viewModel.getData(for: .news)
                    }
            case .loaded:
                TabViews()

            case let .error(error):
                Text(error)
            }
    }
}
