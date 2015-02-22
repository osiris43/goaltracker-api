/*jshint evil: true */
/*global Costanza, LocalCache, exports, loadResources, lumbarLoader */
lumbarLoader.loadJS = function(moduleName, callback) {
  return loadResources(moduleName, 'js', callback, function(href, callback) {
    loadViaXHR(href, function(err, data, status) {
      if (!err && data) {
        try {
          data += "\n//# sourceURL=" + href;
          window.eval(data);
          callback();
          return true;
        } catch (exception) {
          return callback({moduleName: moduleName + '.js', type: 'javascript', exception: exception});
        }
      }
      callback({moduleName: moduleName + '.js', type: err ? 'connection' : 'javascript', httpStatus: status});
    });
    return 1;
  }).length;
};
lumbarLoader.loadCSS = function(moduleName, callback) {
  return loadResources(moduleName, 'css', callback, function(href) {
    loadViaXHR(href, function(err, data, status) {
      data && exports.loader.loadInlineCSS(data, moduleName);
      callback(err ? {moduleName: moduleName + '.css', type: 'connection', httpStatus: status} : undefined);
      return !err;
    });
    return 1;
  }).length;
};

function loadViaXHR(href, callback) {
  var cache = LocalCache.get(href);
  if (cache) {
    // Dump off the stack to prevent any errors with loader module interaction
    setTimeout(function() {
      callback(undefined, cache);
    }, 0);

    return;
  }

  var xhr = new XMLHttpRequest();

  function handler(){
    if (xhr.readyState === 4) {
      // Ensure that we exec only once and do not leak.
      xhr.onreadystatechange = NOP;

      var success = (xhr.status >= 200 && xhr.status < 300) || (xhr.status === 0 && xhr.responseText);

      if (callback(!success, xhr.responseText, xhr.status)) {
        LocalCache.store(href, xhr.responseText, LocalCache.TTL.WEEK);
      }
    }
  }
  xhr.onreadystatechange = window.Costanza ? Costanza.bind('loader-xhr', handler) : handler;

  xhr.open('GET', href, true);
  xhr.send(null);
}

function NOP() {}
