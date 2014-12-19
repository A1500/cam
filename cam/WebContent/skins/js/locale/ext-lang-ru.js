

/*
 * Russian translation
 * By ZooKeeper (utf-8 encoding)
 * 6 November 2007
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Идет загрузка...</div>';

if(L5.View){
  L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
  L5.grid.GridPanel.prototype.ddText = "{0} выбранных строк";
}

if(L5.TabPanelItem){
  L5.TabPanelItem.prototype.closeText = "Закрыть эту вкладку";
}

if(L5.form.Field){
  L5.form.Field.prototype.invalidText = "Значение в этом поле неверное";
}

if(L5.LoadMask){
  L5.LoadMask.prototype.msg = "Загрузка...";
}

Date.monthNames = [
    "Январь",
    "Февраль",
    "Март",
    "Апрель",
    "Май",
    "Июнь",
    "Июль",
    "Август",
    "Сентябрь",
    "Октябрь",
    "Ноябрь",
    "Декабрь"
];

Date.shortMonthNames = [
  "Янв",
  "Февр",
  "Март",
  "Апр",
  "Май",
  "Июнь",
  "Июль",
  "Авг",
  "Сент",
  "Окт",
  "Нояб",
  "Дек"
];

Date.getShortMonthName = function(month) {
  return Date.shortMonthNames[month];
};

Date.monthNumbers = {
  'Янв': 0,
  'Фев': 1,
  'Мар': 2,
  'Апр': 3,
  'Май': 4,
  'Июн': 5,
  'Июл': 6,
  'Авг': 7,
  'Сен': 8,
  'Окт': 9,
  'Ноя': 10,
  'Дек': 11
};

Date.getMonthNumber = function(name) {
  return Date.monthNumbers[name.substring(0, 1).toUpperCase() + name.substring(1, 3).toLowerCase()];
};

Date.dayNames = [
  "Воскресенье",
  "Понедельник",
  "Вторник",
  "Среда",
  "Четверг",
  "Пятница",
  "Суббота"
];

Date.getShortDayName = function(day) {
  return Date.dayNames[day].substring(0, 3);
};

if(L5.MessageBox){
  L5.MessageBox.buttonText = {
    ok     : "OK",
    cancel : "Отмена",
    yes    : "Да",
    no     : "Нет"
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
    todayText          : "Сегодня",
    minText            : "Эта дата раньше минимальной даты",
    maxText            : "Эта дата позже максимальной даты",
    disabledDaysText   : "",
    disabledDatesText  : "",
    monthNames         : Date.monthNames,
    dayNames           : Date.dayNames,
    nextText           : 'Следующий месяц (Control+Вправо)',
    prevText           : 'Предыдущий месяц (Control+Влево)',
    monthYearText      : 'Выбор месяца (Control+Вверх/Вниз для выбора года)',
    todayTip           : "{0} (Пробел)",
    format             : "d.m.y",
    okText             : "&#160;OK&#160;",
    cancelText         : "Отмена",
    startDay           : 1
  });
}

if(L5.PagingToolbar){
  L5.apply(L5.PagingToolbar.prototype, {
    beforePageText : "Страница",
    afterPageText  : "из {0}",
    firstText      : "Первая страница",
    prevText       : "Предыдущая страница",
    nextText       : "Следующая страница",
    lastText       : "Последняя страница",
    refreshText    : "Обновить",
    displayMsg     : "Отображаются записи с {0} по {1}, всего {2}",
    emptyMsg       : 'Нет данных для отображения'
  });
}

if(L5.form.TextField){
  L5.apply(L5.form.TextField.prototype, {
    minLengthText : "Минимальная длина этого поля {0}",
    maxLengthText : "Максимальная длина этого поля {0}",
    blankText     : "Это поле обязательно для заполнения",
    regexText     : "",
    emptyText     : null
  });
}

if(L5.form.NumberField){
  L5.apply(L5.form.NumberField.prototype, {
    minText : "Значение этого поля не может быть меньше {0}",
    maxText : "Значение этого поля не может быть больше {0}",
    nanText : "{0} не является числом"
  });
}

if(L5.form.DateField){
  L5.apply(L5.form.DateField.prototype, {
    disabledDaysText  : "Не доступно",
    disabledDatesText : "Не доступно",
    minText           : "Дата в этом поле должна быть позде {0}",
    maxText           : "Дата в этом поле должна быть раньше {0}",
    invalidText       : "{0} не является правильной датой - дата должна быть указана в формате {1}",
    format            : "d.m.y",
    altFormats        : "d.m.y|d/m/Y|d-m-y|d-m-Y|d/m|d-m|dm|dmy|dmY|d|Y-m-d"
  });
}

if(L5.form.ComboBox){
  L5.apply(L5.form.ComboBox.prototype, {
    loadingText       : "Загрузка...",
    valueNotFoundText : undefined
  });
}

if(L5.form.VTypes){
  L5.apply(L5.form.VTypes, {
    emailText     : 'Это поле должно содержать адрес электронной почты в формате "user@domain.com"',
    urlText       : 'Это поле должно содержать URL в формате "http:/'+'/www.domain.com"',
    alphaText     : 'Это поле должно содержать только латинские буквы и символ подчеркивания "_"',
    alphanumText  : 'Это поле должно содержать только латинские буквы, цифры и символ подчеркивания "_"'
  });
}

if(L5.form.HtmlEditor){
  L5.apply(L5.form.HtmlEditor.prototype, {
    createLinkText : 'Пожалуйста введите адрес:',
    buttonTips : {
      bold : {
        title: 'Полужирный (Ctrl+B)',
        text: 'Применение полужирного начертания к выделенному тексту.',
        cls: 'x-html-editor-tip'
      },
      italic : {
        title: 'Курсив (Ctrl+I)',
        text: 'Применение курсивного начертания к выделенному тексту.',
        cls: 'x-html-editor-tip'
      },
      underline : {
        title: 'Подчёркнутый (Ctrl+U)',
        text: 'Подчёркивание выделенного текста.',
        cls: 'x-html-editor-tip'
      },
      increasefontsize : {
        title: 'Увеличить размер',
        text: 'Увеличение размера шрифта.',
        cls: 'x-html-editor-tip'
      },
      decreasefontsize : {
        title: 'Уменьшить размер',
        text: 'Уменьшение размера шрифта.',
        cls: 'x-html-editor-tip'
      },
      backcolor : {
        title: 'Заливка',
        text: 'Изменение цвета фона для выделенного текста или абзаца.',
        cls: 'x-html-editor-tip'
      },
      forecolor : {
        title: 'Цвет текста',
        text: 'Измение цвета текста.',
        cls: 'x-html-editor-tip'
      },
      justifyleft : {
        title: 'Выровнять текст по левому краю',
        text: 'Выровнивание текста по левому краю.',
        cls: 'x-html-editor-tip'
      },
      justifycenter : {
        title: 'По центру',
        text: 'Выровнивание текста по центру.',
        cls: 'x-html-editor-tip'
      },
      justifyright : {
        title: 'Выровнять текст по правому краю',
        text: 'Выровнивание текста по правому краю.',
        cls: 'x-html-editor-tip'
      },
      insertunorderedlist : {
        title: 'Маркеры',
        text: 'Начать маркированный список.',
        cls: 'x-html-editor-tip'
      },
      insertorderedlist : {
        title: 'Нумерация',
        text: 'Начать нумернованный список.',
        cls: 'x-html-editor-tip'
      },
      createlink : {
        title: 'Вставить гиперссылку',
        text: 'Создание ссылки из выделенного текста.',
        cls: 'x-html-editor-tip'
      },
      sourceedit : {
        title: 'Исходный код',
        text: 'Переключиться на исходный код.',
        cls: 'x-html-editor-tip'
      }
    }
  });
}

if(L5.form.BasicForm){
  L5.form.BasicForm.prototype.waitTitle = "Пожалуйста подождите...";
}

if(L5.grid.GridView){
  L5.apply(L5.grid.GridView.prototype, {
    sortAscText  : "Сортировать по возрастанию",
    sortDescText : "Сортировать по убыванию",
    lockText     : "Закрепить столбец",
    unlockText   : "Снять закрепление столбца",
    columnsText  : "Столбцы"
  });
}

if(L5.grid.GroupingView){
  L5.apply(L5.grid.GroupingView.prototype, {
    emptyGroupText : '(Пусто)',
    groupByText    : 'Группировать по этому полю',
    showGroupsText : 'Отображать по группам'
  });
}

if(L5.grid.PropertyColumnModel){
  L5.apply(L5.grid.PropertyColumnModel.prototype, {
    nameText   : "Название",
    valueText  : "Значение",
    dateFormat : "d.m.Y"
  });
}

if(L5.SplitLayoutRegion){
  L5.apply(L5.SplitLayoutRegion.prototype, {
    splitTip            : "Тяните для изменения размера.",
    collapsibleSplitTip : "Тяните для изменения размера. Двойной щелчок спрячет панель."
  });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
  L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
    splitTip            : "Тяните для изменения размера.",
    collapsibleSplitTip : "Тяните для изменения размера. Двойной щелчок спрячет панель."
  });
}
