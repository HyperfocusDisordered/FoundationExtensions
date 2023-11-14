// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "FoundationExtensions",
	platforms: [
        .iOS(.v11), .macOS(.v10_10), .watchOS(.v3), .tvOS(.v9),
	],
	products: [
		.library(name: "FoundationExtensions", targets: ["FoundationExtensions"]),
		.library(name: "FEBuilders", targets: ["FEBuilders"]),
		.library(name: "FECommon", targets: ["FECommon"]),
		.library(name: "FEDates", targets: ["FEDates"]),
		.library(name: "FEOptional", targets: ["FEOptional"]),
		.library(name: "FEMirror", targets: ["FEMirror"]),
		.library(name: "FERuntime", targets: ["FERuntime"])
	],
	dependencies: [
    ],
	targets: [
		.target(name: "FERuntimeObjc", dependencies: []),
		.target(name: "FERuntime", dependencies: ["FERuntimeObjc"]),
		.target(name: "FEBuilders", dependencies: []),
		.target(name: "FECommon", dependencies: ["FEBuilders"]),
		.target(name: "FEDates", dependencies: []),
		.target(name: "FEOptional", dependencies: []),
		.target(name: "FEMirror", dependencies: []),
		.target(name: "FoundationExtensions", dependencies: ["FERuntime", "FEBuilders", "FECommon", "FEDates", "FEOptional", "FEMirror"]),
	]
)
