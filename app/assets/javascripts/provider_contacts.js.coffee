# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#provider_contact_contact_name').autocomplete
    source: $('#provider_contact_contact_name').data('autocomplete-source')
