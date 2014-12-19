/* L5 Core translations */
L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">Besig om te laai...</div>';

/* L5 single string translations */
if(L5.View){
    L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
    L5.grid.GridPanel.prototype.ddText = "{0} geselekteerde ry(e)";
}

if(L5.TabPanelItem){
    L5.TabPanelItem.prototype.closeText = "Maak die oortjie toe";
}

if(L5.form.Field){
    L5.form.Field.prototype.invalidText = "Die waarde in hierdie veld is foutief";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "Besig om te laai...";
}

/* Javascript month and days translations */
Date.monthNames = [
   "Januarie",
   "Februarie",
   "Maart",
   "April",
   "Mei",
   "Junie",
   "Julie",
   "Augustus",
   "September",
   "Oktober",
   "November",
   "Desember"
];

Date.dayNames = [
   "Sondag",
   "Maandag",
   "Dinsdag",
   "Woensdag",
   "Donderdag",
   "Vrydag",
   "Saterdag"
];

/* L5 components translations */
if(L5.MessageBox){
    L5.MessageBox.buttonText = {
       ok     : "OK",
       cancel : "Kanselleer",
       yes    : "Ja",
       no     : "Nee"
    };
}

if(L5.util.Format){
    L5.util.Format.date = function(v, format){
       if(!v) return "";
       if(!(v instanceof Date)) v = new Date(Date.parse(v));
       return v.dateFormat(format || "d-m-y");
    };
}

if(L5.DatePicker){
    L5.apply(L5.DatePicker.prototype, {
       todayText         : "Vandag",
       minText           : "Hierdie datum is vroër as die minimum datum",
       maxText           : "Hierdie dataum is later as die maximum datum",
       disabledDaysText  : "",
       disabledDatesText : "",
       monthNames	 : Date.monthNames,
       dayNames		 : Date.dayNames,
       nextText          : 'Volgende Maand (Beheer+Regs)',
       prevText          : 'Vorige Maand (Beheer+Links)',
       monthYearText     : "Kies 'n maand (Beheer+Op/Af volgende/vorige jaar)",
       todayTip          : "{0} (Spasie)",
       format            : "d-m-y",
       startDay          : 0
    });
}

if(L5.PagingToolbar){
    L5.apply(L5.PagingToolbar.prototype, {
       beforePageText : "Bladsy",
       afterPageText  : "van {0}",
       firstText      : "Eerste Bladsy",
       prevText       : "Vorige Bladsy",
       nextText       : "Volgende Bladsy",
       lastText       : "Laatste Bladsy",
       refreshText    : "Verfris",
       displayMsg     : "Wys {0} - {1} van {2}",
       emptyMsg       : 'Geen data om te wys nie'
    });
}

if(L5.form.TextField){
    L5.apply(L5.form.TextField.prototype, {
       minLengthText : "Die minimum lengte van die veld is {0}",
       maxLengthText : "Die maximum lengte van die veld is {0}",
       blankText     : "Die veld is verpligtend",
       regexText     : "",
       emptyText     : null
    });
}

if(L5.form.NumberField){
    L5.apply(L5.form.NumberField.prototype, {
       minText : "Die minimum waarde vir die veld is {0}",
       maxText : "Die maximum waarde vir die veld is {0}",
       nanText : "{0} is nie 'n geldige waarde nie"
    });
}

if(L5.form.DateField){
    L5.apply(L5.form.DateField.prototype, {
       disabledDaysText  : "Afgeskakel",
       disabledDatesText : "Afgeskakel",
       minText           : "Die datum in hierdie veld moet na {0} wees",
       maxText           : "Die datum in hierdie veld moet voor {0} wees",
       invalidText       : "{0} is nie 'n geldige datum nie - datumformaat is {1}",
       format            : "d/m/y",
       altFormats        : "d/m/Y|d-m-y|d-m-Y|d/m|d-m|dm|dmy|dmY|d|Y-m-d"
    });
}

if(L5.form.ComboBox){
    L5.apply(L5.form.ComboBox.prototype, {
       loadingText       : "Besig om te laai...",
       valueNotFoundText : undefined
    });
}

if(L5.form.VTypes){
    L5.apply(L5.form.VTypes, {
       emailText    : "Hierdie veld moet 'n e-pos adres wees met die formaat 'gebruiker@domein.za'",
       urlText      : "Hierdie veld moet 'n URL wees me die formaat 'http:/'+'/www.domein.za'",
       alphaText    : 'Die veld mag alleenlik letters en _ bevat',
       alphanumText : 'Die veld mag alleenlik letters, syfers en _ bevat'
    });
}

if(L5.grid.GridView){
    L5.apply(L5.grid.GridView.prototype, {
       sortAscText  : "Sorteer Oplopend",
       sortDescText : "Sorteer Aflopend",
       lockText     : "Vries Kolom",
       unlockText   : "Ontvries Kolom",
       columnsText  : "Kolomme"
    });
}

if(L5.grid.PropertyColumnModel){
    L5.apply(L5.grid.PropertyColumnModel.prototype, {
       nameText   : "Naam",
       valueText  : "Waarde",
       dateFormat : "Y-m-j"
    });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
    L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
       splitTip            : "Trek om grootte aan te pas.",
       collapsibleSplitTip : "Trek om grootte aan te pas. Dubbel-klik om weg te steek."
    });
}