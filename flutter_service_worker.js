'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"flutter_bootstrap.js": "727c7eeda301a2ccea5659174553b7dc",
"version.json": "c241206f3d752caa75bb14831987e9b7",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "b439ba2297456c20e59b71fee6be19d5",
"assets/NOTICES": "b9d6204cd8126c8816ca149325f6878a",
"assets/AssetManifest.bin": "425e589773a36cab887c7d41ad7200e6",
"assets/assets/images/water_enemy.png": "6702a02c0d411c023491e68a3a00ac0d",
"assets/assets/images/explosion.png": "399d7b06e79778a152fe05204ac77585",
"assets/assets/images/bullets.png": "fb77da6b3a0978a2d3133228ded4b25a",
"assets/assets/images/bullet.png": "6d57d87204c173af8572806d93ae3ec6",
"assets/assets/images/player-sprite.png": "8acd2b8d25ac4bbcaf8c9cdc8492fd1e",
"assets/assets/images/heart_half.png": "946fe784a7d50a0f52b28378d4ea8f84",
"assets/assets/images/stars.png": "5e766afbd74a090f1768f15be8c6bc6e",
"assets/assets/images/stars_0.png": "41b0c56bf48e1ffd6b726d2e0bde1b2d",
"assets/assets/images/joystick.png": "9056ad96ea8b2a8834995a7a90a36cfa",
"assets/assets/images/stars_2.png": "e102b859da519cb4546956dde49625ed",
"assets/assets/images/heart.png": "1ec544e61939a21e6fdc9038d356cdf4",
"assets/assets/images/ember.png": "4dfe185b14556722bec4d4aefeb000b0",
"assets/assets/images/enemy.png": "67c6e50b589a02489ac42d18ad0468ee",
"assets/assets/images/star.png": "35b1abf4b0b34cce83027006f5fd9fea",
"assets/assets/images/stars_1.png": "afba542fdca04292a991faf1b2a8bbd1",
"assets/assets/images/block.png": "2d39dcc65f7bab4c6ad7aaa94860a32b",
"assets/assets/images/buttons.png": "017f2981a1164342d4219080b66beabf",
"assets/assets/images/ground.png": "55ff488305e5543b99265bf46b3d3094",
"assets/assets/images/layers/heavy_clouded.png": "c65d8861bd2612791832b362973dc0f6",
"assets/assets/images/layers/mountains.png": "ed6474157918bb521b7657076f49fd24",
"assets/assets/images/layers/enemy.png": "7a150554055563130bcc44042320b72f",
"assets/assets/images/layers/bg.png": "8400f2e43cdb2df53c7b459ede375c3a",
"assets/assets/images/layers/emberknight.png": "15949dc53c6c913d2577c8745f741ea0",
"assets/assets/images/layers/player.png": "ffd0a6b95b419afa16e963ce07c84eb4",
"assets/assets/images/layers/background.png": "d19cfe556a8a2c67094f5810251b8509",
"assets/assets/images/player.png": "7e103ea127c72b067bb069cae7a27903",
"assets/assets/images/boss.png": "f77b59631e816f2df3807481d3454ea1",
"assets/assets/audio/bg_music.ogg": "e0ee19692c51bd7e07713a82d570c099",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/AssetManifest.bin.json": "497190ab5cb18735b6257e4607a1d1d1",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/AssetManifest.json": "70989f35114f7b5ef4b92fe2eeabbd78",
"index.html": "4744f4e411179d58841d0b31252c4dcc",
"/": "4744f4e411179d58841d0b31252c4dcc",
"manifest.json": "440d7a5063b052611be753aac2c62ea0"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
