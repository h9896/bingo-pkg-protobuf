.PHONY: default help install generate update gen-openapi
default: help

## install: Install package we need
install:
	@go install \
    github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest \
    github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest \
    google.golang.org/protobuf/cmd/protoc-gen-go@latest \
    google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

## generate: Generate related language package
generate:
	@buf generate

## update: Update protobuf mod package
update:
	@buf mod update ./proto

## check: Check protobuf format
check:
	@buf lint --error-format=json

break:
	@buf breaking --against .git#branch=main

gen-openapi:
	@buf generate --template ./buf.gen.openapi.yaml

# help
help: Makefile
	@echo
	@echo "Choose a command to run in $(PROJECTNAME):"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' | sed -e 's/^/ /'
	@echo
