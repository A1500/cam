

/**
 * Slovenian translation by Matjaž (UTF-8 encoding)
 * 25 April 2007
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Nalagam...</div>';

if(L5.View){
   L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} izbranih vrstic";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "Zapri zavihek";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "Neveljavna vrednost";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "Nalagam...";
}

Date.monthNames = [
   "Januar",
   "Februar",
   "Marec",
   "April",
   "Maj",
   "Junij",
   "Julij",
   "Avgust",
   "September",
   "Oktober",
   "November",
   "December"
];

Date.dayNames = [
   "Nedelja",
   "Ponedeljek",
   "Torek",
   "Sreda",
   "Četrtek",
   "Petek",
   "Sobota"
];

if(L5.MessageBox){
   L5.MessageBox.buttonText = {
      ok     : "V redu",
      cancel : "Prekliči",
      yes    : "Da",
      no     : "Ne"
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
      todayText         : "Danes",
      minText           : "Navedeni datum je pred spodnjim datumom",
      maxText           : "Navedeni datum je za zgornjim datumom",
      disabledDaysText  : "",
      disabledDatesText : "",
      monthNames	: Date.monthNames,
      dayNames		: Date.dayNames,
      nextText          : 'Naslednji mesec (Control+Desno)',
      prevText          : 'Prejšnji mesec (Control+Levo)',
      monthYearText     : 'Izberite mesec (Control+Gor/Dol za premik let)',
      todayTip          : "{0} (Preslednica)",
      format            : "d.m.y",
      startDay          : 1
   });
}

if(L5.PagingToolbar){
   L5.apply(L5.PagingToolbar.prototype, {
      beforePageText : "Stran",
      afterPageText  : "od {0}",
      firstText      : "Prva stran",
      prevText       : "Prejšnja stran",
      nextText       : "Naslednja stran",
      lastText       : "Zadnja stran",
      refreshText    : "Osveži",
      displayMsg     : "Prikazujem {0} - {1} od {2}",
      emptyMsg       : 'Ni podatkov za prikaz'
   });
}

if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "Minimalna dolžina tega polja je {0}",
      maxLengthText : "Maksimalna dolžina tega polja je {0}",
      blankText     : "To polje je obvezno",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "Minimalna vrednost tega polja je {0}",
      maxText : "Maksimalna vrednost tega polja je {0}",
      nanText : "{0} ni veljavna številka"
   });
}

if(L5.form.DateField){
   L5.apply(L5.form.DateField.prototype, {
      disabledDaysText  : "Onemogočen",
      disabledDatesText : "Onemogočen",
      minText           : "Datum mora biti po {0}",
      maxText           : "Datum mora biti pred {0}",
      invalidText       : "{0} ni veljaven datum - mora biti v tem formatu {1}",
      format            : "d.m.y"
   });
}

if(L5.form.ComboBox){
   L5.apply(L5.form.ComboBox.prototype, {
      loadingText       : "Nalagam...",
      valueNotFoundText : undefined
   });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'To polje je e-mail naslov formata "ime@domena.si"',
      urlText      : 'To polje je URL naslov formata "http:/'+'/www.domena.si"',
      alphaText    : 'To polje lahko vsebuje samo črke in _',
      alphanumText : 'To polje lahko vsebuje samo črke, številke in _'
   });
}

if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "Sortiraj naraščajoče",
      sortDescText : "Sortiraj padajoče",
      lockText     : "Zakleni stolpec",
      unlockText   : "Odkleni stolpec",
      columnsText  : "Stolpci"
   });
}

if(L5.grid.PropertyColumnModel){
   L5.apply(L5.grid.PropertyColumnModel.prototype, {
      nameText   : "Ime",
      valueText  : "Vrednost",
      dateFormat : "j.m.Y"
   });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "Potegni za razširitev.",
      collapsibleSplitTip : "Potegni za razširitev. Dvojni klik, če želite skriti."
   });
}