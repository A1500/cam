

/**
 * Latvian Translations
 * By salix 17 April 2007
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Notiek ielāde...</div>';

if(L5.View){
   L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} iezīmētu rindu";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "Aizver šo zīmni";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "Vērtība šajā laukā nav pareiza";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "Ielādē...";
}

Date.monthNames = [
   "Janvāris",
   "Februāris",
   "Marts",
   "Aprīlis",
   "Maijs",
   "Jūnijs",
   "Jūlijs",
   "Augusts",
   "Septembris",
   "Oktobris",
   "Novembris",
   "Decembris"
];

Date.dayNames = [
   "Svētdiena",
   "Pirmdiena",
   "Otrdiena",
   "Trešdiena",
   "Ceturtdiena",
   "Piektdiena",
   "Sestdiena"
];

if(L5.MessageBox){
   L5.MessageBox.buttonText = {
      ok     : "Labi",
      cancel : "Atcelt",
      yes    : "Jā",
      no     : "Nē"
   };
}

if(L5.util.Format){
   L5.util.Format.date = function(v, format){
      if(!v) return "";
      if(!(v instanceof Date)) v = new Date(Date.parse(v));
      return v.dateFormat(format || "d.m.Y");
   };
}

if(L5.DatePicker){
   L5.apply(L5.DatePicker.prototype, {
      todayText         : "Šodiena",
      minText           : "Norādītais datums ir mazāks par minimālo datumu",
      maxText           : "Norādītais datums ir lielāks par maksimālo datumu",
      disabledDaysText  : "",
      disabledDatesText : "",
      monthNames	: Date.monthNames,
      dayNames		: Date.dayNames,
      nextText          : 'Nākamais mēnesis (Control+pa labi)',
      prevText          : 'Iepriekšējais mēnesis (Control+pa kreisi)',
      monthYearText     : 'Mēneša izvēle (Control+uz augšu/uz leju lai pārslēgtu gadus)',
      todayTip          : "{0} (Tukšumzīme)",
      format            : "d.m.Y",
      startDay          : 1
   });
}

if(L5.PagingToolbar){
   L5.apply(L5.PagingToolbar.prototype, {
      beforePageText : "Lapa",
      afterPageText  : "no {0}",
      firstText      : "Pirmā lapa",
      prevText       : "iepriekšējā lapa",
      nextText       : "Nākamā lapa",
      lastText       : "Pēdējā lapa",
      refreshText    : "Atsvaidzināt",
      displayMsg     : "Rāda no {0} līdz {1} ierakstiem, kopā {2}",
      emptyMsg       : 'Nav datu, ko parādīt'
   });
}

if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "Minimālais garums šim laukam ir {0}",
      maxLengthText : "Maksimālais garums šim laukam ir {0}",
      blankText     : "Šis ir obligāts lauks",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "Minimālais garums šim laukam ir  {0}",
      maxText : "Maksimālais garums šim laukam ir  {0}",
      nanText : "{0} nav pareizs skaitlis"
   });
}

if(L5.form.DateField){
   L5.apply(L5.form.DateField.prototype, {
      disabledDaysText  : "Atspējots",
      disabledDatesText : "Atspējots",
      minText           : "Datumam šajā laukā jābūt lielākam kā {0}",
      maxText           : "Datumam šajā laukā jābūt mazākam kā {0}",
      invalidText       : "{0} nav pareizs datums - tam jābūt šādā formātā: {1}",
      format            : "d.m.Y"
   });
}

if(L5.form.ComboBox){
   L5.apply(L5.form.ComboBox.prototype, {
      loadingText       : "Ielādē...",
      valueNotFoundText : undefined
   });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'Šajā laukā jāieraksta e-pasta adrese formātā "lietotās@domēns.lv"',
      urlText      : 'Šajā laukā jāieraksta URL formātā "http:/'+'/www.domēns.lv"',
      alphaText    : 'Šis lauks drīkst saturēt tikai burtus un _ zīmi',
      alphanumText : 'Šis lauks drīkst saturēt tikai burtus, ciparus un _ zīmi'
   });
}

if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "Kārtot pieaugošā secībā",
      sortDescText : "Kārtot dilstošā secībā",
      lockText     : "Noslēgt kolonnu",
      unlockText   : "Atslēgt kolonnu",
      columnsText  : "Kolonnas"
   });
}

if(L5.grid.PropertyColumnModel){
   L5.apply(L5.grid.PropertyColumnModel.prototype, {
      nameText   : "Nosaukums",
      valueText  : "Vērtība",
      dateFormat : "j.m.Y"
   });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "Velc, lai mainītu izmēru.",
      collapsibleSplitTip : "Velc, lai mainītu izmēru. Dubultklikšķis noslēpj apgabalu."
   });
}