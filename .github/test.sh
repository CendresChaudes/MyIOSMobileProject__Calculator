#!/usr/bin/env sh

xcodebuild \
	test-without-building \
	-workspace Calculator.xcworkspace \
	-scheme Calculator \
	-destination "platform=iOS Simulator,name=iPhone 14 Pro Max,OS=16.0"
