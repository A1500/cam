

/**
 * Hebrew Translations
 * By spartacus (from forums) 06-12-2007
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">...����</div>';

if(L5.View){
  L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
  L5.grid.GridPanel.prototype.ddText = "����� ������ {0}";
}

if(L5.TabPanelItem){
  L5.TabPanelItem.prototype.closeText = "���� ������";
}

if(L5.form.Field){
  L5.form.Field.prototype.invalidText = "���� ���� �� ����";
}

if(L5.LoadMask){
  L5.LoadMask.prototype.msg = "...����";
}

Date.monthNames = [
  "�����",
  "������",
  "���",
  "�����",
  "���",
  "����",
  "����",
  "������",
  "������",
  "�������",
  "������",
  "�����"
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
  "�",
  "�",
  "�",
  "�",
  "�",
  "�",
  "�"
];

Date.getShortDayName = function(day) {
  return Date.dayNames[day].substring(0, 3);
};

if(L5.MessageBox){
  L5.MessageBox.buttonText = {
    ok     : "�����",
    cancel : "�����",
    yes    : "��",
    no     : "��"
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
    todayText         : "����",
    minText           : ".����� �� �� ���� ������ ������� �����",
    maxText           : ".����� �� �� ���� ������ ����� �����",
    disabledDaysText  : "",
    disabledDatesText : "",
    monthNames        : Date.monthNames,
    dayNames          : Date.dayNames,
    nextText          : '(Control+Right) ����� ���',
    prevText          : '(Control+Left) ����� �����',
    monthYearText     : '(������ ��� Control+Up/Down) ��� ����',
    todayTip          : "��� ����) {0})",
    format            : "d/m/Y",
    okText            : "&#160;�����&#160;",
    cancelText        : "�����",
    startDay          : 0
  });
}

if(L5.PagingToolbar){
  L5.apply(L5.PagingToolbar.prototype, {
    beforePageText : "����",
    afterPageText  : "{0} ����",
    firstText      : "���� �����",
    prevText       : "���� ����",
    nextText       : "���� ���",
    lastText       : "���� �����",
    refreshText    : "����",
    displayMsg     : "���� {0} - {1} ���� {2}",
    emptyMsg       : '��� ���� �����'
  });
}

if(L5.form.TextField){
  L5.apply(L5.form.TextField.prototype, {
    minLengthText : "{0} ����� ��������� ���� �� ���",
    maxLengthText : "{0} ����� ������ ���� �� ���",
    blankText     : "��� �� �����",
    regexText     : "",
    emptyText     : null
  });
}

if(L5.form.NumberField){
  L5.apply(L5.form.NumberField.prototype, {
    minText : "{0} ���� ��������� ���� �� ���",
    maxText : "{0} ���� ������ ���� �� ���",
    nanText : "��� �� ���� {0}"
  });
}

if(L5.form.DateField){
  L5.apply(L5.form.DateField.prototype, {
    disabledDaysText  : "������",
    disabledDatesText : "������",
    minText           : "{0} ������ ���� �� ���� ����� ����",
    maxText           : "{0} ������ ���� �� ���� ����� ����",
    invalidText       : "{1} ��� �� ����� ���� - ���� ����� ������ {0}",
    format            : "m/d/y",
    altFormats        : "m/d/Y|m-d-y|m-d-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d"
  });
}

if(L5.form.ComboBox){
  L5.apply(L5.form.ComboBox.prototype, {
    loadingText       : "...����",
    valueNotFoundText : undefined
  });
}

if(L5.form.VTypes){
  L5.apply(L5.form.VTypes, {
    emailText    : '"user@domain.com" ��� �� ���� ����� ����� ���� �������� ������',
    urlText      : '"http:/'+'/www.domain.com" ��� �� ���� ����� ����� ������� ������',
    alphaText    : '_��� �� ���� ����� �� ������ �',
    alphanumText : '_��� �� ���� ����� �� ������, ������ �'
  });
}

if(L5.form.HtmlEditor){
  L5.apply(L5.form.HtmlEditor.prototype, {
    createLinkText : ':��� ���� �� ����� �������� ���� ������',
    buttonTips : {
      bold : {
        title: '(Ctrl+B) �����',
        text: '.���� �� ����� �����',
        cls: 'x-html-editor-tip'
      },
      italic : {
        title: '(Ctrl+I) ����',
        text: '.��� �� ����� �����',
        cls: 'x-html-editor-tip'
      },
      underline : {
        title: '(Ctrl+U) �� ����',
        text: '.���� �� ���� ���� ����� �����',
        cls: 'x-html-editor-tip'
      },
      increasefontsize : {
        title: '���� ����',
        text: '.���� ���� ���� ����� �����',
        cls: 'x-html-editor-tip'
      },
      decreasefontsize : {
        title: '���� ����',
        text: '.���� ���� ���� ����� �����',
        cls: 'x-html-editor-tip'
      },
      backcolor : {
        title: '��� ��� �����',
        text: '.��� �� ��� ���� ���� ����� �����',
        cls: 'x-html-editor-tip'
      },
      forecolor : {
        title: '��� ����',
        text: '.��� �� ��� ����� ���� ����� �����',
        cls: 'x-html-editor-tip'
      },
      justifyleft : {
        title: '���� �����',
        text: '.��� ����� �� ����� �����',
        cls: 'x-html-editor-tip'
      },
      justifycenter : {
        title: '���� �����',
        text: '.��� ����� �� ����� �����',
        cls: 'x-html-editor-tip'
      },
      justifyright : {
        title: '���� �����',
        text: '.��� ����� �� ����� �����',
        cls: 'x-html-editor-tip'
      },
      insertunorderedlist : {
        title: '����� ������',
        text: '.���� ����� ������',
        cls: 'x-html-editor-tip'
      },
      insertorderedlist : {
        title: '����� �������',
        text: '.���� ����� �������',
        cls: 'x-html-editor-tip'
      },
      createlink : {
        title: '�����',
        text: '.���� �� ����� ����� ������',
        cls: 'x-html-editor-tip'
      },
      sourceedit : {
        title: '����� ��� ����',
        text: '.��� ��� ����',
        cls: 'x-html-editor-tip'
      }
    }
  });
}

if(L5.grid.GridView){
  L5.apply(L5.grid.GridView.prototype, {
    sortAscText  : "���� ���� ����",
    sortDescText : "���� ���� ����",
    lockText     : "��� �����",
    unlockText   : "���� �����",
    columnsText  : "������"
  });
}

if(L5.grid.GroupingView){
  L5.apply(L5.grid.GroupingView.prototype, {
    emptyGroupText : '(���)',
    groupByText    : '��� ������� ��� ��� ��',
    showGroupsText : '��� �������'
  });
}

if(L5.grid.PropertyColumnModel){
  L5.apply(L5.grid.PropertyColumnModel.prototype, {
    nameText   : "��",
    valueText  : "���",
    dateFormat : "m/j/Y"
  });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
  L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
    splitTip            : ".���� ������ ����",
    collapsibleSplitTip : ".���� ������ ����. ����� ����� ������"
  });
}
