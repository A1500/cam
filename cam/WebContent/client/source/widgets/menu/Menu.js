/**
 * @class L5.menu.Menu
 * @extends L5.util.Observable
 * A menu object.  This is the container to which you add all other menu items.  Menu can also serve as a base class
 * when you want a specialized menu based off of another component (like {@link L5.menu.DateMenu} for example).
 * @constructor
 * Creates a new Menu
 * @param {Object} config Configuration options
 */
L5.menu.Menu = function(config){
    if(L5.isArray(config)){
        config = {items:config};
    }
    L5.apply(this, config);
    this.id = this.id || L5.id();
    this.addEvents(
        /**
         * @event beforeshow
         * Fires before this menu is displayed
         * @param {L5.menu.Menu} this
         */
        'beforeshow',
        /**
         * @event beforehide
         * Fires before this menu is hidden
         * @param {L5.menu.Menu} this
         */
        'beforehide',
        /**
         * @event show
         * Fires after this menu is displayed
         * @param {L5.menu.Menu} this
         */
        'show',
        /**
         * @event hide
         * Fires after this menu is hidden
         * @param {L5.menu.Menu} this
         */
        'hide',
        /**
         * @event click
         * Fires when this menu is clicked (or when the enter key is pressed while it is active)
         * @param {L5.menu.Menu} this
         * @param {L5.menu.Item} menuItem The menu item that was clicked
         * @param {L5.EventObject} e
         */
        'click',
        /**
         * @event mouseover
         * Fires when the mouse is hovering over this menu
         * @param {L5.menu.Menu} this
         * @param {L5.EventObject} e
         * @param {L5.menu.Item} menuItem The menu item that was clicked
         */
        'mouseover',
        /**
         * @event mouseout
         * Fires when the mouse exits this menu
         * @param {L5.menu.Menu} this
         * @param {L5.EventObject} e
         * @param {L5.menu.Item} menuItem The menu item that was clicked
         */
        'mouseout',
        /**
         * @event itemclick
         * Fires when a menu item contained in this menu is clicked
         * @param {L5.menu.BaseItem} baseItem The BaseItem that was clicked
         * @param {L5.EventObject} e
         */
        'itemclick',
        /**
         * @event contextmenu
         * 右击事件处理
         * @param {L5.menu.Menu} this
         * @param {L5.menu.Item} menuItem The menu item that was clicked
         * @param {L5.EventObject} e
         */
        'contextmenu',
        /**
         * @event add
         * 增加item事件处理
         * @param {L5.menu.Menu} this
         * @param {L5.menu.Item} menuItem The menu item that was clicked
         * @param {L5.EventObject} e
         */
        'add',
        /**
         * @event remove
         * 移除item事件处理
         * @param {L5.menu.Menu} this
         * @param {L5.menu.Item} menuItem The menu item that was clicked
         * @param {L5.EventObject} e
         */
        'remove'
    );
    L5.menu.MenuMgr.register(this);
    L5.menu.Menu.superclass.constructor.call(this);
    var mis = this.items;
    /**
     * A MixedCollection of this Menu's items
     * @property items
     * @type L5.util.MixedCollection
     */
    this.items = new L5.util.MixedCollection();
    if(mis){
        this.add.apply(this, mis);
    }
};

L5.extend(L5.menu.Menu, L5.util.Observable, {
    /**
     * @cfg {Object} defaults
     * A config object that will be applied to all items added to this container either via the {@link #items}
     * config or via the {@link #add} method.  The defaults config can contain any number of
     * name/value property pairs to be added to each item, and should be valid for the types of items
     * being added to the menu.
     */
    /**
     * @cfg {Mixed} items
     * An array of items to be added to this menu.  See {@link #add} for a list of valid item types.
     */
    /**
     * @cfg {Number} minWidth The minimum width of the menu in pixels (defaults to 120)
     */
    minWidth : 120,
    /**
     * @cfg {Boolean/String} shadow True or "sides" for the default effect, "frame" for 4-way shadow, and "drop"
     * for bottom-right shadow (defaults to "sides")
     */
    shadow : "sides",
    /**
     * @cfg {String} subMenuAlign The {@link L5.Element#alignTo} anchor position value to use for submenus of
     * this menu (defaults to "tl-tr?")
     */
    subMenuAlign : "tl-tr?",
    /**
     * @cfg {String} defaultAlign The default {@link L5.Element#alignTo} anchor position value for this menu
     * relative to its element of origin (defaults to "tl-bl?")
     */
    defaultAlign : "tl-bl?",
    /**
     * @cfg {Boolean} allowOtherMenus True to allow multiple menus to be displayed at the same time (defaults to false)
     */
    allowOtherMenus : false,
    /**
     * @cfg {Boolean} ignoreParentClicks True to ignore clicks on any item in this menu that is a parent item (displays
     * a submenu) so that the submenu is not dismissed when clicking the parent item (defaults to false).
     */
    ignoreParentClicks : false,

    // private
    hidden:true,
    //默认不显示滚动条
    autoScroll : false,
    //如果现实滚动条，最多显示几个item？默认是5个，与autoScroll属性结合使用
    maxItemNum:5,

    // private
    createEl : function(){
        return new L5.Layer({
            cls: "l-menu",
            shadow:this.shadow,
            constrain: false,
            parentEl: this.parentEl || document.body,
            zindex:15000
        });
    },

    // private
    render : function(){
        if(this.el){
            return;
        }
        var el = this.el = this.createEl();

        if(!this.keyNav){
            this.keyNav = new L5.menu.MenuNav(this);
        }
        if(this.plain){
            el.addClass("l-menu-plain");
        }
        if(this.cls){
            el.addClass(this.cls);
        }
        // generic focus element
        this.focusEl = el.createChild({
            tag: "a", cls: "l-menu-focus", href: "#", onclick: "return false;", tabIndex:"-1"
        });
        var ul = el.createChild({tag: "ul", cls: "l-menu-list"});
        ul.on("contextmenu", this.contextmenu, this);
        ul.on("click", this.onClick, this);
        ul.on("mouseover", this.onMouseOver, this);
        ul.on("mouseout", this.onMouseOut, this);
        this.items.each(function(item){
            var li = document.createElement("li");
            li.className = "l-menu-list-item";
            ul.dom.appendChild(li);
            item.render(li, this);
        }, this);
        this.ul = ul;
        this.autoWidth();
        if(this.autoScroll){
        	if(this.items.length>this.maxItemNum){
        		this.ul.parent().dom.style.height = this.maxItemNum*23+"px";
        		this.ul.parent().dom.style.overflowY = "scroll";
        	}
        }
        this.on("add",this.setAutoScroll,this);
        this.on("remove",this.setAutoScroll,this);
    },
    setAutoScroll : function(){
    	 if(this.autoScroll){
         	if(this.items.length>this.maxItemNum){
         		this.ul.parent().dom.style.height = this.maxItemNum*23+"px";
         		this.ul.parent().dom.style.overflowY = "scroll";
         	}else{
         		this.ul.parent().dom.style.height = this.items.length*23+"px";
         		this.ul.parent().dom.style.overflowY = "hidden";
         	}
         }
    },
    // private
    autoWidth : function(){
        var el = this.el, ul = this.ul;
        if(!el){
            return;
        }
        var w = this.width;
        if(w){
            el.setWidth(w);
        }else if(L5.isIE){
            el.setWidth(this.minWidth);
            var t = el.dom.offsetWidth; // force recalc
            el.setWidth(ul.getWidth()+el.getFrameWidth("lr"));
        }
    },

    // private
    delayAutoWidth : function(){
        if(this.el){
            if(!this.awTask){
                this.awTask = new L5.util.DelayedTask(this.autoWidth, this);
            }
            this.awTask.delay(20);
        }
    },

    // private
    findTargetItem : function(e){
        var t = e.getTarget(".l-menu-list-item", this.ul,  true);
        if(t && t.menuItemId){
            return this.items.get(t.menuItemId);
        }
    },

    // private
    onClick : function(e){
        var t;
        if(t = this.findTargetItem(e)){
            if(t.menu && this.ignoreParentClicks){
                t.expandMenu();
            }else{
                t.onClick(e);
                this.fireEvent("click", this, t, e);
            }
        }
    },
    
    //private
    nocontextmenu : function(e) {
		if (document.all)
			window.event.returnValue = false;// for IE
		else
			e.preventDefault();//firefox
		return false;
	},
	
    // private
    contextmenu : function(e){
    	if (window.Event)
    	   e=window.Event || e;
        document.oncontextmenu = this.nocontextmenu;  
    },
    
    // private
    setActiveItem : function(item, autoExpand){
        if(item != this.activeItem){
            if(this.activeItem){
                this.activeItem.deactivate();
            }
            this.activeItem = item;
            item.activate(autoExpand);
        }else if(autoExpand){
            item.expandMenu();
        }
    },

    // private
    tryActivate : function(start, step){
        var items = this.items;
        for(var i = start, len = items.length; i >= 0 && i < len; i+= step){
            var item = items.get(i);
            if(!item.disabled && item.canActivate){
                this.setActiveItem(item, false);
                return item;
            }
        }
        return false;
    },

    // private
    onMouseOver : function(e){
        var t;
        if(t = this.findTargetItem(e)){
            if(t.canActivate && !t.disabled){
                this.setActiveItem(t, true);
            }
        }
        this.over = true;
        this.fireEvent("mouseover", this, e, t);
    },

    // private
    onMouseOut : function(e){
        var t;
        if(t = this.findTargetItem(e)){
            if(t == this.activeItem && t.shouldDeactivate(e)){
                this.activeItem.deactivate();
                delete this.activeItem;
            }
        }
        this.over = false;
        this.fireEvent("mouseout", this, e, t);
    },

    /**
     * Read-only.  Returns true if the menu is currently displayed, else false.
     * @type Boolean
     */
    isVisible : function(){
        return this.el && !this.hidden;
    },

    /**
     * Displays this menu relative to another element
     * @param {Mixed} element The element to align to
     * @param {String} position (optional) The {@link L5.Element#alignTo} anchor position to use in aligning to
     * the element (defaults to this.defaultAlign)
     * @param {L5.menu.Menu} parentMenu (optional) This menu's parent menu, if applicable (defaults to undefined)
     */
    show : function(el, pos, parentMenu){
        this.parentMenu = parentMenu;
        if(!this.el){
            this.render();
        }
        this.fireEvent("beforeshow", this);
        this.showAt(this.el.getAlignToXY(el, pos || this.defaultAlign), parentMenu, false);
    },

    /**
     * Displays this menu at a specific xy position
     * @param {Array} xyPosition Contains X & Y [x, y] values for the position at which to show the menu (coordinates are page-based)
     * @param {L5.menu.Menu} parentMenu (optional) This menu's parent menu, if applicable (defaults to undefined)
     */
    showAt : function(xy, parentMenu, /* private: */_e){
        this.parentMenu = parentMenu;
        if(!this.el){
            this.render();
        }
        if(_e !== false){
            this.fireEvent("beforeshow", this);
            xy = this.el.adjustForConstraints(xy);
        }
        this.el.setXY(xy);
        this.el.show();
        this.hidden = false;
        this.focus();
        this.fireEvent("show", this);
    },



    focus : function(){
        if(!this.hidden){
            this.doFocus.defer(50, this);
        }
    },

    doFocus : function(){
        if(!this.hidden){
            this.focusEl.focus();
        }
    },

    /**
     * Hides this menu and optionally all parent menus
     * @param {Boolean} deep (optional) True to hide all parent menus recursively, if any (defaults to false)
     */
    hide : function(deep){
        if(this.el && this.isVisible()){
            this.fireEvent("beforehide", this);
            if(this.activeItem){
                this.activeItem.deactivate();
                this.activeItem = null;
            }
            this.el.hide();
            this.hidden = true;
            this.fireEvent("hide", this);
        }
        if(deep === true && this.parentMenu){
            this.parentMenu.hide(true);
        }
    },

    /**
     * Adds one or more items of any type supported by the Menu class, or that can be converted into menu items.
     * Any of the following are valid:
     * <ul>
     * <li>Any menu item object based on {@link L5.menu.BaseItem}</li>
     * <li>An HTMLElement object which will be converted to a menu item</li>
     * <li>A menu item config object that will be created as a new menu item</li>
     * <li>A string, which can either be '-' or 'separator' to add a menu separator, otherwise
     * it will be converted into a {@link L5.menu.TextItem} and added</li>
     * </ul>
     * Usage:
     * <pre><code>
// Create the menu
var menu = new L5.menu.Menu();

// Create a menu item to add by reference
var menuItem = new L5.menu.Item({ text: 'New Item!' });

// Add a bunch of items at once using different methods.
// Only the last item added will be returned.
var item = menu.add(
    menuItem,                // add existing item by ref
    'Dynamic Item',          // new TextItem
    '-',                     // new separator
    { text: 'Config Item' }  // new item by config
);
</code></pre>
     * @param {Mixed} args One or more menu items, menu item configs or other objects that can be converted to menu items
     * @return {L5.menu.Item} The menu item that was added, or the last one if multiple items were added
     */
    add : function(){
        var a = arguments, l = a.length, item;
        for(var i = 0; i < l; i++){
            var el = a[i];
            if(el.render){ // some kind of Item
                item = this.addItem(el);
            }else if(typeof el == "string"){ // string
                if(el == "separator" || el == "-"){
                    item = this.addSeparator();
                }else{
                    item = this.addText(el);
                }
            }else if(el.tagName || el.el){ // element
                item = this.addElement(el);
            }else if(typeof el == "object"){ // must be menu item config?
                L5.applyIf(el, this.defaults);
                item = this.addMenuItem(el);
            }
        }
        return item;
    },

    /**
     * Returns this menu's underlying {@link L5.Element} object
     * @return {L5.Element} The element
     */
    getEl : function(){
        if(!this.el){
            this.render();
        }
        return this.el;
    },

    /**
     * Adds a separator bar to the menu
     * @return {L5.menu.Item} The menu item that was added
     */
    addSeparator : function(){
        return this.addItem(new L5.menu.Separator());
    },

    /**
     * Adds an {@link L5.Element} object to the menu
     * @param {Mixed} el The element or DOM node to add, or its id
     * @return {L5.menu.Item} The menu item that was added
     */
    addElement : function(el){
        return this.addItem(new L5.menu.BaseItem(el));
    },

    /**
     * Adds an existing object based on {@link L5.menu.BaseItem} to the menu
     * @param {L5.menu.Item} item The menu item to add
     * @return {L5.menu.Item} The menu item that was added
     */
    addItem : function(item){
        this.items.add(item);
        if(this.ul){
            var li = document.createElement("li");
            li.className = "l-menu-list-item";
            this.ul.dom.appendChild(li);
            item.render(li, this);
            this.delayAutoWidth();
        }
        this.fireEvent("add",this,item);
        return item;
    },

    /**
     * Creates a new {@link L5.menu.Item} based an the supplied config object and adds it to the menu
     * @param {Object} config A MenuItem config object
     * @return {L5.menu.Item} The menu item that was added
     */
    addMenuItem : function(config){
        if(!(config instanceof L5.menu.Item)){
            if(typeof config.checked == "boolean"){ // must be check menu item config?
                config = new L5.menu.CheckItem(config);
            }else{
                config = new L5.menu.Item(config);
            }
        }
        return this.addItem(config);
    },

    /**
     * Creates a new {@link L5.menu.TextItem} with the supplied text and adds it to the menu
     * @param {String} text The text to display in the menu item
     * @return {L5.menu.Item} The menu item that was added
     */
    addText : function(text){
        return this.addItem(new L5.menu.TextItem(text));
    },

    /**
     * Inserts an existing object based on {@link L5.menu.BaseItem} to the menu at a specified index
     * @param {Number} index The index in the menu's list of current items where the new item should be inserted
     * @param {L5.menu.Item} item The menu item to add
     * @return {L5.menu.Item} The menu item that was added
     */
    insert : function(index, item){
        this.items.insert(index, item);
        if(this.ul){
            var li = document.createElement("li");
            li.className = "l-menu-list-item";
            this.ul.dom.insertBefore(li, this.ul.dom.childNodes[index]);
            item.render(li, this);
            this.delayAutoWidth();
        }
        this.fireEvent("add",this,item,index);//这里触发add事件
        return item;
    },

    /**
     * Removes an {@link L5.menu.Item} from the menu and destroys the object
     * @param {L5.menu.Item} item The menu item to remove
     */
    remove : function(item){
        this.items.removeKey(item.id);
        item.destroy();
        this.fireEvent("remove",this,item);//这里触发add事件
    },

    /**
     * Removes and destroys all items in the menu
     */
    removeAll : function(){
    	if(this.items){
	        var f;
	        while(f = this.items.first()){
	            this.remove(f);
	        }
    	}
    },

    /**
     * Destroys the menu by  unregistering it from {@link L5.menu.MenuMgr}, purging event listeners,
     * removing all of the menus items, then destroying the underlying {@link L5.Element}
     */
    destroy : function(){
        this.beforeDestroy();
        L5.menu.MenuMgr.unregister(this);
        if (this.keyNav) {
        	this.keyNav.disable();
        }
        this.removeAll();
        if (this.ul) {
        	this.ul.removeAllListeners();
        }
        if (this.el) {
        	this.el.destroy();
        }
    },

	// private
    beforeDestroy : L5.emptyFn

});

// MenuNav is a private utility class used internally by the Menu
L5.menu.MenuNav = function(menu){
    L5.menu.MenuNav.superclass.constructor.call(this, menu.el);
    this.scope = this.menu = menu;
};

L5.extend(L5.menu.MenuNav, L5.KeyNav, {
    doRelay : function(e, h){
        var k = e.getKey();
        if(!this.menu.activeItem && e.isNavKeyPress() && k != e.SPACE && k != e.RETURN){
            this.menu.tryActivate(0, 1);
            return false;
        }
        return h.call(this.scope || this, e, this.menu);
    },

    up : function(e, m){
        if(!m.tryActivate(m.items.indexOf(m.activeItem)-1, -1)){
            m.tryActivate(m.items.length-1, -1);
        }
    },

    down : function(e, m){
        if(!m.tryActivate(m.items.indexOf(m.activeItem)+1, 1)){
            m.tryActivate(0, 1);
        }
    },

    right : function(e, m){
        if(m.activeItem){
            m.activeItem.expandMenu(true);
        }
    },

    left : function(e, m){
        m.hide();
        if(m.parentMenu && m.parentMenu.activeItem){
            m.parentMenu.activeItem.activate();
        }
    },

    enter : function(e, m){
        if(m.activeItem){
            e.stopPropagation();
            m.activeItem.onClick(e);
            m.fireEvent("click", this, m.activeItem);
            return true;
        }
    }
});