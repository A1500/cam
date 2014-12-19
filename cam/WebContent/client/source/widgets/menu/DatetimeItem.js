/** Class Name: DatetimeItem
 * Inherits From: L5.menu.Adapter
 * Contains: DatetimePicker
 * Purpose: Effectively overrides L5.menu.DateItem so that it contains DatetimePicker instead of L5.DatePicker
 * Note: ORIGINAL and NEW comments are used to denote what differs from L5.menu.DateItem
 */
L5.menu.DatetimeItem = function(config){
	// ORIGINAL:
	//L5.menu.DateItem.superclass.constructor.call(this, new L5.DatePicker(config), config);
	// NEW:
	L5.menu.DatetimeItem.superclass.constructor.call(this, new L5.DatetimePicker(config), config);
	// END NEW
	this.picker = this.component;
	this.addEvents({select: true});

	this.picker.on("render", function(picker){
		picker.getEl().swallowEvent("click");
		picker.container.addClass("l-menu-date-item");
	});

	this.picker.on("select", this.onSelect, this);
};

L5.extend(L5.menu.DatetimeItem, L5.menu.Adapter, {
	onSelect : function(picker, date){
		this.fireEvent("select", this, date, picker);
		// ORIGINAL:
		//L5.menu.DateItem.superclass.handleClick.call(this);
		// NEW:
		L5.menu.DatetimeItem.superclass.handleClick.call(this);
		// END NEW
	}
});