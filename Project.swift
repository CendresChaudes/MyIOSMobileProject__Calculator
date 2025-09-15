import ProjectDescription

let IOS_DEPLOYMENT_TARGET_VERSION = "15.6"

let swiftLintScript = TargetScript.pre(
	script: "Environment/SwiftLint/swiftlint.sh",
	name: "Run SwiftLint",
	basedOnDependencyAnalysis: false
)

let peripheryScript = TargetScript.post(
	script: "Environment/Periphery/periphery.sh",
	name: "Run Periphery",
	basedOnDependencyAnalysis: false
)

let targets: [Target] = [
	.target(
		name: "Calculator",
		destinations: [.iPhone],
		product: .app,
		bundleId: "dev.CendresChaudes.Calculator",
		deploymentTargets: .iOS(IOS_DEPLOYMENT_TARGET_VERSION),
		infoPlist: "Calculator/Support/Info.plist",
		sources: ["Calculator/Sources/**"],
		resources: [
			"Calculator/Resources/**",
			"Environment/**",
			".github/**",
			".gitignore",
			".ruby-version",
			".tuist-version",
			"Gemfile",
			"Gemfile.lock",
			"Makefile",
			"Podfile",
			"Podfile.lock",
		],
		scripts: [swiftLintScript],
		dependencies: [],
		coreDataModels: [.coreDataModel("Calculator/CoreData/Calculator.xcdatamodeld")]
	),
	.target(
		name: "CalculatorTests",
		destinations: [.iPhone],
		product: .unitTests,
		bundleId: "dev.CendresChaudes.Calculator.Tests",
		deploymentTargets: .iOS(IOS_DEPLOYMENT_TARGET_VERSION),
		sources: "CalculatorTests/Sources/**",
		scripts: [swiftLintScript],
		dependencies: [.target(name: "Calculator")]
	),
	.target(
		name: "CalculatorUITests",
		destinations: [.iPhone],
		product: .uiTests,
		bundleId: "dev.CendresChaudes.Calculator.UITests",
		deploymentTargets: .iOS(IOS_DEPLOYMENT_TARGET_VERSION),
		sources: "CalculatorUITests/Sources/**",
		scripts: [swiftLintScript],
		dependencies: [.target(name: "Calculator")]
	),
	.target(
		name: "Periphery",
		destinations: [.iPhone],
		product: .commandLineTool,
		bundleId: "dev.CendresChaudes.Calculator.Periphery",
		deploymentTargets: .iOS(IOS_DEPLOYMENT_TARGET_VERSION),
		scripts: [peripheryScript],
	),
]

let schemes: [Scheme] = [
	.scheme(
		name: "Calculator",
		shared: true,
		buildAction: .buildAction(targets: ["Calculator"]),
		testAction: .targets(["CalculatorTests", "CalculatorUITests"]),
		runAction: .runAction(executable: "Calculator")
	),
	.scheme(
		name: "CalculatorTests",
		shared: true,
		buildAction: .buildAction(targets: ["CalculatorTests"]),
		testAction: .targets(["CalculatorTests"]),
		runAction: .runAction(executable: "CalculatorUITests")
	),
	.scheme(
		name: "CalculatorUITests",
		shared: true,
		buildAction: .buildAction(targets: ["CalculatorUITests"]),
		testAction: .targets(["CalculatorUITests"]),
		runAction: .runAction(executable: "CalculatorUITests")
	),
	.scheme(
		name: "Periphery",
		shared: true,
		runAction: .runAction(executable: "Periphery")
	),
]

let settings: Settings = .settings(
	base: SettingsDictionary()
		.currentProjectVersion("1")
		.marketingVersion("1")
		.automaticCodeSigning(devTeam: "S9449RGK8C"),
	configurations: [
		.debug(name: "Debug"),
		.release(name: "Release"),
	]
)

let options: Project.Options = .options(
	textSettings: .textSettings(
		usesTabs: false,
		indentWidth: 4,
		tabWidth: 4,
		wrapsLines: true
	)
)

let project = Project(
	name: "Calculator",
	organizationName: "Роман Пронин (Personal Team)",
	options: options,
	settings: settings,
	targets: targets,
	schemes: schemes,
	resourceSynthesizers: [.assets(), .coreData(), .fonts(), .strings()],
)
