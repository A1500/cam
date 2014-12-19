

/**
 * Pedoman translasi:
 * http://id.wikisource.org/wiki/Panduan_Pembakuan_Istilah,_Pelaksanaan_Instruksi_Presiden_Nomor_2_Tahun_2001_Tentang_Penggunaan_Komputer_Dengan_Aplikasi_Komputer_Berbahasa_Indonesia
 *Original source: http://vlsm.org/etc/baku-0.txt
 * by Farid GS
 * farid [at] pulen.net
 * 10:13 04 Desember 2007
 * Indonesian Translations
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Pemuatan...</div>';

if(L5.View){
  L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
  L5.grid.GridPanel.prototype.ddText = "{0} selected row(s)";
  L5.grid.GridPanel.prototype.ddText = "{0} baris terpilih";
}

if(L5.TabPanelItem){
  L5.TabPanelItem.prototype.closeText = "Close this tab";
  L5.TabPanelItem.prototype.closeText = "Tutup tab ini";
}

if(L5.form.Field){
  L5.form.Field.prototype.invalidText = "The value in this field is invalid";
  L5.form.Field.prototype.invalidText = "Isian belum benar";
}

if(L5.LoadMask){
  L5.LoadMask.prototype.msg = "Loading...";
  L5.LoadMask.prototype.msg = "Pemuatan...";
}

Date.monthNames = [
  "Januari",
  "Februari",
  "Maret",
  "April",
  "Mei",
  "Juni",
  "Juli",
  "Agustus",
  "September",
  "Oktober",
  "November",
  "Desember"
];

Date.getShortMonthName = function(month) {
  return Date.monthNames[month].substring(0, 3);
};

Date.monthNumbers = {
  Jan : 0,
  Feb : 1,
  Mar : 2,
  Apr : 3,
  Mei : 4,
  Jun : 5,
  Jul : 6,
  Agu : 7,
  Sep : 8,
  Okt : 9,
  Nov : 10,
  Des : 11
};

Date.getMonthNumber = function(name) {
  return Date.monthNumbers[name.substring(0, 1).toUpperCase() + name.substring(1, 3).toLowerCase()];
};

Date.dayNames = [
  "Minggu",
  "Senin",
  "Selasa",
  "Rabu",
  "Kamis",
  "Jumat",
  "Sabtu"
];

Date.getShortDayName = function(day) {
  return Date.dayNames[day].substring(0, 3);
};

if(L5.MessageBox){
  L5.MessageBox.buttonText = {
    ok     : "OK",
    cancel : "Batal",
    yes    : "Ya",
    no     : "Tidak"
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
    todayText         : "Hari ini",
    minText           : "Tanggal ini sebelum batas tanggal minimal", 
    maxText           : "Tanggal ini setelah batas tanggal maksimal", 
    disabledDaysText  : "",
    disabledDatesText : "",
    monthNames        : Date.monthNames,
    dayNames          : Date.dayNames,
    nextText          : 'Bulan Berikut (Kontrol+Kanan)', 
    prevText          : 'Bulan Sebelum (Kontrol+Kiri)', 
    monthYearText     : 'Pilih bulan (Kontrol+Atas/Bawah untuk pindah tahun)', 
    todayTip          : "{0} (Spacebar)",
    format            : "d/m/y",
    okText            : "&#160;OK&#160;",
    cancelText        : "Batal",
    startDay          : 1
  });
}

if(L5.PagingToolbar){
  L5.apply(L5.PagingToolbar.prototype, {
    beforePageText : "Hal",
    afterPageText  : "dari {0}",
    firstText      : "Hal. Pertama",
    prevText       : "Hal. Sebelum",
    nextText       : "Hal. Berikut",
    lastText       : "Hal. Akhir",
    refreshText    : "Segarkan", 
    displayMsg     : "Menampilkan {0} - {1} dari {2}",
    emptyMsg       : 'Data tidak ditemukan' 
  });
}

if(L5.form.TextField){
  L5.apply(L5.form.TextField.prototype, {
    minLengthText : "Panjang minimal untuk field ini adalah {0}",  
    maxLengthText : "Panjang maksimal untuk field ini adalah {0}", 
    blankText     : "Field ini wajib diisi", 
    regexText     : "",
    emptyText     : null
  });
}

if(L5.form.NumberField){
  L5.apply(L5.form.NumberField.prototype, {
    minText : "Nilai minimal untuk field ini adalah {0}",  
    maxText : "Nilai maksimal untuk field ini adalah {0}",  
    nanText : "{0} bukan angka" 
  });
}

if(L5.form.DateField){
  L5.apply(L5.form.DateField.prototype, {
    disabledDaysText  : "Disfungsi",  
    disabledDatesText : "Disfungsi",  
    minText           : "Tanggal dalam field ini harus setelah {0}", 
    maxText           : "Tanggal dalam field ini harus sebelum {0}", 
    invalidText       : "{0} tanggal salah - Harus dalam format {1}", 
    format            : "d/m/y", 
    //altFormats        : "m/d/Y|m-d-y|m-d-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d"
    altFormats        : "d/m/Y|d-m-y|d-m-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d"
  });
}

if(L5.form.ComboBox){
  L5.apply(L5.form.ComboBox.prototype, {
    loadingText       : "Pemuatan...",  
    valueNotFoundText : undefined
  });
}

if(L5.form.VTypes){
  L5.apply(L5.form.VTypes, {
    emailText    : 'Field ini harus dalam format email seperti "user@domain.com"', 
    urlText      : 'Field ini harus dalam format URL seperti "http:/'+'/www.domain.com"', 
    alphaText    : 'Field ini harus terdiri dari huruf dan _', 
    alphanumText : 'Field ini haris terdiri dari huruf, angka dan _'  
  });
}

if(L5.form.HtmlEditor){
  L5.apply(L5.form.HtmlEditor.prototype, {
    createLinkText : 'Silakan masukkan URL untuk tautan:', 
    buttonTips : {
      bold : {
        title: 'Tebal (Ctrl+B)', 
        text: 'Buat tebal teks terpilih', 
        cls: 'x-html-editor-tip'
      },
      italic : {
        title: 'Miring (CTRL+I)', 
        text: 'Buat miring teks terpilih', 
        cls: 'x-html-editor-tip'
      },
      underline : {
        title: 'Garisbawah (CTRl+U)', 
        text: 'Garisbawahi teks terpilih', 
        cls: 'x-html-editor-tip'
      },
      increasefontsize : {
        title: 'Perbesar teks', 
        text: 'Perbesar ukuran fonta', 
        cls: 'x-html-editor-tip'
      },
      decreasefontsize : {
        title: 'Perkecil teks',  
        text: 'Perkecil ukuran fonta', 
        cls: 'x-html-editor-tip'
      },
      backcolor : {
        title: 'Sorot Warna Teks',  
        text: 'Ubah warna latar teks terpilih', 
        cls: 'x-html-editor-tip'
      },
      forecolor : {
        title: 'Warna Fonta', 
        text: 'Ubah warna teks terpilih',  
        cls: 'x-html-editor-tip'
      },
      justifyleft : {
        title: 'Rata Kiri', 
        text: 'Ratakan teks ke kiri', 
        cls: 'x-html-editor-tip'
      },
      justifycenter : {
        title: 'Rata Tengah', 
        text: 'Ratakan teks ke tengah editor', 
        cls: 'x-html-editor-tip'
      },
      justifyright : {
        title: 'Rata Kanan', 
        text: 'Ratakan teks ke kanan', 
        cls: 'x-html-editor-tip'
      },
      insertunorderedlist : {
        title: 'Daftar Bulet', 
        text: 'Membuat daftar berbasis bulet', 
        cls: 'x-html-editor-tip'
      },
      insertorderedlist : {
        title: 'Daftar Angka', 
        text: 'Membuat daftar berbasis angka', 
        cls: 'x-html-editor-tip'
      },
      createlink : {
        title: 'Hipertaut', 
        text: 'Buat teks terpilih sebagai Hipertaut', 
        cls: 'x-html-editor-tip'
      },
      sourceedit : {
        title: 'Edit Kode Sumber', 
        text: 'Pindah dalam mode kode sumber', 
        cls: 'x-html-editor-tip'
      }
    }
  });
}

if(L5.grid.GridView){
  L5.apply(L5.grid.GridView.prototype, {
    sortAscText  : "Urut Naik", 
    sortDescText : "Urut Turun", 
    lockText     : "Kancing Kolom", 
    unlockText   : "Lepas Kunci Kolom", 
    columnsText  : "Kolom"
  });
}

if(L5.grid.GroupingView){
  L5.apply(L5.grid.GroupingView.prototype, {
    emptyGroupText : '(Kosong)', 
    groupByText    : 'Kelompokkan Berdasar Field Ini', 
    showGroupsText : 'Tampil Dalam Kelompok' 
  });
}

if(L5.grid.PropertyColumnModel){
  L5.apply(L5.grid.PropertyColumnModel.prototype, {
    nameText   : "Nama", 
    valueText  : "Nilai", 
    dateFormat : "d/m/Y" 
  });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
  L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
    splitTip            : "Seret untuk ubah ukuran.", 
    collapsibleSplitTip : "Seret untuk ubah ukuran, Dobel klik untuk sembunyikan." 
  });
}
