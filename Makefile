.PHONY: help setup server build new clean publish

# Detect Hugo binary
HUGO := $(shell command -v hugo 2> /dev/null || echo "../bin/hugo")

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## Install Hugo automatically
	@./setup.sh

server: ## Start development server
	@./server.sh

build: ## Build site for production
	@echo "🏗️  Building site..."
	@$(HUGO) --minify --gc
	@echo "✅ Build complete! Output in public/"

new: ## Create new post (usage: make new POST=post-name)
	@if [ -z "$(POST)" ]; then \
		echo "❌ Please specify POST name: make new POST=my-post-name"; \
		exit 1; \
	fi
	@./new-post.sh $(POST)

clean: ## Clean generated files
	@echo "🧹 Cleaning..."
	@rm -rf public/
	@rm -rf resources/_gen/
	@echo "✅ Clean complete!"

publish: ## Build and prepare for publishing (git add, commit, push)
	@echo "📝 Building site..."
	@$(HUGO) --minify --gc
	@echo "📦 Staging changes..."
	@git add .
	@echo "✅ Ready to commit and push!"
	@echo "   Run: git commit -m 'Your message' && git push origin main"

