# Ember Pagination

Simple library to do ember pagination. Works with servers using the will_paginate API.

### How to Use

Just include dist/ember-pagination.js in your project after including Ember and Ember Data.

A showMore method is automatically added to Ember.ArrayController. 

In your template, put something like this to load the next page:

    <a href="#" {{action showMore}}>Show More</a>
