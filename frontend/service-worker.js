
import { idbFactory } from './idb-client';

const idbClient = idbFactory('api-v1');

const REQUEST_CACHE_LIFETIME = 10 * 1000;

const now = _ => (new Date()).getTime();


let precacheConfig = [
  ["background.jpg","eb661a7bfd811daa1ffefe7d527333ab"],
  ['index.js', '2'],
  ['sw.js', '2'],
  ['index.html', '3'],
  ['fonts.css', '4'],
  ['material.css', '5'],
  ['material.min.js', '6'],
  ['material.indigo-pink.min.css', '7'],
  ['flUhRq6tzZclQEJ-Vdg-IuiaDsNcIhQ8tQ.woff2', '8'],
];
let cacheName = 'munch-static-cache' + (self.registration ? self.registration.scope : '');

let ignoreUrlParametersMatching = [/^utm_/];

let addDirectoryIndex = (originalUrl, index) => {
    let url = new URL(originalUrl);
    if (url.pathname.slice(-1) === '/') {
      url.pathname += index;
    }
    return url.toString();
};

let cleanResponse = (originalResponse) => {
    // If this is not a redirected response, then we don't have to do anything.
    if (!originalResponse.redirected) {
      return Promise.resolve(originalResponse);
    }

    // Firefox 50 and below doesn't support the Response.body stream, so we may
    // need to read the entire body to memory as a Blob.
    let bodyPromise = 'body' in originalResponse ?
      Promise.resolve(originalResponse.body) :
      originalResponse.blob();

    return bodyPromise.then((body) => {
      // new Response() is happy when passed either a stream or a Blob.
      return new Response(body, {
        headers: originalResponse.headers,
        status: originalResponse.status,
        statusText: originalResponse.statusText,
        timestamep: (new Date()).getTime(),
      });
    });
  };


  let createCacheKey = (originalUrl, paramName, paramValue, dontCacheBustUrlsMatching) => {
    let url = new URL(originalUrl);
    if (!dontCacheBustUrlsMatching ||
        !(url.pathname.match(dontCacheBustUrlsMatching))) {
      url.search += (url.search ? '&' : '') +
        encodeURIComponent(paramName) + '=' + encodeURIComponent(paramValue);
    }

    return url.toString();
  };

let isPathWhitelisted = (whitelist, absoluteUrlString) => {
    if (whitelist.length === 0) {
      return true;
    }

    let path = (new URL(absoluteUrlString)).pathname;
    return whitelist.some(whitelistedPathRegex => path.match(whitelistedPathRegex));
  };

let stripIgnoredUrlParameters = (originalUrl, ignoreUrlParametersMatching) => { 
  let url = new URL(originalUrl);
  url.hash = '';
  url.search = url.search
    .slice(1)
    .split('&')
    .map(kv => kv.split('='))
    .filter(kv => ignoreUrlParametersMatching.every(ignoredRegex => !ignoredRegex.test(kv[0])))
    .map(kv => kv.join('='))
    .join('&');

  return url.toString();
};


let hashParamName = '_sw-precache';
let urlsToCacheKeys = new Map(
  precacheConfig.map((item) => {
    let relativeUrl = item[0];
    let hash = item[1];
    let absoluteUrl = new URL(relativeUrl, self.location);
    let cacheKey = createCacheKey(absoluteUrl, hashParamName, hash, false);

    return [absoluteUrl.toString(), cacheKey];
  })
);

function setOfCachedUrls(cache) {
  return cache
    .keys()
    .then(requests=> requests.map(request => request.url))
    .then(urls => new Set(urls));
}

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(cacheName).then((cache) => {
      return setOfCachedUrls(cache).then((cachedUrls) => {
        return Promise.all(
          Array.from(urlsToCacheKeys.values()).map((cacheKey) => {
            if (!cachedUrls.has(cacheKey)) {
              let request = new Request(cacheKey, {credentials: 'same-origin'});
              return fetch(request).then((response) => {
                // every request.
                if (!response.ok) {
                  throw new Error(`Request for ${cacheKey} returned a response with status  ${response.status}`);
                }

                return cleanResponse(response)
                  .then(responseToCache => cache.put(cacheKey, responseToCache));
              });
            }
          })
        );
      });
    }).then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', (event) => {
  let setOfExpectedUrls = new Set(urlsToCacheKeys.values());

  event.waitUntil(
    caches.open(cacheName).then((cache) => {
      return cache.keys().then((existingRequests) => {
        return Promise.all(
          existingRequests.map((existingRequest) => {
            if (!setOfExpectedUrls.has(existingRequest.url)) {
              return cache.delete(existingRequest);
            }
          })
        );
      });
    }).then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (event) => {
  if (event.request.method === 'GET') {
    let shouldRespond;
    let url = stripIgnoredUrlParameters(event.request.url, ignoreUrlParametersMatching);
    shouldRespond = urlsToCacheKeys.has(url);
    let directoryIndex = 'index.html';
    if (!shouldRespond && directoryIndex) {
      url = addDirectoryIndex(url, directoryIndex);
      shouldRespond = urlsToCacheKeys.has(url);
    } 
    let navigateFallback = '';
    if (!shouldRespond && navigateFallback && (event.request.mode === 'navigate') && isPathWhitelisted([], event.request.url)) {
      url = new URL(navigateFallback, self.location).toString();
      shouldRespond = urlsToCacheKeys.has(url);
    }
    if (shouldRespond) {
      event.respondWith(
        caches.open(cacheName).then((cache) => {
          return cache.match(urlsToCacheKeys.get(url)).then((response) => {
            if (response) {
              return response;
            }
            throw Error('The cached response that was expected is missing.');
          });
        }).catch((e) => {
          console.warn('Couldn\'t serve response for "%s" from cache: %O', event.request.url, e);
          return fetch(event.request);
        })
      );
    }

    let createResponse = obj => new Response(JSON.stringify(obj), {
      headers: {'Content-Type': 'application/json'}
    });

    const fetchAndSaveAPIRequest = request => fetch(event.request)
      .then(r => r.json())
      .then(response => idbClient
        .set(event.request.url, { response, timestamp: now() + REQUEST_CACHE_LIFETIME })
        .then(_ => createResponse(response))
      );

    if (event.request.url.includes('/painting/')) {
      event.respondWith(idbClient
        .keys()
        .then(keys => {
          if (keys.includes(event.request.url)) {
            return idbClient  
              .get(event.request.url)
              .then(({ response, timestamp }) => {
                if (timestamp > now() || !navigator.onLine) {
                  return createResponse(response);
                }
                return fetchAndSaveAPIRequest(event.request);
              });
          }
          return fetchAndSaveAPIRequest(event.request);
        }));
    }
  }
});

self.addEventListener('push', e => {
  const { title } = e.data.json();
  self.registration.showNotification(title, {
      body: 'noti noti noti',
      // icon: ''
  });
})