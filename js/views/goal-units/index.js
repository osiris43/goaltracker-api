define([
  'view',
  'hbs!templates/goal-units/index'
], function (View, template) {
  return View.extend({
    name: 'goal-units/index',
    template: template
  });
});
