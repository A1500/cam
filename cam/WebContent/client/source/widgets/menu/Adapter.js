/**
 * @class L5.menu.Adapter
 * @extends L5.menu.BaseItem
 * A base utility class that adapts a non-menu component so that it can be wrapped by a menu item and added to a menu.
 * It provides basic rendering, activation management and enable/disable logic required to work in menus.
 * @constructor
 * Creates a new Adapter
 * @param {L5.Component} component The component being adapted to render into a menu
 * @param {Object} config Configuration options
 */
L5.menu.Adapter = function(component, config){
    L5.menu.Adapter.superclass.constructor.call(this, config);
    this.component = component;
};
L5.extend(L5.menu.Adapter, L5.menu.BaseItem, {
    // private
    canActivate : true,

    // private
    onRender : function(container, position){
        this.component.render(container);
        this.el = this.component.getEl();
    },

    // private
    activate : function(){
        if(this.disabled){
            return false;
        }
        this.component.focus();
        this.fireEvent("activate", this);
        return true;
    },

    // private
    deactivate : function(){
        this.fireEvent("deactivate", this);
    },

    // private
    disable : function(){
        this.component.disable();
        L5.menu.Adapter.superclass.disable.call(this);
    },

    // private
    enable : function(){
        this.component.enable();
        L5.menu.Adapter.superclass.enable.call(this);
    }
});