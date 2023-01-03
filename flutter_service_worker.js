'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  ".git/COMMIT_EDITMSG": "c3dcf022bac1914b42aa1b7ec3ede0fa",
".git/config": "a0c1a5a3c9983a2eb118c91056817eca",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "6059365cd24174c735d6a52de260444c",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "aeb7f164e3e17ba4d1141eae18c2bb06",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "968b746fd89d581bf9811df9680c266f",
".git/logs/refs/heads/web_build": "6efd1697f3eacd52bc4980547d6a91cc",
".git/logs/refs/remotes/origin/web_build": "27da0a471898f8eefec81e02aa1934a7",
".git/objects/01/92f59a6b7d82c19f4a3aaf73e8bb7a73933076": "194000a46315deadeb6c17a795cc7313",
".git/objects/01/a7c2455a558f0781e04bc0a0b9e61dd9b31b06": "19fbe9c0ec83fd0b681e043860bb3813",
".git/objects/06/b63684e07ca300afa2a3f9d1de8dd7809b05c2": "6d6a325f0cde30aab53348124ef5cc0d",
".git/objects/0a/885bdbaffd79a133161c2b86df1758a534a411": "6027822a9c8e93d59a07cf82240a1d9c",
".git/objects/0d/1909e0781f3ae3aeaef2251583bb8a1d741191": "ab70feaa83f4795e8ec305c389569069",
".git/objects/18/6b6a4a9dfa306ecb7dcb2b0cc67326f3ca65f5": "ca23744c899d60d21bb6fcd565d138e2",
".git/objects/1a/b847b818dec389fb43fb9da80637c02e27d3d3": "8af286f2a069534106d53e8c037b0a4a",
".git/objects/2b/2c3a562b375d8b8666585df340e8f3868f38a8": "92a5ead6e841d0afb413c30b02850499",
".git/objects/2d/c4b470e903ad6dd412c8b82d2fa155e4f8e1a4": "dbf443caead52a6cff7fd5d1ae47a52f",
".git/objects/3a/bf18c41c58c933308c244a875bf383856e103e": "30790d31a35e3622fd7b3849c9bf1894",
".git/objects/3b/3c477c41a02719dd6e71f3c47b5b453aad0161": "b20810b3ceef2be8bbdbb9790f7c23de",
".git/objects/3e/1852e8b9f22b882057b5efdc5e2e88d9aaa371": "4158bbd8ad89fe847602de9f4c5be349",
".git/objects/3f/7682a6e830e34f27e98a37d386fa63b2985df4": "1acac7a08041d4c873c649de6751474c",
".git/objects/40/78fa3607dfde2392e5e26c85aa6e5217fab7ea": "145b1c904010181a34436dc609faaf32",
".git/objects/46/9dfbff7807440a5cdee01a52ceca1afcee7e57": "26d96617768d0881d343f159dcbf10ed",
".git/objects/48/52908825490accf8182edba7b602c9c6dc22b5": "b0fbf4cd59b9e32d8bdef85cbc891bf0",
".git/objects/53/422c9cbef7005e436887aa2ceb0be6c490217d": "788b6509c36e6676cb531de7e9748a32",
".git/objects/54/5b563f86cb383d5d65711cd4a4025e1bf7aae5": "506893fb3322bc50e3ebe00633bcd31d",
".git/objects/54/e9014f9f82b8f0163a46882e6ef9570e338d90": "6c460be8f0c48024e7fe28b1b590daf8",
".git/objects/57/fec6146dadb1007de6ce1ba6d7ccbdcf543c24": "719a3bdc194c53a57403c18dc8ce2683",
".git/objects/69/a021276feba8a35ae2f6ad8f2546c97d28bc64": "7c9135a4a312505e5089e586e12906d4",
".git/objects/71/aeb4f0310807b62214d3c6439829d0bca7585f": "7c022269e2b296e08c6700bfecb3d3f3",
".git/objects/77/88e67b2da269cf8ae2b91f200cc382f7a2f42b": "ac8d882bf186bd649549f4e92f495214",
".git/objects/7c/fb6f962bdb8c4b610bb1bb25b6c4361f9d20e8": "20235224869b650fc9ceb371e56bb5c9",
".git/objects/7f/5aa14b57f674e1967c46f588c4230dae11d779": "8fd0f051fa05265b2ae5833c012c2b06",
".git/objects/80/a81b1434162adb6217d4c7b490579bff827156": "68a169d7a7db81675acd1c0f647a9f48",
".git/objects/85/20b89fee3b70ce1387c07f5121d4d3017dbc29": "af6319c2eb27072e1e27182d8a49ccdd",
".git/objects/8e/757b4ea7ff2cbccd58f12211e3fb234e207850": "d791212fdd6a019074364ffaad839b8f",
".git/objects/97/8746b5424d1212460133977131fc5ef0971abb": "3cc094294d4d3275ff02b12eff5e10c3",
".git/objects/99/f7ebf70a30a9db175ed308c2b261d327a7aa8d": "c272ccfa1b2bf2c76ebc20fec67aed6b",
".git/objects/9f/b24504e8d0c16661fa24aa93e3de9afb2582df": "6cd4b7981097869d894e7396e9e622a9",
".git/objects/a0/3ed542122f8cf31e52a7054630e896f77ecbbe": "0e86c020da2cbd6a177c7a728b2f3e13",
".git/objects/a4/d28cc2b4a91f18eaedd70c653d4024581b7c0f": "bcc5df398081a7273e6eac9619280766",
".git/objects/aa/421825d4c8ac76d3201edcc06e2c26a55992d0": "998c6c096a33e32ab08414281840a0fb",
".git/objects/b2/b727f4cc57aa3e10e132aa44612071c3091f15": "a7981187a62c66a7e3295da78e1af6ad",
".git/objects/b4/dd3c31428cea10cb9635963e6f79aea57eb6df": "ef43f932e34cbbdb2b8b02b086ba2938",
".git/objects/ba/8e21db9d956f5cb0b730013921047b4dae7713": "1e144d8bd6a9c8bd071586e66a54626a",
".git/objects/c2/3f8a2596ba9dda69b5f634f09b166a04ae4b38": "2d02bc57b4ad601a99c8dbb31d651048",
".git/objects/cc/5725b315760d100f6386e6bbf09af8fe57a9f1": "29c19352d2bee0821600856656c95791",
".git/objects/cd/22076013ce8b84475eae9bb4cd6c60b5460fbe": "81c620e2d6cbe5638d6c90ee25886389",
".git/objects/d9/21926448bdd96912a03e7b31a2d594943ff687": "c7e3d9135ae392202a64d4a24b1f2297",
".git/objects/db/ebc5fc1ecb7f20ea5fcd4b1916611c6f1e1f1e": "e1130f3c11a8b12acff46889923bf9e4",
".git/objects/de/28db843d7df6ed23b8a7526f6b6b4a83425fe7": "797e4f7b3d8dced098c51679ff33e848",
".git/objects/e0/2012ca0a73da86edd7614aebdc24f350669305": "4cb516f7f367eb8387729d8cfc7cf9b2",
".git/objects/e1/b179954a0d28a89d538459d657efeca8d2143f": "8ba4bf212d4fdc2e8876fdc3c48fdc91",
".git/objects/e1/cc3cb54cb2373295f37e92a6a898437f0990d5": "823712639639d48597aeab6f81cd9161",
".git/objects/e3/d26826e6f819ae3d1964d125eab2c27489b01b": "8f2078ca3f16675f79bb4b9d587e5373",
".git/objects/e5/d84238bacfb33d55e6cba2102412b2e8071102": "f1c67dc1b698b89d5ce3e2cfd2483c05",
".git/refs/heads/web_build": "71796a1d176d65debf6d0f41019e932b",
".git/refs/remotes/origin/web_build": "71796a1d176d65debf6d0f41019e932b",
"assets/AssetManifest.json": "462ff3735e13539cf215a9ab955a80a2",
"assets/assets/voices/female_cont.mp3": "b4f9284413450b7be93d5ae560ffa63d",
"assets/assets/voices/female_end.mp3": "28e5cad1a08e8d2509d953a1cf9a186d",
"assets/assets/voices/female_left.mp3": "8863907f2c4b1bf61fb03c4ef45578db",
"assets/assets/voices/female_next.mp3": "93147de3b27a422c30eaf3fde01abe37",
"assets/assets/voices/female_start.mp3": "a42f68f397d83bef57ff7468b1c0e3c3",
"assets/assets/voices/female_voice.mp3": "0eaa020d811c7969e00775035c81201a",
"assets/assets/voices/kid_cont.mp3": "e4d5226e19b1713b02459a9781ac0ea4",
"assets/assets/voices/kid_end.mp3": "2ca08b9ea202b038d2399f5e88a89d10",
"assets/assets/voices/kid_left.mp3": "0fa967146e969a2c40ed83b8bcfe340c",
"assets/assets/voices/kid_next.mp3": "77fc332d17f0c00ce2da78fa59168e35",
"assets/assets/voices/kid_start.mp3": "10c0ff42744ea30874d29bc952d82d29",
"assets/assets/voices/kid_voice.mp3": "92a97a53536406029e922c013436b1af",
"assets/assets/voices/male_cont.mp3": "883e2e61d46a3a387045c514dbe66633",
"assets/assets/voices/male_end.mp3": "33d49304847abd642bbd51c7c4e0659b",
"assets/assets/voices/male_left.mp3": "da8fa0f7411a1f5f944d30f92e761bb0",
"assets/assets/voices/male_next.mp3": "6f9c0e7f9b3a2b35cef6aef6405c7f0f",
"assets/assets/voices/male_start.mp3": "e5b92169d49d78d26243b98aa4d1c019",
"assets/assets/voices/male_voice.mp3": "4506931a6f2db9559c73c493be66579c",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/NOTICES": "416520eae4e4fd8ef3b037cb330c59b2",
"assets/packages/wakelock_web/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "52613721192d1e7fcd44307a171af276",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"favicon.png": "0054287fe36ecb5f90446848cacf2ffa",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"icons/Icon-192.png": "6cf844bded1073f0caa7e67a4f80f61c",
"icons/Icon-512.png": "935b7232a886dca614b2af6edafde84b",
"icons/Icon-maskable-192.png": "6cf844bded1073f0caa7e67a4f80f61c",
"icons/Icon-maskable-512.png": "935b7232a886dca614b2af6edafde84b",
"index.html": "f7285cccb262ebfcb84660bdcf651b8a",
"/": "f7285cccb262ebfcb84660bdcf651b8a",
"main.dart.js": "d38863b4787b770c888669ba47dc0bf6",
"manifest.json": "fd71d23c71c0797dfa011ad887637bb0",
"version.json": "08d8dd7e4ae9988cdecd8857aa666089"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
