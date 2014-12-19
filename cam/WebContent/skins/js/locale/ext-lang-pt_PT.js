/**
 * L5 2.2.0 - Portuguese/Portugal (pt_PT) Translation
 * by Nuno Franco da Costa - francodacosta.com
 * translated from ext-lang-en.js
 * 11 Nov 2008
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">A carregar...</div>';

if(L5.View){
  L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
  L5.grid.GridPanel.prototype.ddText = "{0} linha(s) seleccionada(s)";
}

if(L5.TabPanelItem){
  L5.TabPanelItem.prototype.closeText = "Fechar aba";
}

if(L5.LoadMask){
  L5.LoadMask.prototype.msg = "A carregar...";
}

Date.monthNames = [
  "Janeiro",
  "Fevereiro",
  "Mar&ccedil;o",
  "Abril",
  "Maio",
  "Junho",
  "Julho",
  "Agosto",
  "Setembro",
  "Outubro",
  "Novembro",
  "Dezembro"
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
  "Domingo",
  "Segunda",
  "Ter&ccedil;a",
  "Quarta",
  "Quinta",
  "Sexta",
  "Sabado"
];

Date.getShortDayName = function(day) {
  return Date.dayNames[day].substring(0, 3);
};

if(L5.MessageBox){
  L5.MessageBox.buttonText = {
    ok     : "OK",
    cancel : "Cancelar",
    yes    : "Sim",
    no     : "N&atilde;o"
  };
}

if(L5.util.Format){
  L5.util.Format.date = function(v, format){
    if(!v) return "";
    if(!(v instanceof Date)) v = new Date(Date.parse(v));
    return v.dateFormat(format || "Y/m/d");
  };
}

if(L5.DatePicker){
  L5.apply(L5.DatePicker.prototype, {
    todayText         : "Hoje",
    minText           : "A data &eacute; anterior ao m&iacute;nimo definido",
    maxText           : "A data &eacute; posterior ao mximo definido",
    disabledDaysText  : "",
    disabledDatesText : "",
    monthNames        : Date.monthNames,
    dayNames          : Date.dayNames,
    nextText          : 'M&ecirc;s Seguinte (Control+Right)',
    prevText          : 'M&ecirc;s Anterior (Control+Left)',
    monthYearText     : 'Escolha um m&ecirc;s (Control+Up/Down ava&ccedil;ar/recuar anos)',
    todayTip          : "{0} (barra de espao)",
    format            : "y/m/d",
    okText            : "*OK*",
    cancelText        : "Cancelar",
    startDay          : 0
  });
}

if(L5.PagingToolbar){
  L5.apply(L5.PagingToolbar.prototype, {
    beforePageText : "P&aacute;gina",
    afterPageText  : "de {0}",
    firstText      : "Primeira P&aacute;gina",
    prevText       : "P&aacute;gina Anterior",
    nextText       : "Pr%oacute;xima P&aacute;gina",
    lastText       : "&Uacute;ltima P&aacute;gina",
    refreshText    : "Recaregar",
    displayMsg     : "A mostrar {0} - {1} de {2}",
    emptyMsg       : 'Sem dados para mostrar'
  });
}

if(L5.form.Field){
  L5.form.Field.prototype.invalidText = "O valor deste campo &eacute; inv&aacute;lido";
}

if(L5.form.TextField){
  L5.apply(L5.form.TextField.prototype, {
    minLengthText : "O comprimento m&iacute;nimo deste campo &eaute; {0}",
    maxLengthText : "O comprimento m&aacute;ximo deste campo &eaute; {0}",
    blankText     : "Este campo &eacute; de preenchimento obrigat&oacute;rio",
    regexText     : "",
    emptyText     : null
  });
}

if(L5.form.NumberField){
  L5.apply(L5.form.NumberField.prototype, {
    minText : "O valor m&iacute;nimo deste campo &eaute; {0}",
    maxText : "O valor m&aacute;ximo deste campo &eaute; {0}",
    nanText : "{0} n&atilde;o &eacute; um numero"
  });
}

if(L5.form.DateField){
  L5.apply(L5.form.DateField.prototype, {
    disabledDaysText  : "Desabilitado",
    disabledDatesText : "Desabilitado",
    minText           : "A data deste campo deve ser posterior a {0}",
    maxText           : "A data deste campo deve ser anterior a {0}",
    invalidText       : "{0} n&atilde;o &eacute; uma data v&aacute;lida - deve estar no seguinte formato{1}",
    format            : "y/m/d",
    altFormats        : "m/d/Y|m-d-y|m-d-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d"
  });
}

if(L5.form.ComboBox){
  L5.apply(L5.form.ComboBox.prototype, {
    loadingText       : "A Carregar...",
    valueNotFoundText : undefined
  });
}

if(L5.form.VTypes){
  L5.apply(L5.form.VTypes, {
    emailText    : 'Este campo deve ser um endere&ccedil;o de email no formato "utilizaor@dominio.com"',
    urlText      : 'Este campo deve ser um URL no formato "http:/'+'/www.dominio.com"',
    alphaText    : 'Este campo deve conter apenas letras e _',
    alphanumText : 'Este campo deve conter apenas letras, numeros e _'
  });
}

if(L5.form.HtmlEditor){
  L5.apply(L5.form.HtmlEditor.prototype, {
    createLinkText : 'Indique o endere&ccedil;o do link:',
    buttonTips : {
      bold : {
        title: 'Negrito (Ctrl+B)',
        text: 'Transforma o texto em Negrito.',
        cls: 'x-html-editor-tip'
      },
      italic : {
        title: 'Italico (Ctrl+I)',
        text: 'Transforma o texto em italico.',
        cls: 'x-html-editor-tip'
      },
      underline : {
        title: 'SUblinhar (Ctrl+U)',
        text: 'Sublinha o texto.',
        cls: 'x-html-editor-tip'
      },
      increasefontsize : {
        title: 'Aumentar texto',
        text: 'Aumenta o tamanho da fonte.',
        cls: 'x-html-editor-tip'
      },
      decreasefontsize : {
        title: 'Encolher texto',
        text: 'Diminui o tamanho da fonte.',
        cls: 'x-html-editor-tip'
      },
      backcolor : {
        title: 'C&ocirc;r de fundo do texto',
        text: 'Altera a c&ocirc;r de fundo do texto.',
        cls: 'x-html-editor-tip'
      },
      forecolor : {
        title: 'C&ocirc;r do texo',
        text: 'Altera a a&ocirc;r do texo.',
        cls: 'x-html-editor-tip'
      },
      justifyleft : {
        title: 'ALinhar &agrave; esquerda',
        text: 'ALinha o texto &agrave; esquerda.',
        cls: 'x-html-editor-tip'
      },
      justifycenter : {
        title: 'Centrar',
        text: 'Centra o texto.',
        cls: 'x-html-editor-tip'
      },
      justifyright : {
        title: 'ALinhar &agrave; direita',
        text: 'ALinha o texto &agravce; direita.',
        cls: 'x-html-editor-tip'
      },
      insertunorderedlist : {
        title: 'Lista',
        text: 'Inicia uma lista.',
        cls: 'x-html-editor-tip'
      },
      insertorderedlist : {
        title: 'Lista Numerada',
        text: 'Inicia uma lista numerada.',
        cls: 'x-html-editor-tip'
      },
      createlink : {
        title: 'Hyperlink',
        text: 'Transforma o texto num hyperlink.',
        cls: 'x-html-editor-tip'
      },
      sourceedit : {
        title: 'Editar c&oacute;digo',
        text: 'Alterar para o modo de edi&ccedil;&atilde;o de c&oacute;digo.',
        cls: 'x-html-editor-tip'
      }
    }
  });
}

if(L5.form.BasicForm){
  L5.form.BasicForm.prototype.waitTitle = "Por favor espere...";
}

if(L5.grid.GridView){
  L5.apply(L5.grid.GridView.prototype, {
    sortAscText  : "Ordena&ccedil;&atilde;o Crescente",
    sortDescText : "Ordena&ccedil;&atilde;o Decrescente",
    lockText     : "Fixar Coluna",
    unlockText   : "Libertar Coluna",
    columnsText  : "Colunas"
  });
}

if(L5.grid.GroupingView){
  L5.apply(L5.grid.GroupingView.prototype, {
    emptyGroupText : '(Nenhum)',
    groupByText    : 'Agrupar por este campo',
    showGroupsText : 'Mostrar nos Grupos'
  });
}

if(L5.grid.PropertyColumnModel){
  L5.apply(L5.grid.PropertyColumnModel.prototype, {
    nameText   : "Nome",
    valueText  : "Valor",
    dateFormat : "Y/j/m"
  });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
  L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
    splitTip            : "Arastar para redimensionar.",
    collapsibleSplitTip : "Arastar para redimensionar. DUplo clique para esconder"
  });
}
