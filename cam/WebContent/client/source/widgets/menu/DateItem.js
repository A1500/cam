/**
 * @class L5.menu.DateItem
 * @extends L5.menu.Adapter
 * A menu item that wraps the {@link L5.DatePicker} component.
 * @constructor
 * Creates a new DateItem
 * @param {Object} config Configuration options
 */
L5.menu.DateItem = function(config){
    L5.menu.DateItem.superclass.constructor.call(this, new L5.DatePicker(config), config);
    /** The L5.DatePicker object @type L5.DatePicker */
    this.picker = this.component;
    this.addEvents('select');
    
    this.picker.on("render", function(picker){
        picker.getEl().swallowEvent("click");
        picker.container.addClass("l-menu-date-item");
    });

    this.picker.on("select", this.onSelect, this);
};

L5.extend(L5.menu.DateItem, L5.menu.Adapter, {
    // private
    onSelect : function(picker, date){
        this.fireEvent("select", this, date, picker);
        L5.menu.DateItem.superclass.handleClick.call(this);
    }
});