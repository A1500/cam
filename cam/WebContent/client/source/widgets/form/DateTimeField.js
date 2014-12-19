/**
 * @class L5.form.DateField
 * @extends L5.form.DateField
* Create a new DateTimeField
* @param {Object} config
 */

L5.form.DateTimeField = L5.extend(L5.form.DateField, {
	
	format : 'Y-m-d H:i',
	
	defaultAutoCreate : {
		tag : "input",
		type : "text",
		size : "20",
		autocomplete : "off"
	},
	
	initComponent : function() {
		L5.form.DateTimeField.superclass.initComponent.call(this);
		this.afterMethod('afterRender', function() {
			this.getEl().applyStyles('top:0');
		});
	},
	
	getValue : function() {
		return this.parseDate(L5.form.DateField.superclass.getValue.call(this)) || '';
	},
	
	onTriggerClick : function() {
		if (this.disabled) {
			return;
		}
		if (this.menu == null) {
			this.menu = new L5.menu.DatetimeMenu();
		}
		L5.apply(this.menu.picker, {
			minDate : this.minValue,
			maxDate : this.maxValue,
			disabledDatesRE : this.ddMatch,
			disabledDatesText : this.disabledDatesText,
			disabledDays : this.disabledDays,
			disabledDaysText : this.disabledDaysText,
			format : this.format,
			showToday : this.showToday,
			minText : String.format(this.minText, this
							.formatDate(this.minValue)),
			maxText : String.format(this.maxText, this
							.formatDate(this.maxValue))
		});
		this.menu.on(L5.apply({}, this.menuListeners, {scope : this}));
		this.menu.picker.setValue(this.getValue() || new Date());
		this.menu.show(this.el, "tl-bl?");
	}
});

L5.reg('datetimefield', L5.form.DateTimeField);