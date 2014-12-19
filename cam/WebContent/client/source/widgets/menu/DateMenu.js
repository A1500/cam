/**
 * @class L5.menu.DateMenu
 * @extends L5.menu.Menu
 * A menu containing a {@link L5.menu.DateItem} component (which provides a date picker).
 * @constructor
 * Creates a new DateMenu
 * @param {Object} config Configuration options
 */
L5.menu.DateMenu = function(config){
    L5.menu.DateMenu.superclass.constructor.call(this, config);
    this.plain = true;
    var di = new L5.menu.DateItem(config);
    this.add(di);
    /**
     * The {@link L5.DatePicker} instance for this DateMenu
     * @type DatePicker
     */
    this.picker = di.picker;
    /**
     * @event select
     * @param {DatePicker} picker
     * @param {Date} date
     */
    this.relayEvents(di, ["select"]);

    this.on('beforeshow', function(){
        if(this.picker){
            this.picker.hideMonthPicker(true);
        }
    }, this);
};
L5.extend(L5.menu.DateMenu, L5.menu.Menu, {
    cls:'l-date-menu',

    // private
    beforeDestroy : function() {
        this.picker.destroy();
    }
});