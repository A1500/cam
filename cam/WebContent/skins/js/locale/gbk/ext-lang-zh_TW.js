/*
 * Traditional Chinese translation
 * By hata1234
 * 09 April 2007
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">讀取中...</div>';

if(L5.View){
    L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
    L5.grid.GridPanel.prototype.ddText = "選擇了 {0} 行";
}

if(L5.TabPanelItem){
    L5.TabPanelItem.prototype.closeText = "關閉此標籤";
}

if(L5.form.Field){
    L5.form.Field.prototype.invalidText = "數值不符合欄位規定";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "讀取中...";
}

Date.monthNames = [
    "一月",
    "二月",
    "三月",
    "四月",
    "五月",
    "六月",
    "七月",
    "八月",
    "九月",
    "十月",
    "十一月",
    "十二月"
];

Date.dayNames = [
    "日",
    "一",
    "二",
    "三",
    "四",
    "五",
    "六"
];

if(L5.MessageBox){
    L5.MessageBox.buttonText = {
        ok : "確定",
        cancel : "取消",
        yes : "是",
        no : "否"
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
       todayText         : "今天",
       minText           : "日期必須大於最小容許日期",
       maxText           : "日期必須小於最大容許日期",
       disabledDaysText  : "",
       disabledDatesText : "",
       monthNames        : Date.monthNames,
       dayNames          : Date.dayNames,       
       nextText          : "下個月 (Ctrl+右方向鍵)",
       prevText          : "上個月 (Ctrl+左方向鍵)",
       monthYearText     : "選擇月份 (Ctrl+上/下方向鍵選擇年份)",
       todayTip          : "{0} (空白鍵)",
       format            : "y/m/d",
       okText            : "确定",
       cancelText        : "取消"
    });
}

if(L5.PagingToolbar){
    L5.apply(L5.PagingToolbar.prototype, {
       beforePageText : "第",
       afterPageText  : "頁，共{0}頁",
       firstText      : "第一頁",
       prevText       : "上一頁",
       nextText       : "下一頁",
       lastText       : "最後頁",
       refreshText    : "重新整理",
       displayMsg     : "顯示{0} - {1}頁,共{2}頁",
       emptyMsg       : '沒有任何資料'
    });
}

if(L5.form.TextField){
    L5.apply(L5.form.TextField.prototype, {
       minLengthText : "此欄位最少要輸入 {0} 個字",
       maxLengthText : "此欄位最多輸入 {0} 個字",
       blankText     : "此欄位為必填",
       regexText     : "",
       emptyText     : null
    });
}

if(L5.form.NumberField){
    L5.apply(L5.form.NumberField.prototype, {
       minText : "此欄位之數值必須大於 {0}",
       maxText : "此欄位之數值必須小於 {0}",
       nanText : "{0} 不是合法的數字"
    });
}

if(L5.form.DateField){
    L5.apply(L5.form.DateField.prototype, {
       disabledDaysText  : "無法使用",
       disabledDatesText : "無法使用",
       minText           : "此欄位之日期必須在 {0} 之後",
       maxText           : "此欄位之日期必須在 {0} 之前",
       invalidText       : "{0} 不是正確的日期格式 - 必須像是 「 {1} 」 這樣的格式",
       format            : "Y/m/d"
    });
}

if(L5.form.ComboBox){
    L5.apply(L5.form.ComboBox.prototype, {
       loadingText       : "讀取中 ...",
       valueNotFoundText : undefined
    });
}

if(L5.form.VTypes){
    L5.apply(L5.form.VTypes, {
       emailText    : '此欄位必須輸入像 "user@domain.com" 之E-Mail格式',
       urlText      : '此欄位必須輸入像 "http:/'+'/www.domain.com" 之網址格式',
       alphaText    : '此欄位僅能輸入半形英文字母及底線( _ )符號',
       alphanumText : '此欄位僅能輸入半形英文字母、數字及底線( _ )符號'
    });
}

if(L5.grid.GridView){
    L5.apply(L5.grid.GridView.prototype, {
       sortAscText  : "正向排序",
       sortDescText : "反向排序",
       lockText     : "鎖定欄位",
       unlockText   : "解開欄位鎖定",
       columnsText  : "欄位"
    });
}

if(L5.grid.PropertyColumnModel){
    L5.apply(L5.grid.PropertyColumnModel.prototype, {
       nameText   : "名稱",
       valueText  : "數值",
       dateFormat : "Y/m/d"
    });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
    L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
       splitTip            : "拖曳縮放大小.",
       collapsibleSplitTip : "拖曳縮放大小. 滑鼠雙擊隱藏."
    });
}

L5.connectionError="连接服务器失败";
L5.turnPage="页号太大或太小";
L5.turnPageFirst="已经是第一页";
L5.turnPageLast="已经是最后一页";
L5.di="第";
L5.hang="行";
L5.lie="列";
L5.valError="校验错误";
L5.parseReturnError="解析返回值异常";
L5.loadDateError="加载数据出错：";