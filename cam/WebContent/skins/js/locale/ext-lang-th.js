

/**
 * List compiled by KillerNay on the extjs.com forums.
 * Thank you KillerNay!
 *
 * Thailand Translations
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">¡ÓÅÑ§âËÅŽ...</div>';

if(L5.View){
  L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
  L5.grid.GridPanel.prototype.ddText = "{0} àÅ×Í¡áÅéÇ·Ñé§ËÁŽá¶Ç";
}

if(L5.TabPanelItem){
  L5.TabPanelItem.prototype.closeText = "»ÔŽá·çº¹Õé";
}

if(L5.form.Field){
  L5.form.Field.prototype.invalidText = "€èÒ¢Í§ªèÍ§¹ÕéäÁè¶Ù¡µéÍ§";
}

if(L5.LoadMask){
  L5.LoadMask.prototype.msg = "¡ÓÅÑ§âËÅŽ...";
}

Date.monthNames = [
  "Á¡ÃÒ€Á",
  "¡ØÁŸÒÓŸÑ¹žì",
  "ÁÕ¹Ò€Á",
  "àÁÉÒÂ¹",
  "ŸÄÉÀÒ€Á",
  "ÁÔ¶Ø¹ÒÂ¹",
  "¡Ä¡¯Ò€Á",
  "ÊÔ§ËÒ€Á",
  "¡Ñ¹ÂÒÂ¹",
  "µØÅÒ€Á",
  "ŸÄÈšÔ¡ÒÂ¹",
  "žÑ¹ÇÒ€Á"
];

Date.getShortMonthName = function(month) {
  return Date.monthNames[month].substring(0, 3);
};

Date.monthNumbers = {
  "Á€" : 0,
  "¡Ÿ" : 1,
  "ÁÕ€" : 2,
  "àÁÂ" : 3,
  "Ÿ€" : 4,
  "ÁÔÂ" : 5,
  "¡€" : 6,
  "Ê€" : 7,
  "¡Â" : 8,
  "µ€" : 9,
  "ŸÂ" : 10,
  "ž€" : 11
};

Date.getMonthNumber = function(name) {
  return Date.monthNumbers[name.substring(0, 1).toUpperCase() + name.substring(1, 3).toLowerCase()];
};

Date.dayNames = [
  "ÍÒ·ÔµÂì",
  "šÑ¹·Ãì",
  "ÍÑ§€ÒÃ",
  "ŸØ×ž",
  "ŸÄËÑÊºŽÕ",
  "ÈØ¡Ãì",
  "àÊÒÃì"
];

Date.getShortDayName = function(day) {
  return Date.dayNames[day].substring(0, 3);
};

if(L5.MessageBox){
  L5.MessageBox.buttonText = {
    ok     : "µ¡Å§",
    cancel : "Â¡àÅÔ¡",
    yes    : "ãªè",
    no     : "äÁèãªè"
  };
}

if(L5.util.Format){
  L5.util.Format.date = function(v, format){
    if(!v) return "";
    if(!(v instanceof Date)) v = new Date(Date.parse(v));
    return v.dateFormat(format || "m/d/Y");
  };
}

if(L5.DatePicker){
  L5.apply(L5.DatePicker.prototype, {
    todayText         : "ÇÑ¹¹Õé",
    minText           : "This date is before the minimum date",
    maxText           : "This date is after the maximum date",
    disabledDaysText  : "",
    disabledDatesText : "",
    monthNames        : Date.monthNames,
    dayNames          : Date.dayNames,
    nextText          : 'àŽ×Í¹¶ÑŽä» (Control+Right)',
    prevText          : 'àŽ×Í¹¡èÍ¹Ë¹éÒ (Control+Left)',
    monthYearText     : 'àÅ×Í¡àŽ×Í¹ (Control+Up/Down to move years)',
    todayTip          : "{0} (Spacebar)",
    format            : "m/d/y",
    okText            : "&#160;µ¡Å§&#160;",
    cancelText        : "Â¡àÅÔ¡",
    startDay          : 0
  });
}

if(L5.PagingToolbar){
  L5.apply(L5.PagingToolbar.prototype, {
    beforePageText : "Ë¹éÒ",
    afterPageText  : "of {0}",
    firstText      : "Ë¹éÒáÃ¡",
    prevText       : "¡èÍ¹Ë¹éÒ",
    nextText       : "¶ÑŽä»",
    lastText       : "Ë¹éÒÊØŽ·éÒÂ",
    refreshText    : "ÃÕà¿Ãª",
    displayMsg     : "¡ÓÅÑ§áÊŽ§ {0} - {1} šÒ¡ {2}",
    emptyMsg       : 'äÁèÁÕ¢éÍÁÙÅáÊŽ§'
  });
}

if(L5.form.TextField){
  L5.apply(L5.form.TextField.prototype, {
    minLengthText : "The minimum length for this field is {0}",
    maxLengthText : "The maximum length for this field is {0}",
    blankText     : "This field is required",
    regexText     : "",
    emptyText     : null
  });
}

if(L5.form.NumberField){
  L5.apply(L5.form.NumberField.prototype, {
    minText : "The minimum value for this field is {0}",
    maxText : "The maximum value for this field is {0}",
    nanText : "{0} is not a valid number"
  });
}

if(L5.form.DateField){
  L5.apply(L5.form.DateField.prototype, {
    disabledDaysText  : "»ÔŽ",
    disabledDatesText : "»ÔŽ",
    minText           : "The date in this field must be after {0}",
    maxText           : "The date in this field must be before {0}",
    invalidText       : "{0} is not a valid date - it must be in the format {1}",
    format            : "m/d/y",
    altFormats        : "m/d/Y|m-d-y|m-d-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d"
  });
}

if(L5.form.ComboBox){
  L5.apply(L5.form.ComboBox.prototype, {
    loadingText       : "¡ÓÅÑ§âËÅŽ...",
    valueNotFoundText : undefined
  });
}

if(L5.form.VTypes){
  L5.apply(L5.form.VTypes, {
    emailText    : 'This field should be an e-mail address in the format "user@domain.com"',
    urlText      : 'This field should be a URL in the format "http:/'+'/www.domain.com"',
    alphaText    : 'This field should only contain letters and _',
    alphanumText : 'This field should only contain letters, numbers and _'
  });
}

if(L5.form.HtmlEditor){
  L5.apply(L5.form.HtmlEditor.prototype, {
    createLinkText : 'Please enter the URL for the link:',
    buttonTips : {
      bold : {
        title: 'Bold (Ctrl+B)',
        text: 'Make the selected text bold.',
        cls: 'x-html-editor-tip'
      },
      italic : {
        title: 'Italic (Ctrl+I)',
        text: 'Make the selected text italic.',
        cls: 'x-html-editor-tip'
      },
      underline : {
        title: 'Underline (Ctrl+U)',
        text: 'Underline the selected text.',
        cls: 'x-html-editor-tip'
      },
      increasefontsize : {
        title: 'Grow Text',
        text: 'Increase the font size.',
        cls: 'x-html-editor-tip'
      },
      decreasefontsize : {
        title: 'Shrink Text',
        text: 'Decrease the font size.',
        cls: 'x-html-editor-tip'
      },
      backcolor : {
        title: 'Text Highlight Color',
        text: 'Change the background color of the selected text.',
        cls: 'x-html-editor-tip'
      },
      forecolor : {
        title: 'Font Color',
        text: 'Change the color of the selected text.',
        cls: 'x-html-editor-tip'
      },
      justifyleft : {
        title: 'Align Text Left',
        text: 'Align text to the left.',
        cls: 'x-html-editor-tip'
      },
      justifycenter : {
        title: 'Center Text',
        text: 'Center text in the editor.',
        cls: 'x-html-editor-tip'
      },
      justifyright : {
        title: 'Align Text Right',
        text: 'Align text to the right.',
        cls: 'x-html-editor-tip'
      },
      insertunorderedlist : {
        title: 'Bullet List',
        text: 'Start a bulleted list.',
        cls: 'x-html-editor-tip'
      },
      insertorderedlist : {
        title: 'Numbered List',
        text: 'Start a numbered list.',
        cls: 'x-html-editor-tip'
      },
      createlink : {
        title: 'Hyperlink',
        text: 'Make the selected text a hyperlink.',
        cls: 'x-html-editor-tip'
      },
      sourceedit : {
        title: 'Source Edit',
        text: 'Switch to source editing mode.',
        cls: 'x-html-editor-tip'
      }
    }
  });
}

if(L5.grid.GridView){
  L5.apply(L5.grid.GridView.prototype, {
    sortAscText  : "Sort Ascending",
    sortDescText : "Sort Descending",
    lockText     : "Lock Column",
    unlockText   : "Unlock Column",
    columnsText  : "Columns"
  });
}

if(L5.grid.GroupingView){
  L5.apply(L5.grid.GroupingView.prototype, {
    emptyGroupText : '(None)',
    groupByText    : 'Group By This Field',
    showGroupsText : 'Show in Groups'
  });
}

if(L5.grid.PropertyColumnModel){
  L5.apply(L5.grid.PropertyColumnModel.prototype, {
    nameText   : "Name",
    valueText  : "Value",
    dateFormat : "m/j/Y"
  });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
  L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
    splitTip            : "Drag to resize.",
    collapsibleSplitTip : "Drag to resize. Double click to hide."
  });
}
