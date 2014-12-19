

/**
 * Czech Translations
 * Translated by Tomáš Korčák (72)
 * 2008/02/08 18:02, L5-2.0.1
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Prosím čekejte...</div>';

if(L5.View){
   L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} vybraných řádků";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "Zavřít záložku";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "Hodnota v tomto poli je neplatná";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "Prosím čekejte...";
}

Date.monthNames = [
   "Leden",
   "Únor",
   "Březen",
   "Duben",
   "Květen",
   "Červen",
   "Červenec",
   "Srpen",
   "Září",
   "Říjen",
   "Listopad",
   "Prosinec"
];

Date.getShortMonthName = function(month) {
  return Date.monthNames[month].substring(0, 3);
};

Date.monthNumbers = {
  Jan : 0,
  Feb : 1,
  Mar : 2,
  Apr : 3,
  May : 4,
  Jun : 5,
  Jul : 6,
  Aug : 7,
  Sep : 8,
  Oct : 9,
  Nov : 10,
  Dec : 11
};

Date.getMonthNumber = function(name) {
  return Date.monthNumbers[name.substring(0, 1).toUpperCase() + name.substring(1, 3).toLowerCase()];
};

Date.dayNames = [
   "Neděle",
   "Pondělí",
   "Úterý",
   "Středa",
   "Čtvrtek",
   "Pátek",
   "Sobota"
];

Date.getShortDayName = function(day) {
  return Date.dayNames[day].substring(0, 3);
};

if(L5.MessageBox){
   L5.MessageBox.buttonText = {
      ok     : "OK",
      cancel : "Storno",
      yes    : "Ano",
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
      todayText         : "Dnes",
      minText           : "Datum nesmí být starší než je minimální",
      maxText           : "Datum nesmí být dřívější než je maximální",
      disabledDaysText  : "",
      disabledDatesText : "",
      monthNames	: Date.monthNames,
      dayNames		: Date.dayNames,
      nextText          : 'Následující měsíc (Control+Right)',
      prevText          : 'Předcházející měsíc (Control+Left)',
      monthYearText     : 'Zvolte měsíc (ke změně let použijte Control+Up/Down)',
      todayTip          : "{0} (Spacebar)",
      format            : "d.m.Y",
      okText            : "&#160;OK&#160;",
      cancelText        : "Storno",
      startDay          : 1
   });
}

if(L5.PagingToolbar){
   L5.apply(L5.PagingToolbar.prototype, {
      beforePageText : "Strana",
      afterPageText  : "z {0}",
      firstText      : "První strana",
      prevText       : "Přecházející strana",
      nextText       : "Následující strana",
      lastText       : "Poslední strana",
      refreshText    : "Aktualizovat",
      displayMsg     : "Zobrazeno {0} - {1} z celkových {2}",
      emptyMsg       : 'Žádné záznamy nebyly nalezeny'
   });
}

if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "Pole nesmí mít méně {0} znaků",
      maxLengthText : "Pole nesmí být delší než {0} znaků",
      blankText     : "This field is required",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "Hodnota v tomto poli nesmí být menší než {0}",
      maxText : "Hodnota v tomto poli nesmí být větší než {0}",
      nanText : "{0} není platné číslo"
   });
}

if(L5.form.DateField){
   L5.apply(L5.form.DateField.prototype, {
      disabledDaysText  : "Neaktivní",
      disabledDatesText : "Neaktivní",
      minText           : "Datum v tomto poli nesmí být starší než {0}",
      maxText           : "Datum v tomto poli nesmí být novější než {0}",
      invalidText       : "{0} není platným datem - zkontrolujte zda-li je ve formátu {1}",
      format            : "d.m.Y",
      altFormats        : "d/m/Y|d-m-y|d-m-Y|d/m|d-m|dm|dmy|dmY|d|Y-m-d"
   });
}

if(L5.form.ComboBox){
   L5.apply(L5.form.ComboBox.prototype, {
      loadingText       : "Prosím čekejte...",
      valueNotFoundText : undefined
   });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'V tomto poli může být vyplněna pouze emailová adresa ve formátu "uživatel@doména.cz"',
      urlText      : 'V tomto poli může být vyplněna pouze URL (adresa internetové stránky) ve formátu "http:/'+'/www.doména.cz"',
      alphaText    : 'Toto pole může obsahovat pouze písmena abecedy a znak _',
      alphanumText : 'Toto pole může obsahovat pouze písmena abecedy, čísla a znak _'
   });
}

if(L5.form.HtmlEditor){
  L5.apply(L5.form.HtmlEditor.prototype, {
    createLinkText : 'Zadejte URL adresu odkazu:',
    buttonTips : {
      bold : {
        title: 'Tučné (Ctrl+B)',
        text: 'Označí vybraný text tučně.',
        cls: 'x-html-editor-tip'
      },
      italic : {
        title: 'Kurzíva (Ctrl+I)',
        text: 'Označí vybraný text kurzívou.',
        cls: 'x-html-editor-tip'
      },
      underline : {
        title: 'Podtržení (Ctrl+U)',
        text: 'Podtrhne vybraný text.',
        cls: 'x-html-editor-tip'
      },
      increasefontsize : {
        title: 'Zvětšit písmo',
        text: 'Zvětší velikost písma.',
        cls: 'x-html-editor-tip'
      },
      decreasefontsize : {
        title: 'Zúžit písmo',
        text: 'Zmenší velikost písma.',
        cls: 'x-html-editor-tip'
      },
      backcolor : {
        title: 'Barva zvýraznění textu',
        text: 'Označí vybraný text tak, aby vypadal jako označený zvýrazňovačem.',
        cls: 'x-html-editor-tip'
      },
      forecolor : {
        title: 'Barva písma',
        text: 'Změní barvu textu.',
        cls: 'x-html-editor-tip'
      },
      justifyleft : {
        title: 'Zarovnat text vlevo',
        text: 'Zarovná text doleva.',
        cls: 'x-html-editor-tip'
      },
      justifycenter : {
        title: 'Zarovnat na střed',
        text: 'Zarovná text na střed.',
        cls: 'x-html-editor-tip'
      },
      justifyright : {
        title: 'Zarovnat text vpravo',
        text: 'Zarovná text doprava.',
        cls: 'x-html-editor-tip'
      },
      insertunorderedlist : {
        title: 'Odrážky',
        text: 'Začne seznam s odrážkami.',
        cls: 'x-html-editor-tip'
      },
      insertorderedlist : {
        title: 'Číslování',
        text: 'Začne číslovaný seznam.',
        cls: 'x-html-editor-tip'
      },
      createlink : {
        title: 'Internetový odkaz',
        text: 'Z vybraného textu vytvoří internetový odkaz.',
        cls: 'x-html-editor-tip'
      },
      sourceedit : {
        title: 'Zdrojový kód',
        text: 'Přepne do módu úpravy zdrojového kódu.',
        cls: 'x-html-editor-tip'
      }
    }
  });
}

if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "Řadit vzestupně",
      sortDescText : "Řadit sestupně",
      lockText     : "Ukotvit sloupec",
      unlockText   : "Uvolnit sloupec",
      columnsText  : "Sloupce"
   });
}

if(L5.grid.GroupingView){
  L5.apply(L5.grid.GroupingView.prototype, {
    emptyGroupText : '(Žádná data)',
    groupByText    : 'Seskupit dle tohoto pole',
    showGroupsText : 'Zobrazit ve skupině'
  });
}

if(L5.grid.PropertyColumnModel){
   L5.apply(L5.grid.PropertyColumnModel.prototype, {
      nameText   : "Název",
      valueText  : "Hodnota",
      dateFormat : "j.m.Y"
   });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "Tahem změnit velikost.",
      collapsibleSplitTip : "Tahem změnit velikost. Dvojklikem skrýt."
   });
}
