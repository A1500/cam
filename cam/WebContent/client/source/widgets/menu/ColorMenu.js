/**
 * @class L5.menu.ColorMenu
 * @extends L5.menu.Menu
 * A menu containing a {@link L5.menu.ColorItem} component (which provides a basic color picker).
 * @constructor
 * Creates a new ColorMenu
 * @param {Object} config Configuration options
 */
L5.menu.ColorMenu = function(config){
    L5.menu.ColorMenu.superclass.constructor.call(this, config);
    this.plain = true;
    var ci = new L5.menu.ColorItem(config);
    this.add(ci);
    /**
     * The {@link L5.ColorPalette} instance for this ColorMenu
     * @type ColorPalette
     */
    this.palette = ci.palette;
    /**
     * @event select
     * @param {ColorPalette} palette
     * @param {String} color
     */
    this.relayEvents(ci, ["select"]);
};
L5.extend(L5.menu.ColorMenu, L5.menu.Menu, {
    //private
    beforeDestroy: function(){
        this.palette.destroy();
    }
});