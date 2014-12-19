

/**
 * List compiled by mystix on the extjs.com forums.
 * Thank you Mystix!
 */
 
 /*  Slovak Translation by Michal Thomka
  *  14 April 2007
  */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Nahrávam...</div>';

if(L5.View){
   L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} označených riadkov";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "Zavrieť túto záložku";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "Hodnota v tomto poli je nesprávna";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "Nahrávam...";
}

Date.monthNames = [
   "Január",
   "Február",
   "Marec",
   "Apríl",
   "Máj",
   "Jún",
   "Júl",
   "August",
   "September",
   "Október",
   "November",
   "December"
];

Date.dayNames = [
   "Nedeľa",
   "Pondelok",
   "Utorok",
   "Streda",
   "Štvrtok",
   "Piatok",
   "Sobota"
];

if(L5.MessageBox){
   L5.MessageBox.buttonText = {
      ok     : "OK",
      cancel : "Zrušiť",
      yes    : "Áno",
      no     : "Nie"
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
      todayText         : "Dnes",
      minText           : "Tento dátum je menší ako minimálny možný dátum",
      maxText           : "Tento dátum je väčší ako maximálny možný dátum",
      disabledDaysText  : "",
      disabledDatesText : "",
      monthNames        : Date.monthNames,
      dayNames          : Date.dayNames,
      nextText          : 'Ďalší Mesiac (Control+Doprava)',
      prevText          : 'Predch. Mesiac (Control+Doľava)',
      monthYearText     : 'Vyberte Mesiac (Control+Hore/Dole pre posun rokov)',
      todayTip          : "{0} (Medzerník)",
      format            : "d.m.Y"
   });
}


if(L5.PagingToolbar){
   L5.apply(L5.PagingToolbar.prototype, {
      beforePageText : "Strana",
      afterPageText  : "z {0}",
      firstText      : "Prvá Strana",
      prevText       : "Predch. Strana",
      nextText       : "Ďalšia Strana",
      lastText       : "Posledná strana",
      refreshText    : "Obnoviť",
      displayMsg     : "Zobrazujem {0} - {1} z {2}",
      emptyMsg       : 'iadne dáta'
   });
}


if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "Minimálna dĺžka pre toto pole je {0}",
      maxLengthText : "Maximálna dĺžka pre toto pole je {0}",
      blankText     : "Toto pole je povinné",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "Minimálna hodnota pre toto pole je {0}",
      maxText : "Maximálna hodnota pre toto pole je {0}",
      nanText : "{0} je nesprávne číslo"
   });
}

if(L5.form.DateField){
   L5.apply(L5.form.DateField.prototype, {
      disabledDaysText  : "Zablokované",
      disabledDatesText : "Zablokované",
      minText           : "Dátum v tomto poli musí byť až po {0}",
      maxText           : "Dátum v tomto poli musí byť pred {0}",
      invalidText       : "{0} nie je správny dátum - musí byť vo formáte {1}",
      format            : "d.m.Y"
   });
}

if(L5.form.ComboBox){
   L5.apply(L5.form.ComboBox.prototype, {
      loadingText       : "Nahrávam...",
      valueNotFoundText : undefined
   });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'Toto pole musí byť e-mailová adresa vo formáte "user@domain.com"',
      urlText      : 'Toto pole musí byť URL vo formáte "http:/'+'/www.domain.com"',
      alphaText    : 'Toto pole može obsahovať iba písmená a znak _',
      alphanumText : 'Toto pole može obsahovať iba písmená, čísla a znak _'
   });
}

if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "Zoradiť vzostupne",
      sortDescText : "Zoradiť zostupne",
      lockText     : "Zamknúť stľpec",
      unlockText   : "Odomknúť stľpec",
      columnsText  : "Stľpce"
   });
}

if(L5.grid.PropertyColumnModel){
   L5.apply(L5.grid.PropertyColumnModel.prototype, {
      nameText   : "Názov",
      valueText  : "Hodnota",
      dateFormat : "d.m.Y"
   });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "Potiahnite pre zmenu rozmeru",
      collapsibleSplitTip : "Potiahnite pre zmenu rozmeru. Dvojklikom schováte."
   });
}
