

/*
 * Serbian Cyrillic Translation
 * by Čolovic Vladan (cyrillic, utf8 encoding)
 * sr_RS (ex: sr_CS, sr_YU)
 * 12 May 2007
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Учитавам...</div>';

if(L5.View){
   L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} изабраних редова";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "Затвори ову »картицу«";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "Унешена вредност није правилна";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "Учитавам...";
}

Date.monthNames = [
   "Јануар",
   "Фебруар",
   "Март",
   "Април",
   "Мај",
   "Јун",
   "Јул",
   "Август",
   "Септембар",
   "Октобар",
   "Новембар",
   "Децембар"
];

Date.dayNames = [
   "Недеља",
   "Понедељак",
   "Уторак",
   "Среда",
   "Четвртак",
   "Петак",
   "Субота"
];

if(L5.MessageBox){
   L5.MessageBox.buttonText = {
      ok     : "У реду",
      cancel : "Одустани",
      yes    : "Да",
      no     : "Не"
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
      todayText         : "Данас",
      minText           : "Датум је испред најмањег дозвољеног датума",
      maxText           : "Датум је након највећег дозвољеног датума",
      disabledDaysText  : "",
      disabledDatesText : "",
      monthNames	: Date.monthNames,
      dayNames		: Date.dayNames,
      nextText          : 'Следећи месец (Control+Десно)',
      prevText          : 'Претходни месец (Control+Лево)',
      monthYearText     : 'Изаберите месец (Control+Горе/Доле за избор године)',
      todayTip          : "{0} (Размакница)",
      format            : "d.m.y",
      startDay 		 : 1
   });
}

if(L5.PagingToolbar){
   L5.apply(L5.PagingToolbar.prototype, {
      beforePageText : "Страна",
      afterPageText  : "од {0}",
      firstText      : "Прва страна",
      prevText       : "Претходна страна",
      nextText       : "Следећа страна",
      lastText       : "Последња страна",
      refreshText    : "Освежи",
      displayMsg     : "Приказана {0} - {1} од {2}",
      emptyMsg       : 'Немам шта приказати'
   });
}

if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "Минимална дужина овог поља је {0}",
      maxLengthText : "Максимална дужина овог поља је {0}",
      blankText     : "Поље је обавезно",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "Минимална вредност у пољу је {0}",
      maxText : "Максимална вредност у пољу је {0}",
      nanText : "{0} није правилан број"
   });
}

if(L5.form.DateField){
   L5.apply(L5.form.DateField.prototype, {
      disabledDaysText  : "Пасивно",
      disabledDatesText : "Пасивно",
      minText           : "Датум у овом пољу мора бити након {0}",
      maxText           : "Датум у овом пољу мора бити пре {0}",
      invalidText       : "{0} није правилан датум - захтевани облик је {1}",
      format            : "d.m.y"
   });
}

if(L5.form.ComboBox){
   L5.apply(L5.form.ComboBox.prototype, {
      loadingText       : "Учитавам...",
      valueNotFoundText : undefined
   });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'Ово поље прихвата e-mail адресу искључиво у облику "korisnik@domen.com"',
      urlText      : 'Ово поље прихвата URL адресу искључиво у облику "http:/'+'/www.domen.com"',
      alphaText    : 'Ово поље може садржати искључиво слова и знак _',
      alphanumText : 'Ово поље може садржати само слова, бројеве и знак _'
   });
}

if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "Растући редослед",
      sortDescText : "Опадајући редослед",
      lockText     : "Закључај колону",
      unlockText   : "Откључај колону",
      columnsText  : "Колоне"
   });
}

if(L5.grid.PropertyColumnModel){
   L5.apply(L5.grid.PropertyColumnModel.prototype, {
      nameText   : "Назив",
      valueText  : "Вредност",
      dateFormat : "d.m.Y"
   });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "Повући за измену величине.",
      collapsibleSplitTip : "Повући за измену величине. Двоструки клик за сакривање."
   });
}
