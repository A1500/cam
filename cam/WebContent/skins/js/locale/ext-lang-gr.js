

/**
 * Greek (Old Version) Translations by Vagelis
 * 03-June-2007
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Öüñôùóç...</div>';

if(L5.View){
   L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} åðéëåãìÝíç(åò) ãñáììÞ(Ýò)";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "Êëåßóôå áõôÞ ôçí êáñôÝëá";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "Ç ôéìÞ óôï ðåäßï äåí åßíáé Ýãêõñç";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "Öüñôùóç...";
}

Date.monthNames = [
   "ÉáíïõÜñéïò",
   "ÖåâñïõÜñéïò",
   "ÌÜñôéïò",
   "Áðñßëéïò",
   "ÌÜéïò",
   "Éïýíéïò",
   "Éïýëéïò",
   "Áýãïõóôïò",
   "ÓåðôÝìâñéïò",
   "Ïêôþâñéïò",
   "ÍïÝìâñéïò",
   "ÄåêÝìâñéïò"
];

Date.dayNames = [
   "ÊõñéáêÞ",
   "ÄåõôÝñá",
   "Ôñßôç",
   "ÔåôÜñôç",
   "ÐÝìðôç",
   "ÐáñáóêåõÞ",
   "ÓÜââáôï"
];

if(L5.MessageBox){
   L5.MessageBox.buttonText = {
      ok     : "ÅíôÜîåé",
      cancel : "Áêýñùóç",
      yes    : "Íáé",
      no     : "¼÷é"
   };
}

if(L5.util.Format){
   L5.util.Format.date = function(v, format){
      if(!v) return "";
      if(!(v instanceof Date)) v = new Date(Date.parse(v));
      return v.dateFormat(format || "ì/ç/Å");
   };
}

if(L5.DatePicker){
   L5.apply(L5.DatePicker.prototype, {
      todayText         : "ÓÞìåñá",
      minText           : "Ç çìåñïìçíßá áõôÞ åßíáé ðñéí ôçí ìéêñüôåñç çìåñïìçíßá",
      maxText           : "Ç çìåñïìçíßá áõôÞ åßíáé ìåôÜ ôçí ìåãáëýôåñç çìåñïìçíßá",
      disabledDaysText  : "",
      disabledDatesText : "",
      monthNames	: Date.monthNames,
      dayNames		: Date.dayNames,
      nextText          : 'Åðüìåíïò ÌÞíáò (Control+Right)',
      prevText          : 'Ðñïçãïýìåíïò ÌÞíáò (Control+Left)',
      monthYearText     : 'ÅðéëÝîôå ÌÞíá (Control+Up/Down ãéá ìåôáêßíçóç óôá Ýôç)',
      todayTip          : "{0} (Spacebar)",
      format            : "ì/ç/Å"
   });
}

if(L5.PagingToolbar){
   L5.apply(L5.PagingToolbar.prototype, {
      beforePageText : "Óåëßäá",
      afterPageText  : "áðü {0}",
      firstText      : "Ðñþôç óåëßäá",
      prevText       : "Ðñïçãïýìåíç óåëßäá",
      nextText       : "Åðüìåíç óåëßäá",
      lastText       : "Ôåëåõôáßá óåëßäá",
      refreshText    : "ÁíáíÝùóç",
      displayMsg     : "ÅìöÜíéóç {0} - {1} áðü {2}",
      emptyMsg       : 'Äåí âñÝèçêáí åããñáöÝò ãéá åìöÜíéóç'
   });
}

if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "Ôï åëÜ÷éóôï ìÝãåèïò ãéá áõôü ôï ðåäßï åßíáé {0}",
      maxLengthText : "Ôï ìÝãéóôï ìÝãåèïò ãéá áõôü ôï ðåäßï åßíáé {0}",
      blankText     : "Ôï ðåäßï áõôü åßíáé õðï÷ñåùôïêü",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "Ç åëÜ÷éóôç ôéìÞ ãéá áõôü ôï ðåäßï åßíáé {0}",
      maxText : "Ç ìÝãéóôç ôéìÞ ãéá áõôü ôï ðåäßï åßíáé {0}",
      nanText : "{0} äåí åßíáé Ýãêõñïò áñéèìüò"
   });
}

if(L5.form.DateField){
   L5.apply(L5.form.DateField.prototype, {
      disabledDaysText  : "ÁðåíåñãïðïéçìÝíï",
      disabledDatesText : "ÁðåíåñãïðïéçìÝíï",
      minText           : "Ç çìåñïìçíßá ó' áõôü ôï ðåäßï ðñÝðåé íá åßíáé ìåôÜ áðü {0}",
      maxText           : "Ç çìåñïìçíßá ó' áõôü ôï ðåäßï ðñÝðåé íá åßíáé ðñéí áðü {0}",
      invalidText       : "{0} äåí åßíáé Ýãêõñç çìåñïìçíßá - ðñÝðåé íá åßíáé ôçò ìïñöÞò {1}",
      format            : "ì/ç/Å"
   });
}

if(L5.form.ComboBox){
   L5.apply(L5.form.ComboBox.prototype, {
      loadingText       : "Öüñôùóç...",
      valueNotFoundText : undefined
   });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'Áõôü ôï ðåäßï ðñÝðåé íá åßíáé e-mail address ôçò ìïñöÞò "user@domain.com"',
      urlText      : 'Áõôü ôï ðåäßï ðñÝðåé íá åßíáé ìéá äéåýèõíóç URL ôçò ìïñöÞò "http:/'+'/www.domain.com"',
      alphaText    : 'Áõôü ôï ðåäßï ðñÝðåé íá ðåñéÝ÷åé ãñÜììáôá êáé _',
      alphanumText : 'Áõôü ôï ðåäßï ðñÝðåé íá ðåñéÝ÷åé ãñÜììáôá, áñéèìïýò êáé _'
   });
}

if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "Áýîïõóá Ôáîéíüìçóç",
      sortDescText : "Öèßíïõóá Ôáîéíüìçóç",
      lockText     : "Êëåßäùìá óôÞëçò",
      unlockText   : "Îåêëåßäùìá óôÞëçò",
      columnsText  : "ÓôÞëåò"
   });
}

if(L5.grid.PropertyColumnModel){
   L5.apply(L5.grid.PropertyColumnModel.prototype, {
      nameText   : "¼íïìá",
      valueText  : "ÔéìÞ",
      dateFormat : "ì/ç/Å"
   });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "Óýñåôå ãéá áëëáãÞ ìåãÝèïõò.",
      collapsibleSplitTip : "Óýñåôå ãéá áëëáãÞ ìåãÝèïõò. Double click ãéá áðüêñõøç."
   });
}
