

/*
 * Farsi (Persian) translation
 * By Mohaqa
 * 03-10-2007, 06:23 PM
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">در حال بارگذاری ...</div>';

if(L5.View){
   L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} رکورد انتخاب شده";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "بستن";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "مقدار فیلد صحیح نیست";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "در حال بارگذاری ...";
}

Date.monthNames = [
   "ژانویه",
   "فوریه",
   "مارس",
   "آپریل",
   "می",
   "ژوئن",
   "جولای",
   "آگوست",
   "سپتامبر",
   "اکتبر",
   "نوامبر",
   "دسامبر"
];

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

Date.dayNames = [
   "یکشنبه",
   "دوشنبه",
   "سه شنبه",
   "چهارشنبه",
   "پنجشنبه",
   "جمعه",
   "شنبه"
];

if(L5.MessageBox){
   L5.MessageBox.buttonText = {
      ok     : "تایید",
      cancel : "بازگشت",
      yes    : "بله",
      no     : "خیر"
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
    todayText         : "امروز",
    minText           : "این تاریخ قبل از محدوده مجاز است",
    maxText           : "این تاریخ پس از محدوده مجاز است",
    disabledDaysText  : "",
    disabledDatesText : "",
    monthNames        : Date.monthNames,
    dayNames          : Date.dayNames,
    nextText          : 'ماه بعد (Control + Right)',
    prevText          : 'ماه قبل (Control+Left)',
    monthYearText     : 'یک ماه را انتخاب کنید (Control+Up/Down برای انتقال در سال)',
    todayTip          : "{0} (Spacebar)",
    format            : "y/m/d",
    okText            : "&#160;OK&#160;",
    cancelText        : "Cancel",
    startDay          : 0
   });
}

if(L5.PagingToolbar){
   L5.apply(L5.PagingToolbar.prototype, {
      beforePageText : "صفحه",
      afterPageText  : "از {0}",
      firstText      : "صفحه اول",
      prevText       : "صفحه قبل",
      nextText       : "صفحه بعد",
      lastText       : "صفحه آخر",
      refreshText    : "بازخوانی",
      displayMsg     : "نمایش {0} - {1} of {2}",
      emptyMsg       : 'داده ای برای نمایش وجود ندارد'
   });
}

if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "حداقل طول این فیلد برابر است با {0}",
      maxLengthText : "حداکثر طول این فیلد برابر است با {0}",
      blankText     : "این فیلد باید مقداری داشته باشد",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "حداقل مقدار این فیلد برابر است با {0}",
      maxText : "حداکثر مقدار این فیلد برابر است با {0}",
      nanText : "{0} یک عدد نیست"
   });
}

if(L5.form.DateField){
   L5.apply(L5.form.DateField.prototype, {
      disabledDaysText  : "غیرفعال",
      disabledDatesText : "غیرفعال",
      minText           : "تاریخ باید پس از {0} باشد",
      maxText           : "تاریخ باید پس از {0} باشد",
      invalidText       : "{0} تاریخ صحیحی نیست - فرمت صحیح {1}",
      format            : "y/m/d"
   });
}

if(L5.form.ComboBox){
   L5.apply(L5.form.ComboBox.prototype, {
      loadingText       : "در حال بارگذاری ...",
      valueNotFoundText : undefined
   });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'مقدار این فیلد باید یک ایمیل با این فرمت باشد "user@domain.com"',
      urlText      : 'مقدار این آدرس باید یک آدرس سایت با این فرمت باشد "http:/'+'/www.domain.com"',
      alphaText    : 'مقدار این فیلد باید فقط از حروف الفبا و _ تشکیل شده باشد ',
      alphanumText : 'مقدار این فیلد باید فقط از حروف الفبا، اعداد و _ تشکیل شده باشد'
   });
}

if(L5.form.HtmlEditor){
  L5.apply(L5.form.HtmlEditor.prototype, {
    createLinkText : 'لطفا آدرس لینک را وارد کنید:',
    buttonTips : {
      bold : {
        title: 'تیره (Ctrl+B)',
        text: 'متن انتخاب شده را تیره می کند.',
        cls: 'x-html-editor-tip'
      },
      italic : {
        title: 'ایتالیک (Ctrl+I)',
        text: 'متن انتخاب شده را ایتالیک می کند.',
        cls: 'x-html-editor-tip'
      },
      underline : {
        title: 'زیرخط (Ctrl+U)',
        text: 'زیر هر نوشته یک خط نمایش می دهد.',
        cls: 'x-html-editor-tip'
      },
      increasefontsize : {
        title: 'افزایش اندازه',
        text: 'اندازه فونت را افزایش می دهد.',
        cls: 'x-html-editor-tip'
      },
      decreasefontsize : {
        title: 'کاهش اندازه',
        text: 'اندازه متن را کاهش می دهد.',
        cls: 'x-html-editor-tip'
      },
      backcolor : {
        title: 'رنگ زمینه متن',
        text: 'برای تغییر رنگ زمینه متن استفاده می شود.',
        cls: 'x-html-editor-tip'
      },
      forecolor : {
        title: 'رنگ قلم',
        text: 'رنگ  قلم متن را تغییر می دهد.',
        cls: 'x-html-editor-tip'
      },
      justifyleft : {
        title: 'چیدن متن از سمت چپ',
        text: 'متن از سمت چپ چیده شده می شود.',
        cls: 'x-html-editor-tip'
      },
      justifycenter : {
        title: 'متن در وسط ',
        text: 'نمایش متن در قسمت وسط صفحه و رعابت سمت چپ و راست.',
        cls: 'x-html-editor-tip'
      },
      justifyright : {
        title: 'چیدن متن از سمت راست',
        text: 'متن از سمت راست پیده خواهد شد.',
        cls: 'x-html-editor-tip'
      },
      insertunorderedlist : {
        title: 'لیست همراه با علامت',
        text: 'یک لیست جدید ایجاد می کند.',
        cls: 'x-html-editor-tip'
      },
      insertorderedlist : {
        title: 'لیست عددی',
        text: 'یک لیست عددی ایجاد می کند. ',
        cls: 'x-html-editor-tip'
      },
      createlink : {
        title: 'لینک',
        text: 'متن انتخاب شده را به لینک تبدیل کنید.',
        cls: 'x-html-editor-tip'
      },
      sourceedit : {
        title: 'ویرایش سورس',
        text: 'رفتن به حالت ویرایش سورس.',
        cls: 'x-html-editor-tip'
      }
    }
  });
}

if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "مرتب سازی افزایشی",
      sortDescText : "مرتب سازی کاهشی",
      lockText     : "قفل ستون ها",
      unlockText   : "بازکردن ستون ها",
      columnsText  : "ستون ها"
   });
}

if(L5.grid.PropertyColumnModel){
   L5.apply(L5.grid.PropertyColumnModel.prototype, {
      nameText   : "نام",
      valueText  : "مقدار",
      dateFormat : "Y/m/d"
   });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "درگ برای تغییر اندازه.",
      collapsibleSplitTip : "برای تغییر اندازه درگ کنید."
   });
}
