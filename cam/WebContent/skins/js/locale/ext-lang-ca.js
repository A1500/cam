

/**
 * Catalonian Translation by halkon_polako 6-12-2007
 * December correction halkon_polako 11-12-2007
 *
 * Synchronized with 2.2 version of ext-lang-en.js (provided by Condor 8 aug 2008) 
 *     by halkon_polako 14-aug-2009
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Carregant...</div>';

if(L5.DataView){
  L5.DataView.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
  L5.grid.GridPanel.prototype.ddText = "{0} fila(es) seleccionada(es)";
}

if(L5.LoadMask){
  L5.LoadMask.prototype.msg = "Carregant...";
}

Date.monthNames = [
  "Gener",
  "Febrer",
  "Mar&#231;",
  "Abril",
  "Maig",
  "Juny",
  "Juliol",
  "Agost",
  "Setembre",
  "Octubre",
  "Novembre",
  "Desembre"
];

Date.getShortMonthName = function(month) {
  return Date.monthNames[month].substring(0, 3);
};

Date.monthNumbers = {
  Gen : 0,
  Feb : 1,
  Mar : 2,
  Abr : 3,
  Mai : 4,
  Jun : 5,
  Jul : 6,
  Ago : 7,
  Set : 8,
  Oct : 9,
  Nov : 10,
  Dec : 11
};

Date.getMonthNumber = function(name) {
  return Date.monthNumbers[name.substring(0, 1).toUpperCase() + name.substring(1, 3).toLowerCase()];
};

Date.dayNames = [
  "Diumenge",
  "Dilluns",
  "Dimarts",
  "Dimecres",
  "Dijous",
  "Divendres",
  "Dissabte"
];

Date.getShortDayName = function(day) {
  return Date.dayNames[day].substring(0, 3);
};

Date.parseCodes.S.s = "(?:st|nd|rd|th)";

if(L5.MessageBox){
  L5.MessageBox.buttonText = {
    ok     : "Acceptar",
    cancel : "Cancel&#183;lar",
    yes    : "S&#237;",
    no     : "No"
  };
}

if(L5.util.Format){
  L5.util.Format.date = function(v, format){
    if(!v) return "";
    if(!(v instanceof Date)) v = new Date(Date.parse(v));
    return v.dateFormat(format || "d/m/Y");
  };
}

if(L5.DatePicker){
  L5.apply(L5.DatePicker.prototype, {
    todayText         : "Avui",
    minText           : "Aquesta data &#233;s anterior a la data m&#237;nima",
    maxText           : "Aquesta data &#233;s posterior a la data m&#224;xima",
    disabledDaysText  : "",
    disabledDatesText : "",
    monthNames        : Date.monthNames,
    dayNames          : Date.dayNames,
    nextText          : 'Mes Seg&#252;ent (Control+Fletxa Dreta)',
    prevText          : 'Mes Anterior (Control+Fletxa Esquerra)',
    monthYearText     : 'Seleccioni un mes (Control+Fletxa a Dalt o Abaix per canviar els anys)',
    todayTip          : "{0} (Barra d&#39;espai)",
    format            : "d/m/Y",
    okText            : "&#160;Acceptar&#160;",
    cancelText        : "Cancel&#183;lar",
    startDay          : 1
  });
}

if(L5.PagingToolbar){
  L5.apply(L5.PagingToolbar.prototype, {
    beforePageText : "P&#224;gina",
    afterPageText  : "de {0}",
    firstText      : "Primera P&#224;gina",
    prevText       : "P&#224;gina Anterior",
    nextText       : "P&#224;gina Seg&#252;ent",
    lastText       : "Darrera P&#224;gina",
    refreshText    : "Refrescar",
    displayMsg     : "Mostrant {0} - {1} de {2}",
    emptyMsg       : 'Sense dades per mostrar'
  });
}

if(L5.form.Field){
  L5.form.Field.prototype.invalidText = "El valor d&#39;aquest camp &#233;s inv&#224;lid";
}

if(L5.form.TextField){
  L5.apply(L5.form.TextField.prototype, {
    minLengthText : "El tamany m&#237;nim per aquest camp &#233;s {0}",
    maxLengthText : "El tamany m&#224;xim per aquest camp &#233;s {0}",
    blankText     : "Aquest camp &#233;s obligatori",
    regexText     : "",
    emptyText     : null
  });
}

if(L5.form.NumberField){
  L5.apply(L5.form.NumberField.prototype, {
    decimalSeparator : ",",
    decimalPrecision : 2,
    minText : "El valor m&#237;nim per aquest camp &#233;s {0}",
    maxText : "El valor m&#224;xim per aquest camp &#233;s {0}",
    nanText : "{0} no &#233;s un nombre v&#224;lid"
  });
}

if(L5.form.DateField){
  L5.apply(L5.form.DateField.prototype, {
    disabledDaysText  : "Deshabilitat",
    disabledDatesText : "Deshabilitat",
    minText           : "La data en aquest camp ha de ser posterior a {0}",
    maxText           : "La data en aquest camp ha de ser inferior a {0}",
    invalidText       : "{0} no &#233;s una data v&#224;lida - ha de tenir el format {1}",
    format            : "d/m/Y",
    altFormats        : "d/m/Y|d-m-y|d-m-Y|d/m|d-m|dm|dmy|dmY|d|Y-m-d"
  });
}

if(L5.form.ComboBox){
  L5.apply(L5.form.ComboBox.prototype, {
    loadingText       : "Carregant...",
    valueNotFoundText : undefined
  });
}

if(L5.form.VTypes){
  L5.apply(L5.form.VTypes, {
    emailText    : 'Aquest camp ha de ser una adre&#231;a de e-mail amb el format "user@domain.com"',
    urlText      : 'Aquest camp ha de ser una URL amb el format "http:/'+'/www.domain.com"',
    alphaText    : 'Aquest camp nom&#233;s pot contenir lletres i _',
    alphanumText : 'Aquest camp nom&#233;s por contenir lletres, nombres i _'
  });
}

if(L5.form.HtmlEditor){
  L5.apply(L5.form.HtmlEditor.prototype, {
    createLinkText : 'Si us plau, tecleixi la URL per l\'enlla&#231;:',
    buttonTips : {
      bold : {
        title: 'Negreta (Ctrl+B)',
        text: 'Posa el text seleccionat en negreta.',
        cls: 'x-html-editor-tip'
      },
      italic : {
        title: 'It&#224;lica (Ctrl+I)',
        text: 'Posa el text seleccionat en it&#224;lica.',
        cls: 'x-html-editor-tip'
      },
      underline : {
        title: 'Subratllat (Ctrl+U)',
        text: 'Subratlla el text seleccionat.',
        cls: 'x-html-editor-tip'
      },
      increasefontsize : {
        title: 'Augmentar Text',
        text: 'Augmenta el tamany de la font de text.',
        cls: 'x-html-editor-tip'
      },
      decreasefontsize : {
        title: 'Disminuir Text',
        text: 'Disminueix el tamany de la font de text.',
        cls: 'x-html-editor-tip'
      },
      backcolor : {
        title: 'Color de fons',
        text: 'Canvia el color de fons del text seleccionat.',
        cls: 'x-html-editor-tip'
      },
      forecolor : {
        title: 'Color de la font de text',
        text: 'Canvia el color del text seleccionat.',
        cls: 'x-html-editor-tip'
      },
      justifyleft : {
        title: 'Alinear a la esquerra',
        text: 'Alinea el text a la esquerra.',
        cls: 'x-html-editor-tip'
      },
      justifycenter : {
        title: 'Centrar el text',
        text: 'Centra el text a l\'editor',
        cls: 'x-html-editor-tip'
      },
      justifyright : {
        title: 'Alinear a la dreta',
        text: 'Alinea el text a la dreta.',
        cls: 'x-html-editor-tip'
      },
      insertunorderedlist : {
        title: 'Llista amb vinyetes',
        text: 'Comen&#231;a una llista amb vinyetes.',
        cls: 'x-html-editor-tip'
      },
      insertorderedlist : {
        title: 'Llista numerada',
        text: 'Comen&#231;a una llista numerada.',
        cls: 'x-html-editor-tip'
      },
      createlink : {
        title: 'Enlla&#231;',
        text: 'Transforma el text seleccionat en un enlla&#231;.',
        cls: 'x-html-editor-tip'
      },
      sourceedit : {
        title: 'Editar Codi',
        text: 'Canvia al mode d\'edici&#243; de codi.',
        cls: 'x-html-editor-tip'
      }
    }
  });
}

if(L5.grid.GridView){
  L5.apply(L5.grid.GridView.prototype, {
    sortAscText  : "Ordenaci&#243; Ascendent",
    sortDescText : "Ordenaci&#243; Descendent",
    columnsText  : "Columnes"
  });
}

if(L5.grid.GroupingView){
  L5.apply(L5.grid.GroupingView.prototype, {
    emptyGroupText : '(Buit)',
    groupByText    : 'Agrupar Per Aquest Camp',
    showGroupsText : 'Mostrar en Grups'
  });
}

if(L5.grid.PropertyColumnModel){
  L5.apply(L5.grid.PropertyColumnModel.prototype, {
    nameText   : "Nom",
    valueText  : "Valor",
    dateFormat : "d/m/Y"
  });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
  L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
    splitTip            : "Cliqueu i arrossegueu per canviar el tamany del panell.",
    collapsibleSplitTip : "Cliqueu i arrossegueu per canviar el tamany del panell. Doble clic per ocultar-ho."
  });
}

if(L5.form.TimeField){
  L5.apply(L5.form.TimeField.prototype, {
    minText : "L\'hora en aquest camp ha de ser igual o posterior a {0}",
    maxText : "L\'hora en aquest camp ha de ser igual o anterior {0}",
    invalidText : "{0} no &#233;s un hora v&#224;lida",
    format : "g:i A",
    altFormats : "g:ia|g:iA|g:i a|g:i A|h:i|g:i|H:i|ga|ha|gA|h a|g a|g A|gi|hi|gia|hia|g|H"
  });
}

if(L5.form.CheckboxGroup){
  L5.apply(L5.form.CheckboxGroup.prototype, {
    blankText : "Ha de seleccionar almenys un &#233;tem d\'aquest group"
  });
}

if(L5.form.RadioGroup){
  L5.apply(L5.form.RadioGroup.prototype, {
    blankText : "Ha de seleccionar un &#233;tem d\'aquest grup"
  });
}