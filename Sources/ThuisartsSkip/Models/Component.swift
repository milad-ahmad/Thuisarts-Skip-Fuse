//
//  Component.swift
//  MiladThuisarts
//
//  Created by Milad Ahmad on 23/02/2026.
//
import Foundation

public protocol Component: Codable, Equatable {
    var type: String { get }
}

public struct MetaData:  Component, Encodable, Sendable {
    public var type: String
    public let uuid: String
    public let url: String
    public let title: String
}

public struct Page:  Component, Sendable {
    public var type: String
    public let content: [PageContentItem]
    public let metadata: MetaData
}

public struct Content:  Component,  Hashable {
    public var type: String
    public var content: String?
    public var items: [ItemComponent]?
    public let style: String
}

public struct UnsupportedComponent:  Component,  Hashable, Sendable {
    public var type: String
}

public enum PageContentItem: Sendable, Codable,  Hashable, Equatable {
    case image(ImageComponent)
    case itemList(ItemListComponent)
    case item(ItemComponent)
    case text(TextComponent)
    case unsupported(UnsupportedComponent)

    case accordion(AccordionComponent)
    case section(SectionComponent)
    case unorderedList(UnorderedListComponent)

    private enum DiscriminatorKeys: String, CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DiscriminatorKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "Image": self = .image(try ImageComponent(from: decoder))
        case "Item": self = .item(try ItemComponent(from: decoder))
        case "ItemList": self = .itemList(try ItemListComponent(from: decoder))
        case "Text": self = .text(try TextComponent(from: decoder))

        case "Accordion":
            self = .accordion(try AccordionComponent(from: decoder))
        case "Section": self = .section(try SectionComponent(from: decoder))
        case "UnorderedList":
            self = .unorderedList(try UnorderedListComponent(from: decoder))
        default:
            self = .unsupported(try UnsupportedComponent(from: decoder))
        }
    }
}

public struct TextComponent:  Component,  Hashable, Sendable {
    public var type: String
    public var content: String
    public let style: String
}

public struct ItemComponent:  Component,  Hashable, Sendable {
    public var type: String
    public let title: String
    public let url: String
    public let image: ImageComponent?
    public let style: ItemStyle
}

public enum ItemStyle: Codable, Equatable,  Hashable, Sendable {
    case largeImageTopTitleBottom
    case imageTopTitleBottom
    case imageLeftTitleRight
    case titleTopSummaryBottom
    case titleLeft
    case titleLeftUnderlined
    case titleLeftArrowRight
    case titleLeftAccessoryRight
    case iconLeftTitleLeftAccessoryRight
    case other(String)
}

extension ItemStyle: RawRepresentable {
    public init(rawValue: String) {
        switch rawValue {
        case "large-imageTop-titleBottom":
            self = .largeImageTopTitleBottom
        case "imageTop-titleBottom":
            self = .imageTopTitleBottom
        case "imageLeft-titleRight":
            self = .imageLeftTitleRight
        case "titleTop-summaryBottom":
            self = .titleTopSummaryBottom
        case "titleLeft":
            self = .titleLeft
        case "titleLeftUnderlined":
            self = .titleLeftUnderlined
        case "titleLeft-arrowRight":
            self = .titleLeftArrowRight
        case "titleLeft-accessoryRight":
            self = .titleLeftAccessoryRight
        case "iconLeft-titleLeft-accessoryRight":
            self = .iconLeftTitleLeftAccessoryRight
        default:
            self = .other(rawValue)
        }
    }

    public var rawValue: String {
        switch self {
        case .largeImageTopTitleBottom:
            return "large-imageTop-titleBottom"
        case .imageTopTitleBottom:
            return "imageTop-titleBottom"
        case .imageLeftTitleRight:
            return "imageLeft-titleRight"
        case .titleTopSummaryBottom:
            return "titleTop-summaryBottom"
        case .titleLeft:
            return "titleLeft"
        case .titleLeftUnderlined:
            return "titleLeftUnderlined"
        case .titleLeftArrowRight:
            return "titleLeft-arrowRight"
        case .titleLeftAccessoryRight:
            return "titleLeft-accessoryRight"
        case .iconLeftTitleLeftAccessoryRight:
            return "iconLeft-titleLeft-accessoryRight"
        case .other(let value):
            return value
        }
    }
}

public struct ImageComponent:  Component,  Hashable, Sendable {
    public var type: String
    public let url: String?
    public let style: ImageComponentStyle
}

public enum ImageComponentStyle: Codable, Equatable,  Hashable, Sendable {
    case header
    case `default`
}

extension ImageComponentStyle: RawRepresentable {
    public var rawValue: String {
        switch self {
        case .header:
            return "header"
        case .default:
            return "default"
        }
    }

    public init(rawValue: String) {
        switch rawValue {
        case "header":
            self = .header
        default:
            self = .default

        }
    }
}

public struct ItemListComponent:  Component,  Hashable, Sendable {
    public var type: String
    public let style: String
    public let items: [ItemComponent]
    public let more: More
}

public struct More: Codable, Equatable,  Hashable, Sendable {
    public let fragment: String
    public let cursor: String
}

public enum Errors: Error {
    case invalidData
    case invalidUrl
    case invalidResponse
}

public struct AccordionComponent:  Component,  Hashable, Sendable {
    public var type: String
    public let content: [SectionComponent]
}

public struct SectionComponent:  Component,  Hashable, Sendable {
    public var type: String
    public let title: String?
    public let content: [PageContentItem]?
    public let icon: String?
    public let style: String?
    public let anchor: String?
}

public struct UnorderedListComponent:  Component,  Hashable, Sendable {
    public var type: String
    public let items: [ListItemComponent]
}

public struct ListItemComponent: Codable,  Hashable, Equatable, Sendable {
    public let content: [PageContentItem]
}
