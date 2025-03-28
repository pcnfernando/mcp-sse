FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim AS uv

# Switch to root to set up directories
USER root
RUN mkdir -p /tmp/.cache/uv && chown -R 10014:10014 /tmp/.cache/uv

# Switch back to non-root user
USER 10014
ENV UV_CACHE_DIR=/tmp/.cache/uv

WORKDIR /app

# Copy the necessary files
COPY pyproject.toml uv.lock ./

# Install dependencies using uv with cache enabled
RUN uv sync --frozen --no-dev --no-editable

# Copy the rest of the application files
COPY . .

# Set environment variable for ANTHROPIC_API_KEY
ENV ANTHROPIC_API_KEY=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

EXPOSE 8080

CMD ["uv", "run", "weather.py"]
