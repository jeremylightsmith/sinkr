allow firefox to see local images, add this to ~/Library/Application Support/Firefox/.../prefs.js

  user_pref("capability.policy.policynames", "localfilelinks");
  user_pref("capability.policy.localfilelinks.sites", "http://localhost:4000");
  user_pref("capability.policy.localfilelinks.checkloaduri.enabled", "allAccess");
  
  see (http://kb.mozillazine.org/Firefox_:_Issues_:_Links_to_Local_Pages_Don%27t_Work)