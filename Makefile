installBundle:
	gem install bundle -v 2.7.1

installGems:
	bundle install --path vendor/bundle
	
installRubyDeps: installBundle installGems
	
installTuist:
	brew tap tuist/tuist
	@TUIST_VERSION=`cat .tuist-version | tr -d '\n'`; \
	brew install --formula tuist/tuist/tuist@$$TUIST_VERSION

runTuistGenerate:
	tuist generate --no-open
	bundle exec pod install
