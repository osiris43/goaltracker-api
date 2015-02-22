/*global $script, loadResources, lumbarLoader */
lumbarLoader.loadJS = function(moduleName, callback) {
  var loaded = loadResources(moduleName, 'js', callback, function(href, callback) {
    $script(href, callback);
    return 1;
  });
  return loaded.length;
};
lumbarLoader.loadCSS = function(moduleName, callback) {
  var loaded = loadResources(moduleName, 'css', callback, function(href) {
    var link = document.createElement('link');
    link.rel = 'stylesheet';
    link.type = 'text/css';
    link.href = href;
    link.setAttribute('data-lumbar', moduleName);
    return link;
  });

  if (callback) {
    var interval = setInterval(function() {
      var i = loaded.length;
      while (i--) {
        var sheet = loaded[i];
        if (sheet.sheet || sheet.styleSheet) {
          loaded.splice(i, 1);
          callback();
        }
      }
      if (!loaded.length) {
        clearInterval(interval);
      }
    }, 100);
  }
  return loaded.length;
};
