/**
 * @class L5.menu.ColorItem
 * @extends L5.menu.Adapter
 * A menu item that wraps the {@link L5.ColorPalette} component.
 * @constructor
 * Creates a new ColorItem
 * @param {Object} config Configuration options
 */
L5.menu.ColorItem = function(config){
    L5.menu.ColorItem.superclass.constructor.call(this, new L5.ColorPalette(config), config);
    /** The L5.ColorPalette object @type L5.ColorPalette */
    this.palette = this.component;
    this.relayEvents(this.palette, ["select"]);
    if(this.selectHandler){
        this.on('select', this.selectHandler, this.scope);
    }
};
L5.extend(L5.menu.ColorItem, L5.menu.Adapter);