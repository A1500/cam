

/*
 * France (Canadian) translation
 * By BernardChhun
 * 04-08-2007, 03:07 AM
 */

L5.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">En cours de chargement...</div>';

if(L5.View){
   L5.View.prototype.emptyText = "";
}

if(L5.grid.GridPanel){
   L5.grid.GridPanel.prototype.ddText = "{0} ligne(s) sélectionné(s)";
}

if(L5.TabPanelItem){
   L5.TabPanelItem.prototype.closeText = "Fermer cette onglet";
}

if(L5.form.Field){
   L5.form.Field.prototype.invalidText = "La valeur de ce champ est invalide";
}

if(L5.LoadMask){
    L5.LoadMask.prototype.msg = "En cours de chargement...";
}

Date.shortMonthNames = [
   "Janv",
   "Févr",
   "Mars",
   "Avr",
   "Mai",
   "Juin",
   "Juil",
   "Août",
   "Sept",
   "Oct",
   "Nov",
   "Déc"
];

Date.getShortMonthName = function(month) {
  return Date.shortMonthNames[month];
};

Date.monthNames = [
   "Janvier",
   "Février",
   "Mars",
   "Avril",
   "Mai",
   "Juin",
   "Juillet",
   "Août",
   "Septembre",
   "Octobre",
   "Novembre",
   "Décembre"
];

Date.monthNumbers = {
  "Janvier" : 0,
  "Février" : 1,
  "Mars" : 2,
  "Avril" : 3,
  "Mai" : 4,
  "Juin" : 5,
  "Juillet" : 6,
  "Août" : 7,
  "Septembre" : 8,
  "Octobre" : 9,
  "Novembre" : 10,
  "Décembre" : 11
};

Date.getMonthNumber = function(name) {
  return Date.monthNumbers[L5.util.Format.capitalize(name)];
};

Date.dayNames = [
   "Dimanche",
   "Lundi",
   "Mardi",
   "Mercredi",
   "Jeudi",
   "Vendredi",
   "Samedi"
];

Date.getShortDayName = function(day) {
  return Date.dayNames[day].substring(0, 3);
};

if(L5.MessageBox){
   L5.MessageBox.buttonText = {
      ok     : "OK",
      cancel : "Annuler",
      yes    : "Oui",
      no     : "Non"
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
      todayText         : "Aujourd'hui",
      minText           : "Cette date est plus petite que la date minimum",
      maxText           : "Cette date est plus grande que la date maximum",
      disabledDaysText  : "",
      disabledDatesText : "",
      monthNames	: Date.monthNames,
      dayNames		: Date.dayNames,
      nextText          : 'Prochain mois (CTRL+Fléche droite)',
      prevText          : 'Mois précédent (CTRL+Fléche gauche)',
      monthYearText     : 'Choissisez un mois (CTRL+Fléche haut ou bas pour changer d\'année.)',
      todayTip          : "{0} (Barre d'espace)",
      format            : "d/m/y"
   });
}

if(L5.PagingToolbar){
   L5.apply(L5.PagingToolbar.prototype, {
      beforePageText : "Page",
      afterPageText  : "de {0}",
      firstText      : "Première page",
      prevText       : "Page précédente",
      nextText       : "Prochaine page",
      lastText       : "Dernière page",
      refreshText    : "Recharger la page",
      displayMsg     : "Page courante {0} - {1} de {2}",
      emptyMsg       : 'Aucune donnée à afficher'
   });
}

if(L5.form.TextField){
   L5.apply(L5.form.TextField.prototype, {
      minLengthText : "La longueur minimum de ce champ est de {0} caractères",
      maxLengthText : "La longueur maximum de ce champ est de {0} caractères",
      blankText     : "Ce champ est obligatoire",
      regexText     : "",
      emptyText     : null
   });
}

if(L5.form.NumberField){
   L5.apply(L5.form.NumberField.prototype, {
      minText : "La valeur minimum de ce champ doit être de {0}",
      maxText : "La valeur maximum de ce champ doit être de {0}",
      nanText : "{0} n'est pas un nombre valide"
   });
}

if(L5.form.DateField){
   L5.apply(L5.form.DateField.prototype, {
      disabledDaysText  : "Désactivé",
      disabledDatesText : "Désactivé",
      minText           : "La date de ce champ doit être avant le {0}",
      maxText           : "La date de ce champ doit être après le {0}",
      invalidText       : "{0} n'est pas une date valide - il doit être au format suivant: {1}",
      format            : "d/m/y"
   });
}

if(L5.form.ComboBox){
   L5.apply(L5.form.ComboBox.prototype, {
      loadingText       : "En cours de chargement...",
      valueNotFoundText : undefined
   });
}

if(L5.form.VTypes){
   L5.apply(L5.form.VTypes, {
      emailText    : 'Ce champ doit contenir un courriel et doit être sous ce format: "usager@domaine.com"',
      urlText      : 'Ce champ doit contenir une URL sous le format suivant: "http:/'+'/www.domaine.com"',
      alphaText    : 'Ce champ ne peut contenir que des lettres et le caractère souligné (_)',
      alphanumText : 'Ce champ ne peut contenir que des caractères alphanumériques ainsi que le caractère souligné (_)'
   });
}

if(L5.grid.GridView){
   L5.apply(L5.grid.GridView.prototype, {
      sortAscText  : "Tri ascendant",
      sortDescText : "Tri descendant",
      lockText     : "Verrouillé la colonne",
      unlockText   : "Déverrouillé la colonne",
      columnsText  : "Colonnes"
   });
}

if(L5.grid.PropertyColumnModel){
   L5.apply(L5.grid.PropertyColumnModel.prototype, {
      nameText   : "Propriété",
      valueText  : "Valeur",
      dateFormat : "d/m/Y"
   });
}

if(L5.layout.BorderLayout && L5.layout.BorderLayout.SplitRegion){
   L5.apply(L5.layout.BorderLayout.SplitRegion.prototype, {
      splitTip            : "Cliquer et glisser pour redimensionner le panneau.",
      collapsibleSplitTip : "Cliquer et glisser pour redimensionner le panneau. Double-cliquer pour cacher le panneau."
   });
}
