#!/usr/bin/env sh

brew tap tuist/tuist
TUIST_VERSION=$(cat .tuist-version | tr -d '\n')
brew install --formula tuist/tuist/tuist@$TUIST_VERSION
tuist generate
bundler exec pod install

xcodebuild clean -quiet

xcodebuild \
	build-for-testing \
	-workspace Calculator.xcworkspace \
	-scheme Calculator \
	-destination "platform=iOS Simulator,name=iPhone 14 Pro Max,OS=16.0"
