L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Încărcare...</div>';

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} rând(uri) selectate";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "Închide acest tab";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "Valoarea acestui câmp este invalidă";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "Încărcare...";
}

Date.monthNames = [
   "Ianuarie",
   "Februarie",
   "Martie",
   "Aprilie",
   "Mai",
   "Iunie",
   "Iulie",
   "August",
   "Septembrie",
   "Octombrie",
   "Noiembrie",
   "Decembrie"
];

Date.getShortMonthName = function(month) {
  return Date.monthNames[month].substring(0, 3);
};

Date.monthNumbers = {
  Ian : 0,
  Feb : 1,
  Mar : 2,
  Apr : 3,
  Mai : 4,
  Iun : 5,
  Iul : 6,
  Aug : 7,
  Sep : 8,
  Oct : 9,
  Noi : 10,
  Dec : 11
};

Date.getMonthNumber = function(name) {
  return Date.monthNumbers[name.substring(0, 1).toUpperCase() + name.substring(1, 3).toLowerCase()];
};

Date.dayNames = [
   "Duminică",
   "Luni",
   "Marţi",
   "Miercuri",
   "Joi",
   "Vineri",
   "Sâmbătă"
];

Date.getShortDayName = function(day) {
  return Date.dayNames[day].substring(0, 3);
};

if(L5.MessageBox){
   L5.MessageBox.buttonText = {
      ok     : "OK",
      cancel : "Renunţă",
      yes    : "Da",
      no     : "Nu"
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
    todayText         : "Astăzi",
    minText           : "Această dată este anterioară datei minime",
    maxText           : "Această dată este ulterioară datei maxime",
    disabledDaysText  : "",
    disabledDatesText : "",
    monthNames        : Date.monthNames,
    dayNames          : Date.dayNames,
    nextText          : 'Luna următoare (Control+Dreapta)',
    prevText          : 'Luna precedentă (Control+Stânga)',
    monthYearText     : 'Alege o lună (Control+Sus/Jos pentru a parcurge anii)',
    todayTip          : "{0} (Bara spațiu)",
    format            : "d.m.Y",
    okText            : "&#160;OK&#160;",
    cancelText        : "Renunță",
    startDay          : 0
  });
}

if(L5.PagingToolbar){
  L5.apply(L5.PagingToolbar.prototype, {
    beforePageText : "Pagina",
    afterPageText  : "din {0}",
    firstText      : "Prima pagină",
    prevText       : "Pagina anterioară",
    nextText       : "Pagina următoare",
    lastText       : "Ultima pagină",
    refreshText    : "Împrospătează",
    displayMsg     : "Afișare înregistrările {0} - {1} din {2}",
    emptyMsg       : 'Nu sunt date de afișat'
  });
}

if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "Lungimea minimă pentru acest câmp este de {0}",
      maxLengthText : "Lungimea maximă pentru acest câmp este {0}",
      blankText     : "Acest câmp este obligatoriu",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "Valoarea minimă permisă a acestui câmp este {0}",
      maxText : "Valaorea maximă permisă a acestui câmp este {0}",
      nanText : "{0} nu este un număr valid"
   });
}

if(L5.form.DateField){
  L5.apply(L5.form.DateField.prototype, {
    disabledDaysText  : "Indisponibil",
    disabledDatesText : "Indisponibil",
    minText           : "Data din această casetă trebuie să fie după {0}",
    maxText           : "Data din această casetă trebuie să fie inainte de {0}",
    invalidText       : "{0} nu este o dată validă, trebuie să fie în formatul {1}",
    format            : "d.m.Y",
    altFormats        : "d-m-Y|d.m.y|d-m-y|d.m|d-m|dm|d|Y-m-d"
  });
}

if(L5.form.ComboBox){
  L5.apply(L5.form.ComboBox.prototype, {
    loadingText       : "Încărcare...",
    valueNotFoundText : undefined
  });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'Acest câmp trebuie să conţină o adresă de e-mail în formatul "user@domeniu.com"',
      urlText      : 'Acest câmp trebuie să conţină o adresă URL în formatul "http:/'+'/www.domeniu.com"',
      alphaText    : 'Acest câmp trebuie să conţină doar litere şi _',
      alphanumText : 'Acest câmp trebuie să conţină doar litere, cifre şi _'
   });
}

if(L5.form.HtmlEditor){
  L5.apply(L5.form.HtmlEditor.prototype, {
    createLinkText : 'Vă rugăm introduceti un URL pentru această legătură web:',
    buttonTips : {
      bold : {
        title: 'Îngroşat (Ctrl+B)',
        text: 'Îngroşati caracterele textului selectat.',
        cls: 'x-html-editor-tip'
      },
      italic : {
        title: 'Înclinat (Ctrl+I)',
        text: 'Înclinaţi caracterele textului selectat.',
        cls: 'x-html-editor-tip'
      },
      underline : {
        title: 'Subliniat (Ctrl+U)',
        text: 'Subliniaţi caracterele textului selectat.',
        cls: 'x-html-editor-tip'
      },
      increasefontsize : {
        title: 'Mărit',
        text: 'Măreşte dimensiunea fontului.',
        cls: 'x-html-editor-tip'
      },
      decreasefontsize : {
        title: 'Micşorat',
        text: 'Micşorează dimensiunea textului.',
        cls: 'x-html-editor-tip'
      },
      backcolor : {
        title: 'Culoarea fundalului',
        text: 'Schimbă culoarea fundalului pentru textul selectat.',
        cls: 'x-html-editor-tip'
      },
      forecolor : {
        title: 'Culoarea textului',
        text: 'Schimbă culoarea textului selectat.',
        cls: 'x-html-editor-tip'
      },
      justifyleft : {
        title: 'Aliniat la stânga',
        text: 'Aliniază textul la stânga.',
        cls: 'x-html-editor-tip'
      },
      justifycenter : {
        title: 'Centrat',
        text: 'Centrează textul în editor.',
        cls: 'x-html-editor-tip'
      },
      justifyright : {
        title: 'Aliniat la dreapta',
        text: 'Aliniază textul la dreapta.',
        cls: 'x-html-editor-tip'
      },
      insertunorderedlist : {
        title: 'Listă cu puncte',
        text: 'Inserează listă cu puncte.',
        cls: 'x-html-editor-tip'
      },
      insertorderedlist : {
        title: 'Listă numerotată',
        text: 'Inserează o listă numerotată.',
        cls: 'x-html-editor-tip'
      },
      createlink : {
        title: 'Legătură web',
        text: 'Transformă textul selectat în legătură web.',
        cls: 'x-html-editor-tip'
      },
      sourceedit : {
        title: 'Editare sursă',
        text: 'Schimbă pe modul de editare al codului HTML.',
        cls: 'x-html-editor-tip'
      }
    }
  });
}


if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "Sortare ascendentă",
      sortDescText : "Sortare descendentă",
      lockText     : "Blochează coloana",
      unlockText   : "Deblochează coloana",
      columnsText  : "Coloane"
   });
}

if(L5.grid.GroupingView){
  L5.apply(L5.grid.GroupingView.prototype, {
    emptyGroupText : '(Fără)',
    groupByText    : 'Grupează după această coloană',
    showGroupsText : 'Afișează grupat'
  });
}

if(L5.grid.PropertyColumnModel){
  L5.apply(L5.grid.PropertyColumnModel.prototype, {
    nameText   : "Nume",
    valueText  : "Valoare",
    dateFormat : "d.m.Y"
  });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "Trage pentru redimensionare.",
      collapsibleSplitTip : "Trage pentru redimensionare. Dublu-click pentru ascundere."
   });
}