

/*
 * Portuguese/Brazil Translation by Weber Souza
 * 08 April 2007
 * Updated by Allan Brazute Alves (EthraZa)
 * 06 September 2007
 * Adapted to European Portuguese by Helder Batista (hbatista)
 * 31 January 2008
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Carregando...</div>';

if(L5.View){
   L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} linha(s) seleccionada(s)";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "Fechar";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "O valor para este campo &eacute; inv&aacute;lido";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "Carregando...";
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

Date.dayNames = [
   "Domingo",
   "Segunda",
   "Ter&ccedil;a",
   "Quarta",
   "Quinta",
   "Sexta",
   "S&aacute;bado"
];

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
      return v.dateFormat(format || "d/m/Y");
   };
}

if(L5.DatePicker){
   L5.apply(L5.DatePicker.prototype, {
      todayText         : "Hoje",
      minText           : "Esta data &eacute; anterior &agrave; menor data",
      maxText           : "Esta data &eacute; posterior &agrave; maior data",
      disabledDaysText  : "",
      disabledDatesText : "",
      monthNames        : Date.monthNames,
      dayNames          : Date.dayNames,
      nextText          : 'Pr&oacute;ximo M&ecirc;s (Control+Direita)',
      prevText          : 'M&ecirc;s Anterior (Control+Esquerda)',
      monthYearText     : 'Escolha um M&ecirc;s (Control+Cima/Baixo para mover entre os anos)',
      todayTip          : "{0} (Espa&ccedil;o)",
      format            : "d/m/Y",
      okText            : "&#160;OK&#160;",
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
      nextText       : "Pr&oacute;xima P&aacute;gina",
      lastText       : "&Uacute;ltima P&aacute;gina",
      refreshText    : "Atualizar",
      displayMsg     : "<b>{0} &agrave; {1} de {2} registo(s)</b>",
      emptyMsg       : 'Sem registos para exibir'
   });
}

if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "O tamanho m&iacute;nimo para este campo &eacute; {0}",
      maxLengthText : "O tamanho m&aacute;ximo para este campo &eacute; {0}",
      blankText     : "Este campo &eacute; obrigat&oacute;rio.",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "O valor m&iacute;nimo para este campo &eacute; {0}",
      maxText : "O valor m&aacute;ximo para este campo &eacute; {0}",
      nanText : "{0} n&atilde;o &eacute; um n&uacute;mero v&aacute;lido"
   });
}

if(L5.form.DateField){
   L5.apply(L5.form.DateField.prototype, {
      disabledDaysText  : "Desabilitado",
      disabledDatesText : "Desabilitado",
      minText           : "A data deste campo deve ser posterior a {0}",
      maxText           : "A data deste campo deve ser anterior a {0}",
      invalidText       : "{0} n&atilde;o &eacute; uma data v&aacute;lida - deve ser usado o formato {1}",
      format            : "d/m/Y"
   });
}

if(L5.form.ComboBox){
   L5.apply(L5.form.ComboBox.prototype, {
      loadingText       : "Carregando...",
      valueNotFoundText : undefined
   });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'Este campo deve ser um endere&ccedil;o de e-mail v&aacute;lido, no formato "utilizador@dominio.com"',
      urlText      : 'Este campo deve ser um URL no formato "http:/'+'/www.dominio.com"',
      alphaText    : 'Este campo deve conter apenas letras e _',
      alphanumText : 'Este campo deve conter apenas letras, n&uacute;meros e _'
   });
}

if(L5.form.HtmlEditor){
   L5.apply(L5.form.HtmlEditor.prototype, {
	 createLinkText : 'Por favor, entre com o URL do link:',
	 buttonTips : {
            bold : {
               title: 'Negrito (Ctrl+B)',
               text: 'Deixa o texto seleccionado em negrito.',
               cls: 'x-html-editor-tip'
            },
            italic : {
               title: 'Italico (Ctrl+I)',
               text: 'Deixa o texto seleccionado em italico.',
               cls: 'x-html-editor-tip'
            },
            underline : {
               title: 'Sublinhado (Ctrl+U)',
               text: 'Sublinha o texto seleccionado.',
               cls: 'x-html-editor-tip'
           },
           increasefontsize : {
               title: 'Aumentar Texto',
               text: 'Aumenta o tamanho da fonte.',
               cls: 'x-html-editor-tip'
           },
           decreasefontsize : {
               title: 'Diminuir Texto',
               text: 'Diminui o tamanho da fonte.',
               cls: 'x-html-editor-tip'
           },
           backcolor : {
               title: 'Cor de Fundo',
               text: 'Muda a cor do fundo do texto seleccionado.',
               cls: 'x-html-editor-tip'
           },
           forecolor : {
               title: 'Cor da Fonte',
               text: 'Muda a cor do texto seleccionado.',
               cls: 'x-html-editor-tip'
           },
           justifyleft : {
               title: 'Alinhar &agrave; Esquerda',
               text: 'Alinha o texto &agrave; esquerda.',
               cls: 'x-html-editor-tip'
           },
           justifycenter : {
               title: 'Centrar Texto',
               text: 'Centra o texto no editor.',
               cls: 'x-html-editor-tip'
           },
           justifyright : {
               title: 'Alinhar &agrave; Direita',
               text: 'Alinha o texto &agrave; direita.',
               cls: 'x-html-editor-tip'
           },
           insertunorderedlist : {
               title: 'Lista com Marcadores',
               text: 'Inicia uma lista com marcadores.',
               cls: 'x-html-editor-tip'
           },
           insertorderedlist : {
               title: 'Lista Numerada',
               text: 'Inicia uma lista numerada.',
               cls: 'x-html-editor-tip'
           },
           createlink : {
               title: 'Hyperliga&ccedil;&atilde;o',
               text: 'Transforma o texto selecionado num hyperlink.',
               cls: 'x-html-editor-tip'
           },
           sourceedit : {
               title: 'Editar Fonte',
               text: 'Troca para o modo de edi&ccedil;&atilde;o de c&oacute;digo fonte.',
               cls: 'x-html-editor-tip'
           }
        }
   });
}

if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "Ordem Ascendente",
      sortDescText : "Ordem Descendente",
      lockText     : "Bloquear Coluna",
      unlockText   : "Desbloquear Coluna",
      columnsText  : "Colunas"
   });
}

if(L5.grid.PropertyColumnModel){
   L5.apply(L5.grid.PropertyColumnModel.prototype, {
      nameText   : "Nome",
      valueText  : "Valor",
      dateFormat : "d/m/Y"
   });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "Arraste para redimensionar.",
      collapsibleSplitTip : "Arraste para redimensionar. Duplo clique para esconder."
   });
}
