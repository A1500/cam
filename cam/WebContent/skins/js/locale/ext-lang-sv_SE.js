

/**
 * Swedish translation (utf8-encoding)
 * By Erik Andersson, Monator Technologies
 * 24 April 2007
 * Changed by Cariad, 29 July 2007
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Laddar...</div>';

if(L5.View){
   L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} markerade rad(er)";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "Stäng denna flik";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "Värdet i detta fält är inte tillåtet";
}

if(L5.LoadMask){
   L5.LoadMask.prototype.msg = "Laddar...";
}

Date.monthNames = [
   "januari",
   "februari",
   "mars",
   "april",
   "maj",
   "juni",
   "juli",
   "augusti",
   "september",
   "oktober",
   "november",
   "december"
];

Date.dayNames = [
   "söndag",
   "måndag",
   "tisdag",
   "onsdag",
   "torsdag",
   "fredag",
   "lördag"
];

if(L5.MessageBox){
   L5.MessageBox.buttonText = {
      ok     : "OK",
      cancel : "Avbryt",
      yes    : "Ja",
      no     : "Nej"
   };
}

if(L5.util.Format){
   L5.util.Format.date = function(v, format){
      if(!v) return "";
      if(!(v instanceof Date)) v = new Date(Date.parse(v));
      return v.dateFormat(format || "Y-m-d");
   };
}

if(L5.DatePicker){
   L5.apply(L5.DatePicker.prototype, {
      todayText         : "Idag",
      minText           : "Detta datum inträffar före det tidigast tillåtna",
      maxText           : "Detta datum inträffar efter det senast tillåtna",
      disabledDaysText  : "",
      disabledDatesText : "",
      monthNames	: Date.monthNames,
      dayNames		: Date.dayNames,
      nextText          : 'Nästa månad (Ctrl + högerpil)',
      prevText          : 'Föregående månad (Ctrl + vänsterpil)',
      monthYearText     : 'Välj en månad (Ctrl + uppåtpil/neråtpil för att ändra årtal)',
      todayTip          : "{0} (mellanslag)",
      format            : "Y-m-d",
      startDay          : 1
   });
}

if(L5.PagingToolbar){
   L5.apply(L5.PagingToolbar.prototype, {
      beforePageText : "Sida",
      afterPageText  : "av {0}",
      firstText      : "Första sidan",
      prevText       : "Föregående sida",
      nextText       : "Nästa sida",
      lastText       : "Sista sidan",
      refreshText    : "Uppdatera",
      displayMsg     : "Visar {0} - {1} av {2}",
      emptyMsg       : 'Det finns ingen data att visa'
   });
}

if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "Minsta tillåtna längd för detta fält är {0}",
      maxLengthText : "Största tillåtna längd för detta fält är {0}",
      blankText     : "Detta fält är obligatoriskt",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "Minsta tillåtna värde för detta fält är {0}",
      maxText : "Största tillåtna värde för detta fält är {0}",
      nanText : "{0} är inte ett tillåtet nummer"
   });
}

if(L5.form.DateField){
   L5.apply(L5.form.DateField.prototype, {
      disabledDaysText  : "Inaktiverad",
      disabledDatesText : "Inaktiverad",
      minText           : "Datumet i detta fält måste inträffa efter {0}",
      maxText           : "Datumet i detta fält måste inträffa före {0}",
      invalidText       : "{0} är inte ett tillåtet datum - datum ska anges i formatet {1}",
      format            : "Y-m-d"
   });
}

if(L5.form.ComboBox){
   L5.apply(L5.form.ComboBox.prototype, {
      loadingText       : "Laddar...",
      valueNotFoundText : undefined
   });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'Detta fält ska innehålla en e-post adress i formatet "användare@domän.se"',
      urlText      : 'Detta fält ska innehålla en länk (URL) i formatet "http:/'+'/www.domän.se"',
      alphaText    : 'Detta fält får bara innehålla bokstäver och "_"',
      alphanumText : 'Detta fält får bara innehålla bokstäver, nummer och "_"'
   });
}

if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "Sortera stigande",
      sortDescText : "Sortera fallande",
      lockText     : "Lås kolumn",
      unlockText   : "Lås upp kolumn",
      columnsText  : "Kolumner"
   });
}

if(L5.grid.PropertyColumnModel){
   L5.apply(L5.grid.PropertyColumnModel.prototype, {
      nameText   : "Namn",
      valueText  : "Värde",
      dateFormat : "Y-m-d"
   });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "Dra för att ändra storleken.",
      collapsibleSplitTip : "Dra för att ändra storleken. Dubbelklicka för att gömma."
   });
}
