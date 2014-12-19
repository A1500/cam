

/*
 * Serbian Latin Translation
 * by Atila Hajnal (latin, utf8 encoding)
 * sr
 * 14 Sep 2007
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Učitavam...</div>';

if(L5.View){
   L5.View.prototype.emptyText = "Ne postoji ni jedan slog";
}

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} izabranih redova";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "Zatvori оvu »karticu«";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "Unešena vrednost nije pravilna";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "Učitavam...";
}

Date.monthNames = [
   "Januar",
   "Februar",
   "Mart",
   "April",
   "Мај",
   "Jun",
   "Јul",
   "Avgust",
   "Septembar",
   "Oktobar",
   "Novembar",
   "Decembar"
];

Date.dayNames = [
   "Nedelja",
   "Ponedeljak",
   "Utorak",
   "Sreda",
   "Četvrtak",
   "Petak",
   "Subota"
];

if(L5.MessageBox){
   L5.MessageBox.buttonText = {
      ok     : "U redu",
      cancel : "Odustani",
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
      todayText         : "Danas",
      minText           : "Datum је ispred najmanjeg dozvoljenog datuma",
      maxText           : "Datum је nakon najvećeg dozvoljenog datuma",
      disabledDaysText  : "",
      disabledDatesText : "",
      monthNames	: Date.monthNames,
      dayNames		: Date.dayNames,
      nextText          : 'Sledeći mesec (Control+Desno)',
      prevText          : 'Prethodni mesec (Control+Levo)',
      monthYearText     : 'Izaberite mesec (Control+Gore/Dole za izbor godine)',
      todayTip          : "{0} (Razmaknica)",
      format            : "d.m.y",
      startDay 		 : 1
   });
}

if(L5.PagingToolbar){
   L5.apply(L5.PagingToolbar.prototype, {
      beforePageText : "Strana",
      afterPageText  : "od {0}",
      firstText      : "Prva strana",
      prevText       : "Prethodna strana",
      nextText       : "Sledeća strana",
      lastText       : "Poslednja strana",
      refreshText    : "Osveži",
      displayMsg     : "Prikazana {0} - {1} od {2}",
      emptyMsg       : 'Nemam šta prikazati'
   });
}

if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "Minimalna dužina ovog polja је {0}",
      maxLengthText : "Maksimalna dužina ovog polja је {0}",
      blankText     : "Polje је obavezno",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "Minimalna vrednost u polju је {0}",
      maxText : "Maksimalna vrednost u polju је {0}",
      nanText : "{0} nije pravilan broj"
   });
}

if(L5.form.DateField){
   L5.apply(L5.form.DateField.prototype, {
      disabledDaysText  : "Pasivno",
      disabledDatesText : "Pasivno",
      minText           : "Datum u ovom polju mora biti nakon {0}",
      maxText           : "Datum u ovom polju mora biti pre {0}",
      invalidText       : "{0} nije pravilan datum - zahtevani oblik je {1}",
      format            : "d.m.y",
      altFormats        : "d.m.y|d/m/Y|d-m-y|d-m-Y|d/m|d-m|dm|dmy|dmY|d|Y-m-d"
   });
}

if(L5.form.ComboBox){
   L5.apply(L5.form.ComboBox.prototype, {
      loadingText       : "Učitavam...",
      valueNotFoundText : undefined
   });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'Ovo polje prihavata e-mail adresu isključivo u obliku "korisnik@domen.com"',
      urlText      : 'Ovo polje prihavata URL adresu isključivo u obliku "http:/'+'/www.domen.com"',
      alphaText    : 'Ovo polje može sadržati isključivo slova i znak _',
      alphanumText : 'Ovo polje može sadržati само slova, brojeve i znak _'
   });
}

if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "Rastući redosled",
      sortDescText : "Opadajući redosled",
      lockText     : "Zaključaj kolonu",
      unlockText   : "Otključaj kolonu",
      columnsText  : "Kolone"
   });
}

if(L5.grid.PropertyColumnModel){
   L5.apply(L5.grid.PropertyColumnModel.prototype, {
      nameText   : "Naziv",
      valueText  : "Vrednost",
      dateFormat : "d.m.Y"
   });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "Povući za izmenu veličine.",
      collapsibleSplitTip : "Povući za izmenu veličine. Dvostruku klik za sakrivanje."
   });
}
