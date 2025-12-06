import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var videoURLs: [URL] = []

    var body: some View {
        NavigationView {
            VStack {
                if videoURLs.isEmpty {
                    Text("请选择视频")
                        .padding()
                } else {
                    Text("已载入视频数量：\(videoURLs.count)")
                }
            }
            .navigationTitle("tkp 播放器")
            .toolbar {
                PhotosPicker(selection: $selectedItems, matching: .videos) {
                    Text("选择视频")
                }
                .onChange(of: selectedItems) { newItems in
                    Task {
                        videoURLs = []
                        for item in newItems {
                            if let url = try? await item.loadTransferable(type: URL.self) {
                                videoURLs.append(url)
                            }
                        }
                    }
                }
            }
        }
    }
}
