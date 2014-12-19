

/*
 * Japanese translation
 * By tyama
 * 04-08-2007, 05:49 AM
 *
 * update based on English Translations by Condor (8 Aug 2008)
 * By sakuro (30 Aug 2008)
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">読み込み中...</div>';

if(L5.DataView){
  L5.DataView.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
  L5.grid.GridPanel.prototype.ddText = "{0} 行選択";
}

if(L5.LoadMask){
  L5.LoadMask.prototype.msg = "読み込み中...";
}

Date.monthNames = [
  '1月',
  '2月',
  '3月',
  '4月',
  '5月',
  '6月',
  '7月',
  '8月',
  '9月',
  '10月',
  '11月',
  '12月'
];

Date.getShortMonthName = function(month) {
  return "" + (month + 1);
};

Date.monthNumbers = {
  "1" : 0,
  "2" : 1,
  "3" : 2,
  "4" : 3,
  "5" : 4,
  "6" : 5,
  "7" : 6,
  "8" : 7,
  "9" : 8,
  "10" : 9,
  "11" : 10,
  "12" : 11
};

Date.getMonthNumber = function(name) {
  return Date.monthNumbers[name.substring(0, name.length - 1)];
  // or simply parseInt(name.substring(0, name.length - 1)) - 1
};

Date.dayNames = [
  "日曜日",
  "月曜日",
  "火曜日",
  "水曜日",
  "木曜日",
  "金曜日",
  "土曜日"
];

Date.getShortDayName = function(day) {
  return Date.dayNames[day].substring(0, 1); // just remove "曜日" suffix
};

Date.formatCodes.a = "(this.getHours() < 12 ? '午前' : '午後')";
Date.formatCodes.A = "(this.getHours() < 12 ? '午前' : '午後')"; // no case difference

if(L5.MessageBox){
  L5.MessageBox.buttonText = {
    ok     : "OK",
    cancel : "キャンセル",
    yes    : "はい",
    no     : "いいえ"
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
    todayText         : "今日",
    minText           : "選択した日付は最小値以下です。",
    maxText           : "選択した日付は最大値以上です。",
    disabledDaysText  : "",
    disabledDatesText : "",
    monthNames        : Date.monthNames,
    dayNames          : Date.dayNames,
    nextText          : '次月へ (コントロール+右)',
    prevText          : '前月へ (コントロール+左)',
    monthYearText     : '月選択 (コントロール+上/下で年移動)',
    todayTip          : "{0} (スペースキー)",
    format            : "Y/m/d",
    okText            : "OK",
    cancelText        : "キャンセル",
    startDay          : 0
  });
}

if(L5.PagingToolbar){
  L5.apply(L5.PagingToolbar.prototype, {
    beforePageText : "ページ",
    afterPageText  : "/ {0}",
    firstText      : "最初のページ",
    prevText       : "前のページ",
    nextText       : "次のページ",
    lastText       : "最後のページ",
    refreshText    : "更新",
    displayMsg     : "{2} 件中 {0} - {1} を表示",
    emptyMsg       : '表示するデータがありません。'
  });
}

if(L5.form.Field){
  L5.form.Field.prototype.invalidText = "フィールドの値が不正です。";
}

if(L5.form.TextField){
  L5.apply(L5.form.TextField.prototype, {
    minLengthText : "このフィールドの最小値は {0} です。",
    maxLengthText : "このフィールドの最大値は {0} です。",
    blankText     : "必須項目です。",
    regexText     : "",
    emptyText     : null
  });
}

if(L5.form.NumberField){
  L5.apply(L5.form.NumberField.prototype, {
    decimalSeparator : ".",
    decimalPrecision : 2,
    minText : "このフィールドの最小値は {0} です。",
    maxText : "このフィールドの最大値は {0} です。",
    nanText : "{0} は数値ではありません。"
  });
}

if(L5.form.DateField){
  L5.apply(L5.form.DateField.prototype, {
    disabledDaysText  : "無効",
    disabledDatesText : "無効",
    minText           : "このフィールドの日付は、 {0} 以降の日付に設定してください。",
    maxText           : "このフィールドの日付は、 {0} 以前の日付に設定してください。",
    invalidText       : "{0} は間違った日付入力です。 - 入力形式は「{1}」です。",
    format            : "Y/m/d",
    altFormats        : "y/m/d|m/d/y|m/d/Y|m-d-y|m-d-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d"
  });
}

if(L5.form.ComboBox){
  L5.apply(L5.form.ComboBox.prototype, {
    loadingText       : "読み込み中...",
    valueNotFoundText : undefined
  });
}

if(L5.form.VTypes){
  L5.apply(L5.form.VTypes, {
    emailText    : 'メールアドレスを"user@domain.com"の形式で入力してください。',
    urlText      : 'URLを"http:/'+'/www.domain.com"の形式で入力してください。',
    alphaText    : '半角英字と"_"のみです。',
    alphanumText : '半角英数と"_"のみです。'
  });
}

if(L5.form.HtmlEditor){
  L5.apply(L5.form.HtmlEditor.prototype, {
    createLinkText : 'リンクのURLを入力してください:',
    buttonTips : {
      bold : {
        title: '太字 (コントロール+B)',
        text: '選択テキストを太字にします。',
        cls: 'x-html-editor-tip'
      },
      italic : {
        title: '斜体 (コントロール+I)',
        text: '選択テキストを斜体にします。',
        cls: 'x-html-editor-tip'
      },
      underline : {
        title: '下線 (コントロール+U)',
        text: '選択テキストに下線を引きます。',
        cls: 'x-html-editor-tip'
      },
      increasefontsize : {
        title: '文字を大きく',
        text: 'フォントサイズを大きくします。',
        cls: 'x-html-editor-tip'
      },
      decreasefontsize : {
        title: '文字を小さく',
        text: 'フォントサイズを小さくします。',
        cls: 'x-html-editor-tip'
      },
      backcolor : {
        title: '文字のハイライト',
        text: '選択テキストの背景色を変更します。',
        cls: 'x-html-editor-tip'
      },
      forecolor : {
        title: '文字の色',
        text: '選択テキストの色を変更します。',
        cls: 'x-html-editor-tip'
      },
      justifyleft : {
        title: '左揃え',
        text: 'テキストを左揃えにします。',
        cls: 'x-html-editor-tip'
      },
      justifycenter : {
        title: '中央揃え',
        text: 'テキストを中央揃えにします。',
        cls: 'x-html-editor-tip'
      },
      justifyright : {
        title: '右揃え',
        text: 'テキストを右揃えにします。',
        cls: 'x-html-editor-tip'
      },
      insertunorderedlist : {
        title: '番号なし箇条書き',
        text: '番号なし箇条書きを開始します。',
        cls: 'x-html-editor-tip'
      },
      insertorderedlist : {
        title: '番号付き箇条書き',
        text: '番号付き箇条書きを開始します。',
        cls: 'x-html-editor-tip'
      },
      createlink : {
        title: 'ハイパーリンク',
        text: '選択テキストをハイパーリンクにします。',
        cls: 'x-html-editor-tip'
      },
      sourceedit : {
        title: 'ソース編集',
        text: 'ソース編集モードに切り替えます。',
        cls: 'x-html-editor-tip'
      }
    }
  });
}

if(L5.grid.GridView){
  L5.apply(L5.grid.GridView.prototype, {
    sortAscText  : "昇順",
    sortDescText : "降順",
    columnsText  : "カラム"
  });
}

if(L5.grid.GroupingView){
  L5.apply(L5.grid.GroupingView.prototype, {
    emptyGroupText : '(なし)',
    groupByText    : 'このカラムでグルーピング',
    showGroupsText : 'グルーピング'
  });
}

if(L5.grid.PropertyColumnModel){
  L5.apply(L5.grid.PropertyColumnModel.prototype, {
    nameText   : "名称",
    valueText  : "値",
    dateFormat : "Y/m/d"
  });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
  L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
    splitTip            : "ドラッグするとリサイズできます。",
    collapsibleSplitTip : "ドラッグでリサイズ。 ダブルクリックで隠す。"
  });
}

if(L5.form.TimeField){
  L5.apply(L5.form.TimeField.prototype, {
    minText : "このフィールドの時刻は、 {0} 以降の時刻に設定してください。",
    maxText : "このフィールドの時刻は、 {0} 以前の時刻に設定してください。",
    invalidText : "{0} は間違った時刻入力です。",
    format : "g:i A",
    altFormats : "g:ia|g:iA|g:i a|g:i A|h:i|g:i|H:i|ga|ha|gA|h a|g a|g A|gi|hi|gia|hia|g|H"
  });
}

if(L5.form.CheckboxGroup){
  L5.apply(L5.form.CheckboxGroup.prototype, {
    blankText : "このグループから最低１つのアイテムを選択しなければなりません。"
  });
}

if(L5.form.RadioGroup){
  L5.apply(L5.form.RadioGroup.prototype, {
    blankText : "このグループから１つのアイテムを選択しなければなりません。"
  });
}
