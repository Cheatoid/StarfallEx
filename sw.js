// Service Worker for Starfall Docs PWA
// Note: Using relative paths for compatibility with Next.js basePath
const CACHE_NAME = 'starfall-docs-v1';
const OFFLINE_URL = './';

// Assets to cache for offline use - relative to the service worker location
const ASSETS_TO_CACHE = [
  './',
  './manifest.json',
  './icons/icon-192x192.png',
  './icons/icon-512x512.png',
  './favicon.png',
  './logo.png',
  './globals.css',
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        // Cache all assets
        return cache.addAll(ASSETS_TO_CACHE);
      })
      .then(() => {
        // Force the waiting service worker to become active
        return self.skipWaiting();
      })
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          // Delete old caches
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        })
      );
    })
    .then(() => {
      // Claim all clients
      return self.clients.claim();
    })
  );
});

self.addEventListener('fetch', (event) => {
  // Network-first strategy with fallback to cache
  event.respondWith(
    fetch(event.request)
      .then((response) => {
        // Clone and cache the response
        const responseClone = response.clone();
        caches.open(CACHE_NAME)
          .then((cache) => {
            cache.put(event.request, responseClone);
          });
        return response;
      })
      .catch(() => {
        // Fallback to cache
        return caches.match(event.request)
          .then((response) => {
            return response || caches.match(OFFLINE_URL);
          });
      })
  );
});
