

/*
 * Macedonia translation
 * By PetarD petar.dimitrijevic@vorteksed.com.mk (utf8 encoding)
 * 23 April 2007
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Вчитувам...</div>';

if(L5.View){
   L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} избрани редици";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "Затвори tab";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "Вредноста во ова поле е невалидна";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "Вчитувам...";
}

Date.monthNames = [
   "Јануари",
   "Февруари",
   "Март",
   "Април",
   "Мај",
   "Јуни",
   "Јули",
   "Август",
   "Септември",
   "Октомври",
   "Ноември",
   "Декември"
];

Date.dayNames = [
   "Недела",
   "Понеделник",
   "Вторник",
   "Среда",
   "Четврток",
   "Петок",
   "Сабота"
];

if(L5.MessageBox){
   L5.MessageBox.buttonText = {
      ok     : "Потврди",
      cancel : "Поништи",
      yes    : "Да",
      no     : "Не"
   };
}

if(L5.util.Format){
   L5.util.Format.date = function(v, format){
      if(!v) return "";
      if(!(v instanceof Date)) v = new Date(Date.parse(v));
      return v.dateFormat(format || "d.m.y");
   };
}

if(L5.DatePicker){
   L5.apply(L5.DatePicker.prototype, {
      todayText         : "Денеска",
      minText           : "Овој датум е пред најмалиот датум",
      maxText           : "Овој датум е пред најголемиот датум",
      disabledDaysText  : "",
      disabledDatesText : "",
      monthNames	: Date.monthNames,
      dayNames		: Date.dayNames,
      nextText          : 'Следен месец (Control+Стрелка десно)',
      prevText          : 'Претходен месец (Control+Стрелка лево)',
      monthYearText     : 'Изберете месец (Control+Стрелка горе/Стрелка десно за менување година)',
      todayTip          : "{0} (Spacebar)",
      format            : "d.m.y"
   });
}

if(L5.PagingToolbar){
   L5.apply(L5.PagingToolbar.prototype, {
      beforePageText : "Страница",
      afterPageText  : "од {0}",
      firstText      : "Прва Страница",
      prevText       : "Претходна Страница",
      nextText       : "Следна Страница",
      lastText       : "Последна Страница",
      refreshText    : "Освежи",
      displayMsg     : "Прикажувам {0} - {1} од {2}",
      emptyMsg       : 'Нема податоци за приказ'
   });
}

if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "Минималната должина за ова поле е {0}",
      maxLengthText : "Максималната должина за ова поле е {0}",
      blankText     : "Податоците во ова поле се потребни",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "Минималната вредност за ова поле е {0}",
      maxText : "Максималната вредност за ова поле е {0}",
      nanText : "{0} не е валиден број"
   });
}

if(L5.form.DateField){
   L5.apply(L5.form.DateField.prototype, {
      disabledDaysText  : "Неактивно",
      disabledDatesText : "Неактивно",
      minText           : "Датумот во ова поле мора да биде пред {0}",
      maxText           : "Датумот во ова поле мора да биде по {0}",
      invalidText       : "{0} не е валиден датум - мора да биде во формат {1}",
      format            : "d.m.y"
   });
}

if(L5.form.ComboBox){
   L5.apply(L5.form.ComboBox.prototype, {
      loadingText       : "Вчитувам...",
      valueNotFoundText : undefined
   });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'Ова поле треба да биде e-mail адреса во формат "user@domain.com"',
      urlText      : 'Ова поле треба да биде URL во формат "http:/'+'/www.domain.com"',
      alphaText    : 'Ова поле треба да содржи само букви и _',
      alphanumText : 'Ова поле треба да содржи само букви, бројки и _'
   });
}

if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "Сортирај Растечки",
      sortDescText : "Сортирај Опаѓачки",
      lockText     : "Заклучи Колона",
      unlockText   : "Отклучи колона",
      columnsText  : "Колони"
   });
}

if(L5.grid.PropertyColumnModel){
   L5.apply(L5.grid.PropertyColumnModel.prototype, {
      nameText   : "Име",
      valueText  : "Вредност",
      dateFormat : "m.d.Y"
   });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "Повлечете за менување на големината.",
      collapsibleSplitTip : "Повлечете за менување на големината. Дупли клик за криење."
   });
}