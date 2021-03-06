WORKSPACE = HatebuPocket.xcworkspace
PROJECT = HatebuPocket.xcodeproj
SCHEME = HatebuPocket
TEST_TARGET = HatebuPocketTests

clean:
	xcodebuild \
		-project $(PROJECT) \
		clean

build:
	xcodebuild \
		-workspace $(WORKSPACE) \
		-scheme $(SCHEME) \
		-sdk iphonesimulator \
		-configuration Debug \
		TEST_AFTER_BUILD=YES \
		TEST_HOST=
		
test:
	xcodebuild \
		-workspace $(WORKSPACE) \
		-scheme $(TEST_TARGET) \
		-sdk iphonesimulator \
		-configuration Debug \
		TEST_AFTER_BUILD=YES \
		TEST_HOST=

test-with-coverage:
	xcodebuild \
      -workspace $(WORKSPACE) \
      -scheme $(TEST_TARGET) \
      -sdk iphonesimulator \
      -configuration Debug \
      TEST_AFTER_BUILD=YES \
      TEST_HOST= \
      GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
      GCC_GENERATE_TEST_COVERAGE_FILES=YES

send-coverage:
	coveralls \
		-e BlockInjectionTest/Tests
