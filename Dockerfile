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
RUN --mount=type=cache,target=/tmp/.cache/uv uv sync --frozen --no-dev --no-editable

# Copy the rest of the application files
COPY . .

# Set environment variable for ANTHROPIC_API_KEY
ENV ANTHROPIC_API_KEY=your_api_key_here

EXPOSE 8080

CMD ["uv", "run", "weather.py"]
