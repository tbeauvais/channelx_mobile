angular.module('starter.services', [])

.factory('Messages', function() {

  // stub data for now
  var messages = [
  {
    id: 5,
    name: 'TJ\'s',
    lastText: 'Announcing new menu items!',
    face: 'https://static.ctctcdn.com/galileo/images/templates/Galileo-Template-Images/VerticalLogos/VerticalLogo_Restaurant.png',
    link: 'https://s3.amazonaws.com/channelx/tjs_menu.html'
  }, {
    id: 1,
    name: 'IDEA',
    lastText: 'Come workout with a friend...',
    face: 'http://www.logotypes101.com/logos/634/088A6A6D443BA23D07A865AD3F7D19E7/Idea_Fitness__Wellness.png',
    link: 'http://www.ballouswinebar.com/Food_and_Wine/body_food_and_wine.html'
  },{
    id: 2,
    name: 'Arnie\'s',
    lastText: 'This week 2 for 1 special',
    face: 'http://cf.juggle-images.com/matte/white/280x280/arnie-s-restaurants-logo-primary.jpg',
    link: 'http://www.ballouswinebar.com/Food_and_Wine/body_food_and_wine.html'
  }, {
    id: 3,
    name: 'High School Pizza',
    lastText: 'Pizza by the slice',
    face: 'http://www.thebusinesslogo.com/logo-design-portfolio/logo-design-pizza.gif',
    link: 'http://www.ballouswinebar.com/Food_and_Wine/body_food_and_wine.html'
  }, {
    id: 4,
    name: 'Seaside Real Estate',
    lastText: 'Units available in your area',
    face: 'http://freelogo-assets.s3.amazonaws.com/sites/all/themes/freelogoservices/images/seaside1.jpg',
    link: 'http://www.ballouswinebar.com/Food_and_Wine/body_food_and_wine.html'
  }, {
    id: 0,
    name: 'The Olive Tree',
    lastText: 'Checkout our latest menu!',
    face: 'http://www.morairaonline24.com/images/olive_tree_new_logo.jpg',
    link: 'http://www.ballouswinebar.com/Food_and_Wine/body_food_and_wine.html'
  }
  ];

  return {
    all: function() {
      return messages;
    },
    remove: function(message) {
      messages.splice(messages.indexOf(message), 1);
    },
    get: function(messageId) {
      for (var i = 0; i < messages.length; i++) {
        if (messages[i].id === parseInt(messageId)) {
          return messages[i];
        }
      }
      return null;
    }
  };
});
