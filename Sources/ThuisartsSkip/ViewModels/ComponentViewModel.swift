//
//  ComponentViewModel.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 25/02/2026.
//
import Foundation
import Observation
import SkipFuse

// SKIP @bridgeMembers
@MainActor
@Observable
/// This view model takes a `PageContentItem` and makes it usable for views.
/// Observable ViewModel that exposes components from `PageContentItem`.

public class ComponentViewModel{
    public private(set) var content: PageContentItem
    public private(set) var text: TextComponent?
    public private(set) var image: ImageComponent?
    public private(set) var itemList: ItemListComponent?
    public private(set) var item: ItemComponent?
    public private(set) var unsupported: UnsupportedComponent?

    public private(set) var accordion: AccordionComponent?
    public private(set) var section: SectionComponent?
    public private(set) var unorderedList: UnorderedListComponent?

    public init(content: PageContentItem) {
        self.content = content

        switch content {
        case let .image(image):
            self.image = image
        case let .itemList(itemList):
            self.itemList = itemList
        case let .item(item):
            self.item = item
        case let .text(text):
            self.text = text
        case let .unsupported(unsupported):
            self.unsupported = unsupported
        case let .accordion(accordion):
            self.accordion = accordion
        case let .section(section):
            self.section = section
        case let .unorderedList(unorderedList):
            self.unorderedList = unorderedList
        }

    }
}
