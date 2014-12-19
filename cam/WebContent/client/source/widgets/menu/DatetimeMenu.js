/** Class Name: DatetimeMenu
 * Inherits From: L5.menu.Menu
 * Contains: DatetimeItem
 * Purpose: Effectively overrides L5.menu.DateMenu so that it contains DatetimeItem instead of L5.menu.DateItem
 * Note: ORIGINAL and NEW comments are used to denote what differs from L5.menu.DateMenu
 */
L5.menu.DatetimeMenu = function(config){
	// ORIGINAL:
	//L5.menu.DateMenu.superclass.constructor.call(this, config);
	//this.plain = true;
	//var di = new L5.menu.DateItem(config);
	// NEW:
	L5.menu.DatetimeMenu.superclass.constructor.call(this, config);
	this.plain = true;
	var di = new L5.menu.DatetimeItem(config);
	// END NEW
	this.add(di);
	this.picker = di.picker;
	this.relayEvents(di, ["select"]);
};
L5.extend(L5.menu.DatetimeMenu, L5.menu.Menu,{
	cls:'l-date-menu'
});