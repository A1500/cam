

/**
 * List compiled by mystix on the extjs.com forums.
 * Thank you Mystix!
 */

/**
 * Vietnamese translation
 * By bpmtri
 * 12-April-2007 04:06PM
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Đang tải...</div>';

if(L5.View){
   L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} dòng được chọn";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "Đóng thẻ này";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "Giá trị của ô này không hợp lệ.";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "Đang tải...";
}

Date.monthNames = [
   "Tháng 1",
   "Tháng 2",
   "Tháng 3",
   "Tháng 4",
   "Tháng 5",
   "Tháng 6",
   "Tháng 7",
   "Tháng 8",
   "Tháng 9",
   "Tháng 10",
   "Tháng 11",
   "Tháng 12"
];

Date.dayNames = [
   "Chủ nhật",
   "Thứ hai",
   "Thứ ba",
   "Thứ tư",
   "Thứ năm",
   "Thứ sáu",
   "Thứ bảy"
];

if(L5.MessageBox){
   L5.MessageBox.buttonText = {
      ok     : "Đồng ý",
      cancel : "Hủy bỏ",
      yes    : "Có",
      no     : "Không"
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
      todayText         : "Hôm nay",
      minText           : "Ngày này nhỏ hơn ngày nhỏ nhất",
      maxText           : "Ngày này lớn hơn ngày lớn nhất",
      disabledDaysText  : "",
      disabledDatesText : "",
      monthNames	: Date.monthNames,
      dayNames		: Date.dayNames,
      nextText          : 'Tháng sau (Control+Right)',
      prevText          : 'Tháng trước (Control+Left)',
      monthYearText     : 'Chọn một tháng (Control+Up/Down để thay đổi năm)',
      todayTip          : "{0} (Spacebar - Phím trắng)",
      format            : "d/m/y"
   });
}

if(L5.PagingToolbar){
   L5.apply(L5.PagingToolbar.prototype, {
      beforePageText : "Trang",
      afterPageText  : "of {0}",
      firstText      : "Trang đầu",
      prevText       : "Trang trước",
      nextText       : "Trang sau",
      lastText       : "Trang cuối",
      refreshText    : "Tải lại",
      displayMsg     : "Hiển thị {0} - {1} của {2}",
      emptyMsg       : 'Không có dữ liệu để hiển thị'
   });
}

if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "Chiều dài tối thiểu của ô này là {0}",
      maxLengthText : "Chiều dài tối đa của ô này là {0}",
      blankText     : "Ô này cần phải nhập giá trị",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "Giá trị nhỏ nhất của ô này là {0}",
      maxText : "Giá trị lớn nhất của ô này là  {0}",
      nanText : "{0} hông phải là một số hợp lệ"
   });
}

if(L5.form.DateField){
   L5.apply(L5.form.DateField.prototype, {
      disabledDaysText  : "Vô hiệu",
      disabledDatesText : "Vô hiệu",
      minText           : "Ngày nhập trong ô này phải sau ngày {0}",
      maxText           : "Ngày nhập trong ô này phải trước ngày {0}",
      invalidText       : "{0} không phải là một ngày hợp lệ - phải có dạng {1}",
      format            : "d/m/y"
   });
}

if(L5.form.ComboBox){
   L5.apply(L5.form.ComboBox.prototype, {
      loadingText       : "Đang tải...",
      valueNotFoundText : undefined
   });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'Giá trị của ô này phải là một địa chỉ email có dạng như "ten@abc.com"',
      urlText      : 'Giá trị của ô này phải là một địa chỉ web(URL) hợp lệ, có dạng như "http:/'+'/www.domain.com"',
      alphaText    : 'Ô này chỉ được nhập các kí tự và gạch dưới(_)',
      alphanumText : 'Ô này chỉ được nhập các kí tự, số và gạch dưới(_)'
   });
}

if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "Tăng dần",
      sortDescText : "Giảm dần",
      lockText     : "Khóa cột",
      unlockText   : "Bỏ khóa cột",
      columnsText  : "Các cột"
   });
}

if(L5.grid.PropertyColumnModel){
   L5.apply(L5.grid.PropertyColumnModel.prototype, {
      nameText   : "Tên",
      valueText  : "Giá trị",
      dateFormat : "j/m/Y"
   });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "Kéo giữ chuột để thay đổi kích thước.",
      collapsibleSplitTip : "Kéo giữ chuột để thay đổi kích thước. Nhấp đúp để ẩn đi."
   });
}
