dir := .
include $(dir)/rules.mk

.PHONY: build
build: $(BUILD)

.PHONY: push
push: $(PUSH)

.PHONY: test
test: $(TEST)
