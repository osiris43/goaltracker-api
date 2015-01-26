# Thorax

[![Selenium Test Status](https://saucelabs.com/buildstatus/thorax)](https://saucelabs.com/u/thorax)

An opinionated, battle tested [Backbone](http://backbonejs.org/) + [Handlebars](http://handlebarsjs.com/) framework to build large scale web applications.

# Quick Start

- Generate your application using the [Thorax Yeoman Generator](https://github.com/walmartlabs/generator-thorax)
- Read about how Thorax works in the new [Backbone Fundamentals Book](http://addyosmani.github.com/backbone-fundamentals/#thorax).
- Install the [Thorax Inspector](https://chrome.google.com/webstore/detail/thorax-inspector/poioalbefcopgeaeaadelomciijaondk) Chrome extension.
- Building something smaller? Just link the [core library](http://github.com/walmartlabs/thorax) as a [single file from cdnjs](http://cdnjs.cloudflare.com/ajax/libs/thorax/2.0.0rc6/thorax.js) compiled with all of its dependencies and use it anywhere or play with our [Hello World fiddle](http://jsfiddle.net/KRuPZ/) or [Todos fiddle](http://jsfiddle.net/mZzhy/).

# Features

## Hello World

Thorax is used to build some of the biggest Backbone applications in the world but it's easy to get started.

    var view = new Thorax.View({
      greeting: "Hello",
      template: Handlebars.compile("{{greeting}} world!")
    });
    view.appendTo('body');

## Easy Data Binding

By default every property of your view is automatically available in the template. If a model is bound its attributes will also be made available.

    var view = new Thorax.View({
      greeting: 'Hello',
      model: new Thorax.Model({
        location: 'world!'
      }),
      template: ...
    });

Then in your template:

    {{greeting}} {{location}}

## Context Control

Don't like every property in your view being available in your template, or need to modify some model attributes? Just specify a `context` method to control what your template sees:

    var view = new Thorax.View({
      model: new Thorax.Model({
        greeting: 'hello'
      }),
      context: function() {
        return {
          greeting: this.model.get('greeting').toUpperCase()
        };
      },
      template: ...
    });

Then in your template:

    {{greeting}}

## Collection Rendering

Easily render collections with the `collection` helper. Thorax will make sure that your view stays current as models in your collection are added, removed or updated.

    var view = new Thorax.View({
      collection: new Thorax.Collection([{
        title: 'Finish screencast',
        done: true
      }]),
      template: ...
    });

Then in your template:

    {{#collection tag="ul"}}
      <li>
        <input type="checkbox" {{#done}}checked{{/done}}
        {{title}}
      </li>
    {{else}}
      <li>No todos yet.</li>
    {{/collection}}

## jQuery and Zepto Integration

Thorax extends the jQuery or Zepto `$` object to allow you to get a reference to the nearest bound `model`, `collection`, or `view`.

    var view = new Thorax.View({
      events: {
        'change input[type=checkbox]': function(event) {
          var model = $(event.target).model();
          model.set({done: event.target.checked});
        }
      }
    });

## Event Enhancements

Thorax extends the events hash to let you listen to view events in addition to DOM events, and let's you pass a hash of `model` or `collection` events to `listenTo` when a model or collection is bound to your view.

    var view = new Thorax.View({
      events: {
        rendered: function() {}
        model: {
          change: function() {}
        }
      },
      model: new Thorax.Model()
    });

Thorax also adds inheritable events to view classes, just call `on` on any class to listen for a DOM, view, model or collection event on any view.

    Thorax.View.on('eventName', handler);

## Form Handling

Easily capture entered form data with the `serialize` method which also provides event hooks for form validation. Models bound to the view will also automatically `populate` your forms.

    var view = new Thorax.View({
      events: {
        'submit form': function(event) {
          event.preventDefault();
          var attrs = this.serialize();
          this.collection.add(attrs);
        }
      },
      collection: new Thorax.Collection()
    });

## Embeddable Views

Easily embed one view within another with the `view` helper.

    var view = new Thorax.View({
      child: new Thorax.View(...),
      template: ...
    });

Then in your template:

    {{view child}}

## Layouts and Lifecycle

`Thorax.LayoutView` provides a container to place your views, and triggers lifecycle events on views placed within them. Layouts can be embedded in other views as well.

    var layout = new Thorax.LayoutView();
    layout.appendTo('body');
    var view = new Thorax.View({
      events: {
        ready: function() {},
        destroyed: function() {}
      }
    })
    layout.setView(view);

## Server Side Rendering

Thorax allows for rendering outside of the normal browser context using environments such as [Fruit Loops][fruit-loops] or [PhantomJS][phantomjs] to render content in the initial server response and then restore the view hierarchy on the client render. Rendering in such a manner allows for Thorax applications to expose their content for SEO purposes as well as speed up the perceived initial page load.

The restore process is well suited for handling distinctions between user and public data, allowing for the server response to include only public, long cache-able, content. The client can then augment this data with any user specific data on restoration.


# Getting Started

## Tutorials

### [Thorax Yeoman Generator](https://github.com/walmartlabs/generator-thorax)

Using the Thorax Generator, you can generate a Todos example application. You can also generate a blank application and build it out to match the Todos example app. This is a great way to learn by doing.

### [Thorax in Backbone Fundamentals](http://addyosmani.github.com/backbone-fundamentals/#thorax)

Read an overview of the features of Thorax, as well as some of the theory behind some of the implementation details.

### [Route Based Module Loading](http://addyosmani.github.com/backbone-fundamentals/#route-based-module-loading)

[Backbone Fundamentals](http://addyosmani.github.com/backbone-fundamentals/) also covers [Lumbar's](http://walmartlabs.github.com/lumbar) approach to modular application development and routing, which is used in all of the seed projects except the standalone and Rails seeds.

### TodoMVC
See the [TodoMVC Thorax implementation](http://addyosmani.github.com/todomvc/labs/architecture-examples/thorax/) and its [source code](https://github.com/addyosmani/todomvc/tree/gh-pages/labs/architecture-examples/thorax). There is also a [Lumbar flavored version](https://github.com/addyosmani/todomvc/tree/gh-pages/labs/dependency-examples/thorax_lumbar) of the implementation.

## Resources

### Thorax Yeoman Generator

The [Thorax Generator](https://github.com/walmartlabs/generator-thorax) will ask you questions before generating a new blank or predefined base project. This is the recommended way to get started.

The [Thorax Generator](https://github.com/walmartlabs/generator-thorax) also provides it's own extensive documentation and aims to help you understand how to setup a full stack Thorax application, including a minimal node express server and deployment instructions.

### Bower component

Thorax is available as a [Bower](http://bower.io/) component. Just run `bower install thorax` in your project.

Thorax is tested against these dependencies (you can paste this in your `bower.json`:

    "dependencies": {
      "jquery": "1.9.0",
      "underscore": "1.4.4",
      "zepto": "1.0.0",
      "handlebars": "1.0.0",
      "backbone": "1.0.0"
    }

Note that either jQuery or Zepto is required, but not both.

### cdnjs

Thorax is available on [cdnjs](http://cdnjs.com/), each build includes jQuery 1.9.0 (or Zepto 1.0.0rc1 on mobile), Backbone 0.9.9, Underscore 1.4.2 and Handlebars 1.0.0rc6.

- [Thorax](http://cdnjs.cloudflare.com/ajax/libs/thorax/2.0.0rc6/thorax.js)
- [Thorax (compressed)](http://cdnjs.cloudflare.com/ajax/libs/thorax/2.0.0rc6/thorax.min.js)
- [Thorax Mobile](http://cdnjs.cloudflare.com/ajax/libs/thorax/2.0.0rc6/thorax-mobile.js)
- [Thorax Mobile (compressed)](http://cdnjs.cloudflare.com/ajax/libs/thorax/2.0.0rc6/thorax-mobile.min.js)

### Playground

When combined with CoffeeScript small Thorax apps can be written in a single file. This is ideal for creating small test apps within [JSFiddle](http://jsfiddle.net/). Thorax can be selected as a framework (near the bottom of the list) in any fiddle, or you can try out any of the fiddles below:

- [Hello World](http://jsfiddle.net/KRuPZ/)
- [Todos](http://jsfiddle.net/mZzhy/)
- [$](http://jsfiddle.net/aveVu/)
- [HelperView](http://jsfiddle.net/NfkA5/)
- [LayoutView & Lifecycle](http://jsfiddle.net/cR6D8/)
- [Embedding](http://jsfiddle.net/6sCgX/)

# API Reference

## Registry

Thorax creates a special hash for each type of class to store all subclasses in your application. The use of `Thorax.Views` and `Handlebars.templates` (usually defined by Handlebars) is required to allow the `view`, `template` and other helper methods to operate, but the use of `Thorax.Models` and `Thorax.Collections` are optional and provided for consistency.

<table cellpadding="0" cellspacing="0" border="0" width="100%">
  <thead>
    <tr>
      <th>Class</th>
      <th>Registry</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>Thorax.View</td><td>Thorax.Views</td></tr>
    <tr><td>Thorax.Model</td><td>Thorax.Models</td></tr>
    <tr><td>Thorax.Collection</td><td>Thorax.Collections</td></tr>
    <tr><td>templates</td><td>Handlebars.templates</td></tr>
  </tbody>
</table>

### name *klass.prototype.name*

If a `name` property is passed to any Thorax classes' `extend` method the resulting class will be automatically set in the corresponding registry.

    //set class
    Thorax.View.extend({
      name: "my-view"
    });

    //get class
    Thorax.Views["my-view"]

### templates *Handlebars.templates*

A hash of templates, used by various Thorax helpers. If using the Lumbar or Rails boilerplate projects or the [Thorax Generator](https://github.com/walmartlabs/generator-thorax) this hash will be automatically generated from the files in your `templates` directories. To manually add a template to the hash:

    Handlebars.templates['my-template-name'] = Handlebars.compile('template string');

If a `View` has the same `name` as a template in the `templates` hash, its `template' property will be automatically assigned.

## Thorax.View

`Thorax.View` provides additive functionality over `Backbone.View` but breaks compatibility in one important way in that it does not use an `options` object. All properties passed to the constructor become available on the instance:

    var view = new Thorax.View({
      key: "value"
    });
    view.key === "value"

By default all instance properties are available in the template context. So when setting a key on the view it will by default be available in the template.

### template *view.template*

Assign a template to a view. This may be a string or a function which receives a single `context` argument and returns a string. If the view has a `name` and a template of the same `name` is available the `template` will be auto-assigned.

    new Thorax.View({
      template: Handlebars.compile("{{key}}")
    });

### render *view.render([content])*

Renders the view's `template` updating the view's `el` with the result, triggering the `rendered` event.

    view.render();

`render` can also accept a content argument that may be an element, string or a template function:

    view.render('custom html');

### restore *view.restore(element, forceRerender)*

Attempts to restore a given view with the passed `element`. Should this fail the view will be rerendered automatically. Rerendering may be forced by setting the `forceRerender` parameter to truthy. See [Server Rendering](#server-rendering) for further discussion.

### context *view.context()*

Used by `render` to determine what attributes are available in the view's `template`. The default context function returns `this` + `this.model.attributes` if a `model` is present on the view. The `context` method may be overridden to provide a custom context:

    new Thorax.View({
      template: Handlebars.compile('{{key}}'),
      context: function() {
        return _.defaults(this.model.attributes, {
          key: 'value'
        });
      }
    });

### appendTo *view.appendTo(element)*

Appends the view to a given `element` which may be a CSS selector or DOM element. `ensureRendered` will be called and a `ready` event will be triggered. This is the preferred way to append your outer most view onto a page.

### renderTemplate *view.renderTemplate(name [,context])*

Renders a given template with the view's `context` or the given context argument.

### ensureRendered *view.ensureRendered()*

Ensure that the view has been rendered at least once.

### conditionalRender *view.conditionalRender([flag])*

Renders the view if and only if `shouldRender(flag)` is true. Useful for ensuring that updates occur while still deferring final rendering until the view has been inserted into the DOM.

When `flag` is `undefined` this is effectively the opposite behavior of `ensureRendered`.

### shouldRender *view.shouldRender([flag])*

Returns `true` if the view should be rendered based on `flag` and the current rendered state.

`flag` may be:

- `true` : Always render
- `false` : Never render
- `undefined` : Render only if the view has been rendered previously

### html *view.html([content])*

Get or set the `innerHTML` of the view, without triggering the `rendered` event.

### _addChild *view.addChild(child)*

Register a view as being a child of the parent. This will `release` the child view when the parent is released.

    this.childView = this._addChild(new ChildView);

If you are embedding a child view with the `view` helper this is automatically done for you. Use this when there are cases where the child would not be embedded, either due to the parent not rendering or the view helper being inside of a conditional.

### children *view.children*

A hash of child view's indexed by `cid`. Child views may become attached to the parent with the `view` helper or may be automatically attached `HelperView` instances created by helpers created with `registerViewHelper` (such as the `collection` and `empty` helpers).

### parent *view.parent*

If a view was embedded inside another with the `view` helper, or a generated `HelperView` (for instance the `collection` or `empty` helpers) it will have a `parent` view attribute. In the case of `HelperView`s, the `parent` will be the view that declared the helper in its template.

### retain *view.retain([owner])*

Prevents a view from being destroyed if it would otherwise be. If a parent is destroyed all its children will be destroyed, or if it was previously passed to `setView`

Given the code below:

    a.retain();
    Application.setView(a);
    Application.setView(b);
    Application.setView(c);

`b` will be destroyed, and `a` will not be.

When the optional `owner` parameter is passed, the retain reference count will automatically be reduced when the owner view is destroyed.

Views that have been retained must be released via `release` or they will leak.

This is done automatically for views that are connected to an existing element via the `el` attribute.

### release *view.release()*

Release a view that was previously retained. If `release` is called and the view has a reference count of zero it will be destroyed, which will release all children, remove all events, unbind all models and collections, call `remove` and trigger the `destroyed` event.

`release` is usually called automatically if a view was attached to a `LayoutView` with the `setView` method, and another view is then passed to `setView`.

Generally this method is not needed unless you are `retain`ing views.


### setModel *view.setModel(model [,options])*

Setting `model` in the constructor will automatically call `setModel`, so the following are equivalent:

    var view = new Thorax.View({
      model: myModel
    });
    // identical functionality as above
    view.setModel(myModel);

Sets the `model` attribute of a view then attempts to fetch the model if it has not yet been populated. Once set the default `context` implementation will merge the model's `attributes` into the context, so any model attributes will automatically become available in a template. In addition any events declared via `view.on({model: events})` will be bound to the model with `listenTo`.

Accepts any of the following options:

- **fetch** - Boolean, whether to fetch the model when it is set, defaults to true.
- **success** - Callback on fetch success, defaults to noop
- **render** - Render on the view on model:change? Defaults to undefined
  - `true` : Always render on change
  - `false` : Never render on change
  - `undefined` : Rerender if we have already been rendered
- **populate** - Call `populate` with the model's attributes when it is set? Defaults to true.
  - Pass `populate: {children: false}` to prevent child views from having their inputs populated.
  - Pass `populate: {context: true}` to populate using the view's context rather than directly populating from the model's attributes.
- **errors** - When the model triggers an `error` event, trigger the event on the view? Defaults to true

### setCollection *view.setCollection(collection [,options])*

Setting `collection` in the constructor will automatically call `setCollection`, so the following are equivalent:

    var view = new Thorax.View({
      collection: myCollection
    });
    // identical functionality as above
    view.setCollection(myCollection);

Sets the `collection` attribute of a view then attempts to fetch the collection if it has not yet been populated. In addition any events declared via `view.on({collection: events})` will be bound to the collection with `listenTo`.

Accepts any of the following options:

- **render** - Whether to render the collection if it is populated, or render it after it has been loaded. Defaults to undefined
  - `true` : Always render on change
  - `false` : Never render on change
  - `undefined` : Rerender if we have already been rendered
- **fetch** - Whether or not to try to call `fetch` on the collection if `shouldFetch` returns true
- **success** - Callback on fetch success, defaults to noop
- **errors** - Whether or not to trigger an `error` event on the view when an `error` event is triggered on the collection
- **change** - Whether or not to call `updateItem` when a model's `change` event fires. Defaults to true.

Note that while any view may bind a collection only a `CollectionView` will actually render a collection. A regular `Thorax.View` may declare a `collection` helper which in turn will generate and embed a `CollectionView`.

### serialize *view.serialize([event], callback [,options])*

Serializes a form. `callback` will receive the attributes from the form, followed by a `release` method which must be called before the form can be submitted again. `callback` will only be called if `validateInput` returns nothing or an empty array. `options` may contain:

- `set` - defaults to true, whether or not to set the attributes if valid on a model if one was set with `setModel`
- `validate` - defaults to true, whether or not to call `validateInput` during serialization
- `children` - defaults to true, whether or not to serialize inputs in child views
- `silent` - defaults to true, whether or not to pass `silent: true` to `model.set`

Each form input in your application should contain a corresponding label. Since you may want to re-use the same form multiple times in the same view a `@cid` attribute with a unique value is provided to each render call of each template:

    <label for="{{@cid}}-last-name"/>
    <input name="last-name" id="{{@cid}}-last-name" value="Beastridge"/>
    <label for="{{@cid}}-address[street]"/>
    <input name="address[street]" value="123 Chestnut" id="{{@cid}}-address[street]"/>

    new Thorax.View({
      events: {
        "submit form": function(event) {
          this.serialize(event, function(attributes, release) {
            attributes["last-name"] === "Beastridge";
            attributes.address.street === "123 Chestnut";
            //form is locked to prevent duplicate submission
            //until release is called
            release();
          });
        }
      }
    });

`serialize` Triggers the following events:

- `serialize` - called before validation with serialized attributes
- `validate` - with an attributes hash and errors array after `validateInput` is called
- `invalid` - with an errors array, if `validateInput` returned an array with any errors
- `root` - the root element to serialize within, defaults to `this.$el`

If your view uses inputs with non standard names (or no names, multiple inputs with the same name, etc), use the `serialize` event:

    this.on('serialize', _.bind(function(attributes) {
      attributes.custom = this.$('.my-input').val();
    }, this));

### populate *view.populate([attributes] [,options])*

Populate the form fields in the view with the given attributes. The keys of the attributes should correspond to the names of the inputs. `populate` is automatically called with the response from `view.context()` when `setModel` is called. By default this is just `model.attributes`.

    view.populate({
      "last-name": "Beastridge"
      address: {
        street: "123 Chestnut"
      }
    });

`populate` triggers a `populate` event. If your view uses inputs with non standard names (or no names, multiple inputs with the same name, etc), use this event:

    this.on('populate', _.bind(function(attributes) {
      this.$('.my-input').val(attributes.custom);
    }, this));

To prevent child views from having their inputs populated use:

    view.populate(object, {
      children: false
    });

### validateInput *view.validateInput(attributes)*

Validate the attributes created by `serialize`, must return an array or nothing (if valid). It's recommended that the array contain hashes with `name` and `message` attributes, but arbitrary data or objects may be passed. If the array has a zero length the attributes are considered to be valid. Returning an array with any errors will trigger the `invalid` event.

    validateInput: function(attributes) {
      var errors = [];
      if (attributes.password && !attributes.password.match(/.{6,11}/)) {
        errors.push({name: 'password', message: 'Invalid Password'});
      }
      return errors;
    }


## Thorax.HelperView

### registerViewHelper *Handlebars.registerViewHelper(name [,viewClass] ,callback)*

Note that this differs from `Handlebars.registerHelper`. Registers a helper that will create and append a new `HelperView` instance, with its `template` attribute set to the value of the captured block. `callback` will receive any arguments passed to the helper followed by a `HelperView` instance. Named arguments to the helper will be present on `options` attribute of the `HelperView` instance.

A `HelperView` instance differs from a regular view instance in that it has a `parent` attribute which is always set to the declaring view, and a `context` which always returns the value of the `parent`'s context method. The `collection`, `empty` and other built in block view helpers are created with `registerViewHelper`.

A helper that re-rendered a `HelperView` every time an event was triggered on the declaring view could be implemented as:

    Handlebars.registerViewHelper('on', function(eventName, helperView) {
      helperView.listenTo(helperView.parent, eventName, function() {
        helperView.render();
      });
    });

An example use of this would be to have a counter that would increment each time a button was clicked. In Handlebars:

    {{#on "incremented"}}{{i}}{/on}}
    {{#button trigger="incremented"}}Add{{/button}}

And the corresponding view class:

    new Thorax.View({
      events: {
        incremented: function() {
          ++this.i;
        }
      },
      initialize: function() {
        this.i = 0;
      },
      template: ...
    });

In addition, if a view class is specified as the second argument to `registerViewHelper`, the helper will always initialize a view of that class instead of a `HelperView`:

    Handlebars.registerViewHelper('collection',
      Thorax.CollectionHelperView, function(collection, view) {

    });

## Thorax.LayoutView

A view to contain a single other view which will change over time, (multi-pane single page applications for instance), triggering a series of events . By default this class has no template. If one is specified use the `layout-element` helper to determine where `setView` will place a view. A `Thorax.LayoutView` is a subclass of `Thorax.View` and may be treated as a view in every regard (i.e. embed multiple `LayoutView` instances in a parent view with the `view` helper).

### setView *view.setView(view [,options])*

Set the current view on the `LayoutView`, triggering `activated`, `ready` and `deactivated` events on the current and previous view during the lifecycle. `ensureRendered` is called on views passed to `setView`. By default `destroy` is called on the previous view when the new view is set.

To implement animations using `setView` pass a `transition` callback to `setView` which will receive the new view being set, the old view (if present), append, remove and complete functions which will execute the needed DOM and view operations.

    layout.setView(newView, {
      transition: function(newView, oldView, append, remove, complete) {
        append();
        yourAnimation(function() {
          remove();
          complete();
        });
      }
    });

### getView *view.getView()*

Get the current view that was previously set with `setView`.

## Thorax.Model

Enhances `Backbone.Model` with the concept of whether or not the model is populated and whether or not it should be automatically fetched. Note that when passing a model to `view.setModel` it must be an instance of `Thorax.Model` and not `Backbone.Model`.

### isEmpty *model.isEmpty()*

Used by the `empty` helper. In a collection the implementations of `isEmpty` and `isPopulated` differ, but in a model `isEmpty` is an alias for `!isPopulated`.

### isPopulated *model.isPopulated()*

Used by `setModel` to determine whether or not to fetch the model. The default implementation checks to see if any keys that are not `id` and are not default values have been set.

## Thorax.Collection

Enhances `Backbone.Collection` with the concept of whether or not the collection is populated and whether or not it should be automatically fetched. Note that when passing a collection to `view.setCollection` it must be an instance of `Thorax.Collection` and not `Backbone.Collection`.

### isEmpty *collection.isEmpty()*

Used by the `empty` helper and the `emptyTemplate` and `emptyItem` options of a `CollectionView` to check whether a collection is empty. A collection is only treated as empty if it `isPopulated` and zero length.

### isPopulated *collection.isPopulated()*

Used by `setCollection` to determine whether or not to fetch the collection.

## Thorax.CollectionView

A class that renders an `itemTemplate` or `itemView` for each item in a `collection` passed to it in its constructor, or via `setCollection`. The view will automatically update when items are added, removed or changed.

The `collection` helper will automatically create and embed a `CollectionView` instance for you. If programmatic access to the view's methods are needed (for instance calling `appendItem` or specifying an `itemFilter`) it's best to create a `CollectionView` directly and embed it with the `view` helper as you would any other view.

### itemTemplate *view.itemTemplate*

A template name or template function to use when rendering each model. If using the `collection` helper the passed block will become the `itemTemplate`. Defaults to `view.name + '-item'`

### itemView *view.itemView*

A view class to be initialized for each item. Can be used in conjunction with `itemTemplate`.

### itemContext *view.itemContext(model, index)*

A function in the declaring view to specify the context for an `itemTemplate`, receives model and index as arguments. `itemContext` will not be used if an `itemView` is specified as the `itemView`'s own `context` method will instead be used.

A collection helper may specify a specific function to use as the `itemContext` if there are multiple collections in a view:

    {{#collection todos item-context="todosItemContext"}}

### itemFilter *view.itemFilter(model, index)*

A method, which if present will filter what items are rendered in a collection. Receives `model` and `index` and must return boolean. The filter will be applied when models' fire a change event, or models are added and removed from the collection. To force a collection to re-filter, call `updateFilter` on the view or collection view.

Items are hidden and shown with `$.hide` and `$.show` rather than being removed or appended. In performance critical views with large collections consider filtering the collection before it is passed to the view or on the server.

A collection helper may specify a specific function to use as the `itemFilter` if there are multiple collections in a view:

    {{#collection todos item-filter="todosItemFilter"}}

### updateFilter *view.updateFilter()*

If using `itemFilter`, call this method to force the collection view to re-filter.

### emptyTemplate *view.emptyTemplate*

A template name or template function to display when the collection is empty. If used in a `collection` helper the inverse block will become the `emptyTemplate`. Defaults to `view.name + '-empty'`

### emptyView *view.emptyView*

A view class to create an instance of when the collection is empty. Can be used in conjunction with `emptyTemplate`.

### loadingTemplate *view.loadingTemplate*

A template name or template function to display when the collection is loading.

### loadingView *view.loadingView*

A view class to create an instance of when the collection is loading.  Can be used in conjunction with `loadingTemplate`.

### loadingPlacement *view.loadingPlacement()*

An index to place the `loadingView` or `loadingTemplate` at. Defaults to `this.collection.length`.

### appendItem *view.appendItem(modelOrView [,index] [,options])*

Append a model (which will used to generate a new `itemView` or render an `itemTemplate`) or a view at a given index in the `CollectionView`. If passing a view as the first argument `index` may be a model which will be used to look up the index.

By default this will trigger a `rendered:item` event, `silent: true` may be passed in the options hash to prevent this. To also prevent the appended item from being filtered if an `itemFilter` is present pass `filter: false` in the options hash.

### removeItem *view.removeItem(model)*

Remove an item from the view.

### updateItem *view.updateItem(model)*

Equivalent to calling `removeItem` then `appendItem`. Note that this is mainly meant to cover edge cases, by default changing a model will update the needed item (whether using `itemTemplate` or `itemView`).

## Thorax.Util

### tag *Thorax.Util.tag(name, htmlAttributes [,content] [,context])*

Generate an HTML string. All built in HTML generation uses this method. If `context` is passed any Handlebars references inside of the htmlAttributes values will rendered with the context.

    Thorax.Util.tag("div", {
      id: "div-{{number}}"
    }, "content of the div", {
      number: 3
    });

## Thorax.ServerMarshal

The `ServerMarshal` provides a mechanism for sharing data between server rendered content and the views that restore upon the HTML on the client.

When dealing with simple primitives that may be serialized via JSON the values are stored directly in the server marshal store JSON object. For more complex objects such as models, collections, and views, a path relative to the handlebars rendering context is saved as a reference that can be resolved against the client-side equivalents.

### store *Thorax.ServerMarshal.store($el, name, data, dataIds, options)*

Associates the given data with `$el` in the server marshal data store. May be restored on the client side via the `Thorax.ServerMarshal.load` API.

- `$el` the `$` instance associated with the given element
- `name` the name of the data point to be saved
- `data` data to be stored. May be an array, object, or primitive value. Complex values must contain only primitive values or have proper associated `dataIds` element to allow for lookup on the client side.
- `dataIds` context paths associated with the data defined in `data`, if available.
- `options` options object. This object generally mirrors the options object passed to handlebars helpers, which may be passed directly. Fields may include:
  - `data` current handlebars data object
    - `contextPath` current context path for execution scope
    - `root` current handlebars root rendering context
    - `view` current view being rendered

Data storage rules:
- Numbers, Strings, Booleans, Nulls, and Objects with a `toJSON` implementation as all stringified
- When `dataIds` is a string value, the context path is stored for the `data` field
- When paired with a matching `dataId` structure, Arrays and objects are evaluated to one level deep.
  - Primitive values fitting above are stringified
  - All other objects are store the context path by combining `options.data.contextPath` and `dataIds[key]`
- Otherwise a `server-marshal-object` error is thrown


The `contextPath` value is a data field tracked within Handlebars helpers. This is is the "path" from the root of the context that a particular handlebars lookup resolves to and is used to lookup the helper parameters at restore time. As a general rule if you are calling `fn` or `inverse` with a different context than you were called with then you will likely need to update the `contextPath` value. The `appendContextPath` helper is available for simple path updates:

```javascript
  data.contextPath = Handlebars.Utils.appendContextPath(data.contextPath, 'foo');
```

### load *Thorax.ServerMarshal.load(el, name, parentView, context)*

Returns the named server data for a given element.

- `el` element to load data for
- `name` data item name
- `parentView` the view instance that contains this particular element
- `context` the rendering context

For complex objects, `parentView` and `context` will be used to lookup any context path objects saved from the server side. `context` values take priority over `parentView` values to match the behavior of the rendering pipeline.

### serialize *Thorax.ServerMarshal.serialize()*

Retrieves the stringified representation of the marshal data set. Generally this does not need to be called explicitly as an `onEmit` handler will ensure that the data is output for the client exec.

### destory *Thorax.ServerMarshal.destroy($el)*

Removes any marshal data that may be associated with a given element.

## $

### $.view *$(event.target).view([options])*

Get a reference to the nearest parent view. Pass `helper: false` to options to exclude `HelperView`s from the lookup. Useful when registering DOM event handlers:

    $(event.target).view();

### $.model *$(event.target).model([view])*

Get a reference to the nearest bound model. Can be used with any `$` object but most useful in event handlers.

    $(event.target).model();

A `view` may be optionally passed to limit the lookup to a specific view.

### $.collection *$(event.target).collection([view])*

Get a reference to the nearest bound collection. Can be used with any `$` object but most useful in event handlers.

    $(event.target).collection();

A `view` may be optionally passed to limit the lookup to a specific view.

## Event Enhancements

Thorax adds inheritable class events for all Thorax classes and significant enhancements to the Thorax.View event handling.

### Inheritable Events *ViewClass.on(eventName, callback)*

All Thorax classes have an `on` method to observe events on all instances of the class. Subclasses inherit their parents' event handlers. Accepts any arguments that can be passed to `viewInstance.on` or declared in the `events` hash.

    Thorax.View.on({
      'click a': function(event) {

      }
    });

### Model Events

When a model is bound to a view with `setModel` (automatically called by passing a `model` option in the constructor) any events on the model can be observed by the view in this way. For instance to observe any model `change` event when it is bound to any view:

    Thorax.View.on({
      model: {
        change: function() {
          // "this" will refer to the view
        }
      }
    });

### Collection Events

When a collection is bound to a view with `setCollection` (automatically called by passing a `collection` option in the constructor) any events on the collection can be observed by the view in this way. For instance to observe any collection `reset` event when it is bound to any view:

    Thorax.View.on({
      collection: {
        reset: function() {
          // "this" will refer to the view
        }
      }
    });

### View Events *view.events.viewEventName*

The `events` hash has been enhanced to allow view events to be registered along side DOM events:

    Thorax.View.extend({
      events: {
        'click a': function(event) {},
        rendered: function() {}
      }
    });

### DOM Events *view.on(eventNameAndSelector, callback [,context])*

The `on` method will now accept event strings in the same format as the events hash, for instance `click a`. Events separated by a space will still be treated as registering multiple events so long as the event name does not start with a DOM event name (`click`, `change`, `mousedown` etc).

DOM events observed in this way will only operate on the view itself. If the view embeds other views with the `view` helper that would match the event name and selector, they will be ignored. For instance declaring:

    view.on('click a', function(event) {})

Will only listen for clicks on `a` elements within the view. If the view has children that has `a` elements, this handler will not observe clicks on them.

DOM events may be prefixed with the special keyword `nested` which will apply the event to all elements in child views:

    view.on('nested click a', function() {})

Thorax will add an attribute to the event named `originalContext` that will be the `Element` object that would have been set as `this` had the handler been registered with jQuery / Zepto:

    $('a').on('click', function() {});
    view.on('click a', function(event) {
      // event.originalContext === what "this" would be in the
      // first handler
    });

When doing a server render, all DOM event handlers are silently discarded, as the majority do not make sense and environments such as Fruit Loops do not support. Code that relies on DOM events such as `submit` will need to take this into account.

### _addEvent *view._addEvent(eventParams)*

This method is never called directly, but can be specified to override the behavior of the `events` hash or any event arguments passed to `on`. For each event declared in either manner `_addEvent` will be called with a hash containing:

- type "view" || "DOM"
- name (DOM events will begin with ".delegateEvents")
- originalName
- selector (DOM events only)
- handler

All of the behavior described in this section is implemented via this method, so if overriding make sure to call `Thorax.View.prototype._addEvent` in your child view.

## Data Loading

### Queuing

Thorax wraps `fetch` (and therefore `load`) on models and collections with a queuing mechanism to ensure that multiple `sync` calls for the same url will not trigger multiple HTTP requests. To force a `fetch` or `load` call to create a new HTTP request regardless of whether an identical request is in the queue use the `resetQueue` option:

    model.fetch({
      resetQueue: true
      success: function() {}
    });

### bindToRoute *Thorax.Util.bindToRoute(callback [,failback])*

Used by `model.load` and `collection.load`. Binds the callback to the current route. If the browser navigtates to another route in the time between when the callback is bound and when it is executed, callback will not be called. Else failback will be called if present.

    routerMethod: function() {
      var callback = Thorax.Util.bindToRoute(function() {
        //callback called if browser is still on route
      });
      setTimeout(callback, 5000);
    }

### load *modelOrCollection.load(callback [,failback] [,options])*

Calls `fetch` on the model or collection ensuring the callbacks will only be called if the route does not change. `callback` and `failback` will be used as arguments to `bindToRoute`. `options` will be passed to the `fetch` call on the model or collection if present.

    routerMethod: function(id) {
      var view = new Thorax.View();
      var model = new Application.Model({id: id});
      model.load(function() {
        //callback only called if browser still on this route
        view.setModel(model);
        myLayoutView.setView(view);
      }, function() {
        //failback only called if browser has left this route
      });
    }

Triggers `load:start` and `load:end` events on the model or collection, and additionally on a view if it has bound the object via `setModel` or `setCollection`.

By default the events will propagate to a root object set with `setRootObject`. Pass `background: true` as an option to prevent the event from being triggered on the rootObject.


### setRootObject *Thorax.setRootObject(obj)*

Set the root object that will receive `load:start` and `load:end` events if the `load:start` was not a `background` event. This is useful to implement a global loading indicator.

### loadHandler *Thorax.loadHandler(startCallback, endCallback)*

Generates an `load:start` event handler that when triggered will then monitor the associated object for a `load:end` event. If the duration between the start and the end events exceed `_loadingTimeoutDuration` then the `start` and `end` callbacks will be triggered at the appropriate times to allow the display of a loading UI.

    view.on("load:start", Thorax.loadHandler(
      function(message, background, object) {
        view.$el.addClass("loading");
      },
      function(background, object) {
        view.$el.removeClass("loading");
      }));

### _loadingClassName *view._loadingClassName*

Class name to add and remove from a view's `el` when it is loading. Defaults to `loading`.

### _loadingTimeoutDuration *view._loadingTimeoutDuration*

Timeout duration in seconds before a `load:start` callback will be triggered. Defaults to 0.33 seconds. If for instance the `load:end` event was triggered 0.32 seconds after the `load:start` event the `load:start` callback would not be called.

### _loadingTimeoutEndDuration *view._loadingTimeoutEndDuration*

Just like `_loadingTimeoutDuration` but applies to `load:end`. Defaults to 0.10 seconds.

## Template Helpers

### template *{{template name [options]}}*

Embed a template inside of another, as a string. An associated view (if any) will not be initialized. By default the template will be called with the current context but extra options may be passed which will be added to the context.

    {{template "path/to/template" key="value"}}

If a block is used, the template will have a variable named `@yield` available that will contain the contents of the block.

    {{#template "child"}}
      content in the block will be available in a variable
      named "@yield" inside the template "child"
    {{/template}}

This is useful when a child template will be called from multiple different parents.

### super *{{super}}*

Embed the `template` from the parent view within the child template.

    {{super}}

### view *{{view name [options]}}*

Embed one view in another. The first argument may be the name of a new view to initialize or a reference to a view that has already been initialized.

    {{view "path/to/view" key="value"}}
    {{view viewInstance}}

If a block is specified it will be assigned as the `template` to the view instance:

    {{#view viewInstance}}
      viewInstance will have this block
      set as its template property
    {{/view}}

### element *{{element name [options]}}*

Embed a DOM element in the view. This uses a placeholder technique to work, if the placeholder must be of a certain type in order to be valid (for instance a `tbody` inside of a `table`) specify a `tag` option.

    {{element domElement tag="tbody"}}

### button *{{#button methodName [htmlAttributes...]}}*

Creates a `button` tag that will call the specified methodName on the view when clicked. Arbitrary HTML attributes can also be specified.

    {{#button "methodName" class="btn"}}Click Me{{/button}}

The tag name may also be specified:

    {{#button "methodName" tag="a" class="btn"}}A Link{{/button}}

A `trigger` attribute will trigger an event on the declaring view:

    {{#button trigger="eventName"}}Button{{/button}}

A button can have both a `trigger` attribute and a method to call:

    {{#button "methodName" trigger="eventName"}}Button{{/button}}

The method may also be specified as a `method` attribute:

    {{#button method="methodName"}}Button{{/button}}

### url *{{url urlString expand-tokens=bool}}*

Prepends "#" if `Backbone.history.pushSate` is disabled or prepends `Backbone.history.root` if it is enabled. If `expand-tokens=true` is passed, then any handlebars tokens will be resolved with the current context. For example if the context had an `id` attribute `{{id}}` would be replaced with the value of `id`:

    {{url "articles/{{id}}" expand-tokens=true}}

Multiple arguments can be passed and will be joined with a "/":

    {{url "articles" id}}

### link *{{#link url [htmlAttributes...]}}*

Creates an `a` tag that will call `Backbone.history.navigate()` with the given url when clicked. Passes the `url` parameter to the `url` helper with the current context. Do not use this method for creating external links. Like the `url` helper, multiple arguments may be passed as well as an `expand-tokens` option.

    {{#link "articles/{{id}}" expand-tokens=true class="article-link"}}Link Text{{/link}}

To call a method from an `a` tag use the `button` helper:

    {{#button "methodName" tag="a"}}My Link{{/button}}

Like the `button` helper, a `trigger` attribute may be specified that will trigger an event on the declaring view in addition to navigating to the specified url:

    {{#link "articles" id trigger="customEvent"}}Link Text{{/link}}

The href attribute is required but may also be specified as an attribute:

    {{#link href="articles/{{id}}" expand-tokens=true}}Link Test{{/link}}

### collection *{{collection [collection] [options...]}}*

Creates and embeds a `CollectionView` instance, updating when items are added, removed or changed in the collection. If a block is passed it will be used as the `item-template`, which will be called with a context of the `model.attributes` for each model in the collection.

    {{#collection tag="ul"}}
      <li>{{modelAttr}}</li>
    {{/collection}}

Options may contain `tag`, `class`, `id` and the following attributes which will map to the generated `CollectionView` instance:

- `item-template` &rarr; `itemTemplate`
- `item-view` &rarr; `itemView`
- `empty-template` &rarr; `emptyTemplate`
- `empty-view` &rarr; `emptyView`
- `loading-template` &rarr; `loadingTemplate`
- `loading-view` &rarr; `loadingView`
- `item-context` &rarr; `itemContext`
- `item-filter` &rarr; `itemFilter`

Any of the options can be specified as variables in addition to strings:

    {{collection item-view=itemViewClass}}

By default the collection helper will look for `this.collection`, but if your view contains multiple collections a collection argument may be passed:

    {{collection myCollection}}

When rendering `this.collection` many properties will be forwarded from the view that is declaring the collection helper to the generated `CollectionView` instance:

- `itemTemplate`
- `itemView`
- `itemContext`
- `itemFilter`
- `emptyTemplate`
- `emptyView`
- `loadingTemplate`
- `loadingView`
- `loadingPlacement`

As a result the following two views are equivalent:

    // render with collection helper, collection
    // properties are forwarded
    var view = new Thorax.View({
      collection: new Thorax.Collection(),
      itemView: MyItemClass,
      itemContext: function(model, i) {
        return model.attributes;
      },
      template: Handlebars.compile('{{collection}}')
    });

    // directly create collection view, no property
    // forwarding will occur
    var view = new Thorax.View({
      collectionView: new Thorax.CollectionView({
        collection: new Thorax.Collection(),
        itemView: MyItemClass
        itemContext: function(model, i) {
          return model.attributes;
        }
      }),
      template: Handlebars.compile('{{view collectionView}}')
    });

### empty *{{#empty [modelOrCollection]}}*

A conditional helper much like `if` that calls `isEmpty` on the specified object. In addition it will bind events to re-render the view should the object's state change from empty to not empty, or visa versa.

    {{#empty collection}}
      So empty!
    {{else}}
      {{#collection}}{{/collection}}
    {{/empty}}

To embed a row within a `collection` helper if it the collection is empty, specify an `empty-view` or `empty-template`. Or use the `else` block of the `collection` helper:

    {{#collection tag="ul"}}
      <li>Some very fine data</li>
    {{else}}
      <li>So very empty</li>
    {{/collection}}

### collection-element *{{collection-element [htmlAttributes...]}}*

By default `Thorax.CollectionView` instances have no template. Items will be appended to and removed from the view's `el`. Alternatively a template can be specified and `collection-element` used to specify where the individual items in a collection will be rendered.

    <div>
      {{collection-element tag="ul" class="my-list"}}
    </div>

### layout-element *{{layout-element [htmlAttributes...]}}*

By default `Thorax.LayoutView` instances have no template, `setView` will append directly to the view's `el`. Alternatively a template can be specified and a `layout-element` and `setView` will append to that element.

    <ul>
      {{layout-element tag="li" id="my-layout"}}
    </ul>

### loading *{{#loading}}*

A block helper to use when the view is loading. For collection specific loading the `CollectionView` accepts `loadingView` and `loadingTemplate` options to append an item in a collection when it is loading.

    {{#loading}}
      View is loading a model or collection.
    {{else}}
      View is not loading a model or collection.
    {{/loading}}

## Catalog of Built-in Events

### rendered *rendered ()*

Triggered on a view when the `rendered` method is called.

### child *child (instance)*

Triggered on a view every time a child view is appended into the view with the `view` helper.

### ready *ready (options)*

Triggered when a view is appended to the DOM with `appendTo` or when a view is appended to a `LayoutView` via `setView`. Setting focus and other behaviors that depend on the view being present in the DOM should be handled in this event.

This event propagates to all children, including children that will be bound after the view is created. `options` will contain a `target` view, which is the view that triggered the event.

### activated *activated (options)*

Triggered on a view immediately after it was passed to a `LayoutView`'s `setView` method. Like `ready` this event propagates to children and the `options` hash will contain a `target` view.

### deactivated *deactivated (options)*

Triggered on a view when it was previously passed to the `setView` method on a `LayoutView`, and then another view is passed to `setView`. Triggered when the current view's `el` is still attached to the parent. Like `ready` this event propagates to children and the `options` hash will contain a `target` view.

### destroyed *destroyed ()*

Triggered on a view when the `release` method is called and the reference count is zero. Useful for implementing custom view cleanup behaviors. `release` will be also be called if it was previously passed to the `setView` method on a `LayoutView`, and then another view is passed to `setView`.

### change:view:start *change:view:start (newView [,oldView] ,options)*

Trigged on a `Thorax.LayoutView` immediately after `setView` is called.

### change:view:end *change:view:end (newView [,oldView] ,options)*

Trigged on a `Thorax.LayoutView` after `setView` is called, the old view has been destroyed (if present) and the new view has been attached to the DOM and had its `ready` event triggered.

### helper *helper (name [,args...] ,helperView)*

Triggered on a view when a view helper (such as `collection`, `empty`, etc) create a new `HelperView` instance.

### helper:name *helper:name ([,args...] ,helperView)*

Triggered on a view when a given view helper creates a new `HelperView` instance.

    {{#collection cats}}{{/collection}}

    view.on('helper:collection', function(collection, collectionView) {

    });

### serialize *serialize (attributes)*

Triggered on a view when `serialize` is called, before `validateInput` is called with the serialized attributes.

### validate *validate (attributes, errors)*

Triggered on a view when `serialize` is called, passed an attributes hash and errors array after `validateInput` is called. Use in combination with the `invalid` event to display and clear errors from your views.

    Thorax.View.on({
      validate: function(attributes, errors) {
        //clear previous errors if present
      },
      invalid: function(errors) {
        errors.forEach(function(error) {
          //lookup input by error.name
          //display error from error.message
        });
      }
    });

### invalid *invalid (errors)*

Triggered on a view when `serialize` is called, if `validateInput` returned an array with any errors.

### populate *populate (attributes)*

Triggered on a view when `populate` is called. Passed a hash containing the attributes that the view will be populated with.

### load:start *load:start (message, background, target)*

Triggered on a model or collection by `fetch` or `load` and on a view if it has bound the model or collection with `setModel` or `setCollection`. Always generate a handler for a `load:start` event with `Thorax.loadHandler`.

### load:end *load:end (target)*

Triggered on a model or collection by `fetch` or `load` and on a view if it has bound the model or collection with `setModel` or `setCollection`. Never observe this directly, always use `Thorax.loadHandler` on `load:start`.

### rendered:collection *rendred:collection (collectionView, collection)*

Triggered on a `CollectionView` or the view calling the `collection` helper every time `render` is called on the `CollectionView`.

### rendered:item *rendered:item (collectionView, collection, model, itemElement, index)*

Triggered on a `CollectionView` or the view calling the `collection` helper every time an item is rendered in the `CollectionView`.

### rendered:empty *rendered:empty (collectionView, collection)*

Triggered on a `CollectionView` or the view calling the `collection` helper every time the `emptyView` or `emptyTemplate` is rendered in the `CollectionView`.

### restore *restore(forceRerender)*

Triggered when the view is being restored to the current element. Listeners should be aware that it's possible for a rerender to occur while the restore event has triggered and should be able to handle this case gracefully. `after-restore` may provide a better option for cases that need to apply DOM changes after any potential render operations. If the current restore process will force a rerender then the `forceRerender` parameter will be truthy.

### after-restore *after-restore()*

Triggered when the view has been restored and possibly rerendered to the current element. If the current restore process will force a rerender then the `forceRerender` parameter will be truthy.

### restore:collection *restore:collection(collectionView, el)*

Triggered on a `CollectionView` or a view calling the `collection` helper when the collection is restored.

### restore:item *restore:item(collectionView, el)*

Triggered on a `CollectionView` or a view calling the `collection` helper upon restoring an individual item element in the collection.

### restore:empty *restore:empty(collectionView, el)*

Triggered on a `CollectionView` or a view calling the `collection` helper when a restore operation includes an empty view or template.

### restore:fail *restore:fail(info)*

Triggered when a particular view can not be restored. `info` may be a free form object but generally it will have a `type` field, outlined below, and a `view` field listing the view instance that failed.

Types:

- `previously-rendered`: View has been rendered already
- `remaining`: View has children that were not restored and must do a partial rerender
- `not-restorable`: View was explicitly marked as not restorable
- `serialize`: Unable to marshal one or more of the parameters passed to the helper
- `collection-remove`: Item removed due to not being found in client-side collection
- `collection-missing`: Item rendered due to not existing in server-side collection
- `collection-depthed-query`: Attempted to use an inline collection item or empty template with `../` references.


## HTML Attributes

Thorax and its view helpers generate a number of custom HTML attributes that may be useful in debugging or generating CSS selectors to be used as arguments to `$` or to create CSS. The `*-cid` attributes are generally used only internally. See `$.model`, `$.collection` and `$.view` to get a reference to objects directly from the DOM. The `*-name` attributes will only be present if the given objects have a `name` property.</p>

<table class="table table-bordered table-striped">
  <thead>
    <tr>
      <th>Attribute Name</th>
      <th>Attached To</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>`data-view-cid`</td>
      <td>Every view instances' `el`</td>
    </tr>
    <tr>
      <td>`data-view-name`</td>
      <td>Same as above, only present on named views</td>
    </tr>
    <tr>
      <td>`data-collection-cid`</td>
      <td>Element generated by the `collection helper`</td>
    </tr>
    <tr>
      <td>`data-collection-name`</td>
      <td>Same as above, only present when the bound collection is named</td>
    </tr>
    <tr>
      <td>`data-collection-empty`</td>
      <td>Set to "true" or "false" depending on whether the bound collection `isEmpty`</td>
    </tr>
    <tr>
      <td>`data-collection-element`</td>
      <td>Set by the `collection-element`, determines where a collection in a `CollectionView` will be rendered.</td>
      </tr>
    <tr>
      <td>`data-view-empty`</td>
      <td>Collection view's empty element</td>
    </tr>
    <tr>
      <td>`data-model-cid`</td>
      <td>A view's `el` if a model was bound to the view or each item element inside of elements generated by the collection helper</td>
    </tr>
    <tr>
      <td>`data-model-id`</td>
      <td>A view's `el` if a model was bound to the view or each item element inside of elements generated by the collection helper</td>
    </tr>
    <tr>
      <td>`data-model-name`</td>
      <td>Same as above, only present if the model is named</td>
    </tr>
    <tr>
      <td>`data-layout-cid`</td>
      <td>The element generated by the `layout` helper or `el` inside of a `LayoutView` or `ViewController` instance</td>
    </tr>
    <tr>
      <td>`data-view-helper`</td>
      <td>Elements generated by various helpers including `collection` and `empty` from the collection plugin</td>
    </tr>
    <tr>
      <td>`data-call-method`</td>
      <td>Elements generated by the `link` and `button` helpers</td>
    </tr>
    <tr>
      <td>`data-trigger-event`</td>
      <td>Elements generated by the `link` and `button` helpers</td>
    </tr>

    <tr>
      <td>`data-view-restore`</td>
      <td>View elements rendered on the server side. `true` signifies that restoring is possible. `false` that it's explicitly disallowed.</td>
    </tr>
    <tr>
      <td>`data-view-helper-restore`</td>
      <td>Helper View elements rendered on the server side. Provides the name of the helper view.</td>
    </tr>
    <tr>
      <td>`data-server-data`</td>
      <td>Elements with `ServerMarshal` data associated with them.</td>
    </tr>
  </tbody>
</table>

When creating CSS selectors it's recommended to use the generated attributes (especially `data-view-name`) rather than assigning custom IDs or class names for the sole purpose of styling.

    [data-view-name="my-view-name"] {
      border: 1px solid #ddd;
    }

## Error Handling

Certain critical code paths are executed using the `bindSection` and `runSection` APIs. Should code executed on these paths throw, additional information regarding the code location, etc may be logged and used for debugging.

Override these APIs with your own logging / debugging handler or utilize [Costanza](https://github.com/walmartlabs/costanza) for an enhanced error tracking.

### onException *Thorax.onException(name, error, info)*

Logs exceptions when they occur. Passed to the function are a unique identifier, `name`, the thrown exception, `error`, and an object containing any additional information, `info`. The default implementation simply rethrows the error.

    Throax.onException = function(name, error) {
      throw error;
    };

### bindSection *Thorax.bindSection(name, info, callback)*

Wraps a `callback` in an error wrapper. Included with the `callback` is an identifying `name` value and any relevant information, `info` that may help debugging the exception.

By default this calls `Thorax.onException` when an exception is thrown but implementors may override this method to provide additional error handling before exceptions occur.

### runSection *Thorax.runSection(name, info, callback)*

Immediately executed version of `bindSection`. The default implementation delegates to `bindSection`.

## Server Rendering

Server side rendering is designed around [Fruit Loops][fruit-loops], but may be performed in any environment that supports the `$` API as well as a few core APIs used to control the page life cycle.

- `$serverSide` Boolean flag set to true when rendering server side content.
- `FruitLoops.emit()` Called when the page should be sent back to the client.
- `FruitLoops.onEmit(calback)` Registers a `callback` which will be called just prior to the emit operation.

### Restore Process

The restore process involves walking the DOM hierarchy looking for nodes that are annotated with the `data-view-restore` attribute. When such a node is found Thorax will attempt to restore based on a variety of steps discussed in the [Restore Methods](#restore-methods) section below.

This process is kicked off by either an explicit call to `View.restore` or by calling `LayoutView.setView` on a previously restored layout view.

The application restore process might look something like:

    var appEl = $('[data-view-name="application"]');
    if (appEl.length) {
      // Restore the application view explicitly
      Application.restore(appEl);
    } else {
      $('body').append(Application.el);
      Application.render();
    }

Followed by normal controller execution, ultimately culminating in `setView` call, which will restore the rendered child.

### Restore Methods

There is no definitive algorithm for restoring views, instead the following heuristics are used. In the event of a mismatch the `restore:fail` event will be emitted on the candidate view with additional debugging information regarding what portion of the heuristic failed.

### General Rules

If the candidate view instance has already been rendered then the previous element will be replaced with the existing view element. This case is tracked by `restore:fail` with a type field of `prev-render`.

By default restore operations are depth first recursive. This allows for restore operations to partially rerender content for the minimal number of rerender operations.

Any view that is explicitly marked with `data-view-restore=false` will be rerendered on the client. This shortcircuits the tree traversal and causes all children to be rerendered as well.

### `setView` calls

When `setView` is called an attempt will be made to restore the view to the layout view's child element if marked for restore. This assumes that the view is a named view. Should it not be a rerender will occur.

### Helper Views

Elements rendered via a helper view such as `view` or `collection` will automatically be restored. This is done by saving the parameters passed to the helper view into the server marshal store. On restore the helper view will be executed in a similar manner to the initial execution, with the distinction that the `restore` method will be called after the view has initialized.

When using helper views the restore might be forced to rerender if utilizing helpers that do no properly set the `contextPath` or if passed a depthed parameter, i.e. `{{view ../foo}}` as these can not be safely resolved. This is tracked via the `restore:fail` event with type `serialize` and is determined on the server-side.

Additionally helpers that utilize subexpressions to resolve complex values are unable to be restored via path lookup and will force a rerender.

### Collection Views

Collection views follow the same restore rules as helper views but add the ability to restore nested child views.

Rerender cases (additional to the helper cases):
- Use of a block helper that has a `../` reference:
```html
  {{#collection}}{{../foo}}{{/collection}}
```
- Use of collections that do not have an `id` value.

Note that overriding `renderItem` is allowed but discouraged as this has additional overhead vs. providing an `itemView` or `itemTemplate` value. This also applies to `renderEmpty`.


## Best Practices

In general there are a number of things that help avoid rerender cases.

### Logging

While in development mode tracking the number of times that a rerender case is triggered is vital for ensuring that the restore behavior is actually benefiting the site.

This might be as simple as a global logger on the `restore:fail` event:

```javascript
View.on('restore:fail', function(info) {
  console.log('restore:fail', info);
});
```

### Custom Restore Logic

It's recommended that views needing custom restore behavior do so by providing a `restore` event listener rather than overriding the `restore` method. This is due to the manner in which partial restores are implemented, delegating to the super class implementation may cause a rerender meaning any non-restored children are rerendered as well.

Should a view absolutely need to prevent the default restore behavior it can override the `restore` method but it must manually remove the `data-view-restore` attribute and also perform any child traversal necessary.

For most situations it should not be necessary to provide a custom restore implementation but cases that implement custom view insertion logic, i.e. calling DOM methods to insert the child view, will likely need to provide some level of custom restore logic. Ex:

```javascript
  CustomView.on('restore', function() {
    var child = this.$('.child-view');
    if (child.length) {
      this.childView.restore(child);
    }
  });
```

### Data Loading

Since pending fetch operations might rerender the content of a just restored view, it's recommended that the JSON content is cached in a manner that is accessible on the initial page load to avoid unnecessary rendering operations after restore. [Fruit Loops][fruit-loops] offers such a system via the `$serverCache` local variable. Should this not be possible, the thorax rendering pipeline will handle any the restore and subsequent rerender properly.

Note that there are issues that might arise if a different model data source is used on the client vs. the server, a personalized vs public data source for example. When such data is loaded prior to the restore operation, it might be necessary to provide a custom restore step that checks if this data has changed and rerender as there is no clean way for Thorax to determine if a model's data has changed between the two states.

## Error Codes

### button-trigger

`button` helper must have a method name as the first argument or a 'trigger', or a 'method' attribute specified.

### link-href

`link` helper requires an href as the first argument or an `href` attribute.

### collection-element-helper

`collection-element` helper must be declared inside of a `CollectionView`

### super-parent

Cannot use `super` helper when parent has no name or template.

### view-helper-hash-args

Hash arguments are not allowed in the `view` helper as templates should not introduce side effects to view instances.

### layout-element-helper

`layout-element` helper must be used within a `LayoutView`.

### mixed-fetch

Both `set` and `reset` were passed to `fetch`, must use one or the other.

### nested-render

`render` was called which triggered an event handler which in turn called `render`. Infinite recursion was halted.

### handlebars-no-data

Handlebars template compiled without data, use: `Handlebars.compile(template, {data: true})`

### insert-destroyed

A helper view that has been destroyed was inserted into the view.

### void-tag-content

A void tag such as `img` was rendered with `content` in `Thorax.Util.tag`.

### server-marshal-object

A complex object was serialized without a proper context path to lookup the object on the client side. See [Thorax.ServerMarshal](#thoraxservermarshal) for more discussion on context paths.

### fn-view-unregistered

`$.view` found a view element that was inserted manually into the DOM and was not registered with `_addChild` or `retain`. Call `parent._addChild(view)` or `view.retain()` on view insertion or instantiation.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/walmartlabs/thorax/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

[fruit-loops]: https://github.com/walmartlabs/fruit-loops
[phantomjs]: http://phantomjs.org/