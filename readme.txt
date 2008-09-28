allow firefox to see local images, add this to ~/Library/Application Support/Firefox/.../prefs.js

  user_pref("capability.policy.policynames", "localfilelinks");
  user_pref("capability.policy.localfilelinks.sites", "http://localhost:4000");
  user_pref("capability.policy.localfilelinks.checkloaduri.enabled", "allAccess");
  
  see (http://kb.mozillazine.org/Firefox_:_Issues_:_Links_to_Local_Pages_Don%27t_Work)
  
stories:
  - at select multiple events - done
  - at (de)select all events w/in a month
  - at (de)select all events w/in a year
  - at upload all selected events to flickr (if they aren't up there yet)
  - at download all selected events to iphoto (if they aren't down there yet)
  - at click on a flickr photo to go to the flickr page
  - at click on an iphoto photo to open it in iphoto
  - at always see batch actions on the top of the screen
  - at merge flickr & iphoto events by editing event names
  - at merge events on flickr
  - at merge events on iphoto
  - at see differences between #'s of photos in matching events
  - at see differences in names of photos in matching events
  
  