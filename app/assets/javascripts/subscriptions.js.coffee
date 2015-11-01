# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#subscription_client_name').autocomplete
    source: $('#subscription_client_name').data('autocomplete-source')
  $('#subscription_integration_name').autocomplete
    source: $('#subscription_integration_name').data('autocomplete-source')
