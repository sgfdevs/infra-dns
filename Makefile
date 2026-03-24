.PHONY: help tf-init tf-plan tf-show tf-output tf-apply tf-validate tf-format tf-lint-fix tf-providers-lock

TF_DIR := src/tf
ENVRC := $(CURDIR)/.envrc
SHELL := bash

help:
	@echo "OpenTofu commands:"
	@echo "  Init:              make tf-init [ARGS='-backend=false']"
	@echo "  Plan:              make tf-plan [ARGS='-out=tfplan -destroy']"
	@echo "  Show:              make tf-show ARGS=<planfile>"
	@echo "  Output:            make tf-output [ARGS='-json']"
	@echo "  Apply:             make tf-apply [ARGS='-auto-approve tfplan']"
	@echo "  Validate:          make tf-validate"
	@echo "  Format check:      make tf-format"
	@echo "  Format fix:        make tf-lint-fix"
	@echo "  Providers lock:    make tf-providers-lock"

tf-init:
	@source "$(ENVRC)" && tofu -chdir=$(TF_DIR) init $(ARGS)

tf-plan:
	@source "$(ENVRC)" && tofu -chdir=$(TF_DIR) plan $(ARGS)

tf-show:
	@source "$(ENVRC)" && tofu -chdir=$(TF_DIR) show $(ARGS)

tf-output:
	@source "$(ENVRC)" && tofu -chdir=$(TF_DIR) output $(ARGS)

tf-apply:
	@source "$(ENVRC)" && tofu -chdir=$(TF_DIR) apply $(ARGS)

tf-validate:
	@source "$(ENVRC)" && tofu -chdir=$(TF_DIR) validate

tf-format:
	@tofu -chdir=$(TF_DIR) fmt -check -recursive

tf-lint-fix:
	@tofu -chdir=$(TF_DIR) fmt -recursive

tf-providers-lock:
	@source "$(ENVRC)" && cd $(TF_DIR) && tofu providers lock \
		-platform=darwin_amd64 \
		-platform=darwin_arm64 \
		-platform=linux_amd64 \
		-platform=linux_arm64 \
		-platform=windows_amd64 \
		-platform=windows_arm64
