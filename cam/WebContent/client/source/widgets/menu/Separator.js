/**
 * @class L5.menu.Separator
 * @extends L5.menu.BaseItem
 * Adds a separator bar to a menu, used to divide logical groups of menu items. Generally you will
 * add one of these by using "-" in you call to add() or in your items config rather than creating one directly.
 * @constructor
 * @param {Object} config Configuration options
 */
L5.menu.Separator = function(config){
    L5.menu.Separator.superclass.constructor.call(this, config);
};

L5.extend(L5.menu.Separator, L5.menu.BaseItem, {
    /**
     * @cfg {String} itemCls The default CSS class to use for separators (defaults to "l-menu-sep")
     */
    itemCls : "l-menu-sep",
    /**
     * @cfg {Boolean} hideOnClick True to hide the containing menu after this item is clicked (defaults to false)
     */
    hideOnClick : false,

    // private
    onRender : function(li){
        var s = document.createElement("span");
        s.className = this.itemCls;
        s.innerHTML = "&#160;";
        this.el = s;
        li.addClass("l-menu-sep-li");
        L5.menu.Separator.superclass.onRender.apply(this, arguments);
    }
});