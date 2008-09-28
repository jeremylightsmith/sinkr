jQuery.fn.extend({
  update_selection_status: function() {
    var unselected = this.find('.event:not(.selected)').size();
    var selected = this.find('.event.selected').size();
    var name = this.find('>.name');
    if (unselected == 0) {
      name.removeClass('some_selected').addClass('all_selected')
    } else if (selected == 0) {
      name.removeClass('some_selected').removeClass('all_selected')
    } else {
      name.addClass('some_selected').removeClass('all_selected')
    }
    return this;
  },
  
  toggle_selection: function() {
    this.toggleClass('selected');
    this.month().update_selection_status();
    this.year().update_selection_status();
    return this;
  },
  
  toggle_selection_under: function() {
    var unselected = this.find('.event:not(.selected)').size();
    var events = this.find('.event')
    if (unselected > 0) {
      events.addClass('selected');
    } else {
      events.removeClass('selected');
    }
    
    this.update_selection_status();
    if (this.hasClass('month')) {
      this.year().update_selection_status();
    } else if (this.hasClass('year')) {
      this.find('.month').update_selection_status();
    }

    return this;
  },
  
  find_parent_with_class: function(className) {
    var parent = this.parent();
    while (parent != null) {
      if (parent.hasClass(className)) return parent;
      parent = parent.parent();
    }

    return null;
  },

  month: function() {
    return this.find_parent_with_class('month');
  },

  year: function() {
    return this.find_parent_with_class('year');
  }
});
