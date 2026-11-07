# Build the browser bundle and a production JavaScript server bundle.
FROM node:22-alpine AS builder

WORKDIR /app
ARG VITE_RECAPTCHA_ENTERPRISE_SITE_KEY=""
ENV VITE_RECAPTCHA_ENTERPRISE_SITE_KEY=${VITE_RECAPTCHA_ENTERPRISE_SITE_KEY}
COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

# Install only runtime dependencies in the final image.
FROM node:22-alpine AS runner

WORKDIR /app
ENV NODE_ENV=production
ENV PORT=3000

COPY package.json package-lock.json ./
RUN npm ci --omit=dev && npm cache clean --force

COPY --from=builder /app/server-dist/server.js ./server-dist/server.js
COPY --from=builder /app/dist ./server-dist/dist

ENV NODE_OPTIONS=--enable-source-maps
USER node
EXPOSE 3000

CMD ["node", "server-dist/server.js"]
