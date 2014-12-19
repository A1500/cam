/**
 * @class L5.Component
 * @extends L5.util.Observable
 * 所有组件的父类.  子组件会遵循L5组件的生命周期：创建，渲染，销毁。子组件也会继承隐藏/显示，禁用/启用等功能。组件可以渲染到
 * 任何的 L5.Container 容器中，并且自动注册到L5.ComponentMgr，可以通过L5.getCmp获取到该组件。每个可见的容器组件需要一种
 * 布局(layout)(有一些例外情况：没有指定布局同时也没子组件的没有layout，grid没有，等)。所有的组件都有特定的xtype。
 * @constructor
 * @param {Object} config 配置参数。如果参数是Element，将被设置为组件的内部元素，同时也将Element的ID作为组件的ID；如果参数
 * 										  是字符串，将被当作组件的ID；否则，它被当作一个标准的配置对象，并应用到组件。
 */
//xtype            Class
//-------------    ------------------
//box              L5.BoxComponent
//button           L5.Button
//colorpalette     L5.ColorPalette
//component        L5.Component
//container        L5.Container
//cycle            L5.CycleButton
//dataview         L5.DataView
//datepicker       L5.DatePicker
//editor           L5.Editor
//editorgrid       L5.grid.EditorGridPanel
//grid             L5.grid.GridPanel
//paging           L5.PagingToolbar
//panel            L5.Panel
//progress         L5.ProgressBar
//propertygrid     L5.grid.PropertyGrid
//slider           L5.Slider
//splitbutton      L5.SplitButton
//statusbar        L5.StatusBar
//tabpanel         L5.TabPanel
//treepanel        L5.tree.TreePanel
//viewport         L5.Viewport
//window           L5.Window
//
//Toolbar components
//---------------------------------------
//toolbar          L5.Toolbar
//tbbutton         L5.Toolbar.Button
//tbfill           L5.Toolbar.Fill
//tbitem           L5.Toolbar.Item
//tbseparator      L5.Toolbar.Separator
//tbspacer         L5.Toolbar.Spacer
//tbsplit          L5.Toolbar.SplitButton
//tbtext           L5.Toolbar.TextItem
//
//Form components
//---------------------------------------
//form             L5.FormPanel
//checkbox         L5.form.Checkbox
//combo            L5.form.ComboBox
//datefield        L5.form.DateField
//field            L5.form.Field
//fieldset         L5.form.FieldSet
//hidden           L5.form.Hidden
//htmleditor       L5.form.HtmlEditor
//label            L5.form.Label
//numberfield      L5.form.NumberField
//radio            L5.form.Radio
//textarea         L5.form.TextArea
//textfield        L5.form.TextField
//timefield        L5.form.TimeField
//trigger          L5.form.TriggerField
//</pre>
// * @constructor
// * @param {L5.Element/String/Object} config The configuration options.  If an element is passed, it is set as the internal
// * element and its id used as the component id.  If a string is passed, it is assumed to be the id of an existing element
// * and is used as the component id.  Otherwise, it is assumed to be a standard config object and is applied to the component.
L5.Component = function(config){
    config = config || {};
    if(config.initialConfig){
        if(config.isAction){           // actions
            this.baseAction = config;
        }
        config = config.initialConfig; // component cloning / action set up
    }else if(config.tagName || config.dom || typeof config == "string"){ // element object
        config = {applyTo: config, id: config.id || config};
    }

    /**
     * @ignore
     * @private
     * 保留组件最原始的配置参数
     * @type Object
     * @property initialConfig
     */
    this.initialConfig = config;

    L5.apply(this, config);
    this.addEvents(
        /**
         * @event disable
         * 组件disabled将触发该事件.
	     * @param {L5.Component} this
	     */
        'disable',
        /**
         * @event enable
         * 组件enabled将触发该事件.
	     * @param {L5.Component} this
	     */
        'enable',
        /**
         * @event beforeshow
         * 在组件show之前触发该事件.返回false阻止组件show.
	     * @param {L5.Component} this
	     */
        'beforeshow',
        /**
         * @event show
         * 当组件show的时候触发事件.
	     * @param {L5.Component} this
	     */
        'show',
        /**
         * @event beforehide
         * 在组件hidden之前触发事件.返回false，阻止组件hide.
	     * @param {L5.Component} this
	     */
        'beforehide',
        /**
         * @event hide
         * 组件hidden的时候触发事件.
	     * @param {L5.Component} this
	     */
        'hide',
        /**
         * @event beforerender
         * 组件渲染之前触发该事件，返回false阻止组件渲染.
	     * @param {L5.Component} this
	     */
        'beforerender',
        /**
         * @event render
         * 当组件渲染之后触发该事件.
	     * @param {L5.Component} this
	     */
        'render',
        /**
         * @ignore
         * @event beforedestroy
         * 在组件被销毁之前触发，如果返回false就会终止销毁
	     * @param {L5.Component} this
	     */
        'beforedestroy',
        /**
         * @ignore
         * @event destroy
         * 当组件被销毁后触发
	     * @param {L5.Component} this
	     */
        'destroy',
        /**
         * @ignore
         * @event beforestaterestore
         * 当组件的状态恢复之前触发，如果返回false就终止恢复
	     * @param {L5.Component} this
	     * @param {Object} state The hash of state values
	     */
        'beforestaterestore',
        /**
         * @ignore
         * @event staterestore
         * 当组件状态恢复之后触发
	     * @param {L5.Component} this
	     * @param {Object} state The hash of state values
	     */
        'staterestore',
        /**
         * @ignore
         * @event beforestatesave
         * 在组件状态被保存之前触发，如果返回false就不会报讯组件状态
	     * @param {L5.Component} this
	     * @param {Object} state The hash of state values
	     */
        'beforestatesave',
        /**
         * @ignore
         * @event statesave
         * 当组件状态被保存后触发
	     * @param {L5.Component} this
	     * @param {Object} state The hash of state values
	     */
        'statesave'
    );
    this.getId();
    L5.ComponentMgr.register(this);
    L5.Component.superclass.constructor.call(this);

    if(this.baseAction){
        this.baseAction.addComponent(this);
    }

    this.initComponent();

    if(this.plugins){
        if(L5.isArray(this.plugins)){
            for(var i = 0, len = this.plugins.length; i < len; i++){
                this.plugins[i] = this.initPlugin(this.plugins[i]);
            }
        }else{
            this.plugins = this.initPlugin(this.plugins);
        }
    }

    if(this.stateful !== false){
        this.initState(config);
    }

    if(this.applyTo){
        this.applyToMarkup(this.applyTo);
        delete this.applyTo;
    }else if(this.renderTo){
        this.render(this.renderTo);
        delete this.renderTo;
    }
};

/**
 * @private
 */
L5.Component.AUTO_ID = 1000;

L5.extend(L5.Component, L5.util.Observable, {

    /**
     * @private
     * @cfg {String} disabledClass
     * 当组件被禁用的时候增加此css样式（默认是："l-item-disabled")
     */
    disabledClass : "l-item-disabled",
	/**
	 * @private
	 * @cfg {Boolean} allowDomMove
	 * 当组件渲染的时候是否可以移动DOM结构（默认是true）
	 */
    allowDomMove : true,
	/**
	 * @private
	 * @cfg {Boolean} autoShow
	 * 假如是true：组件可以检测到隐藏的css样式（比如 'l-hidden' 或 'l-hide-display'）并且在渲染的时候将其移走
	 */
    autoShow : false,
    /**
     * @private
     * @cfg {String} hideMode
     * 组件的隐藏模式。可以支持的模式有："visibility" (css控制能见度), "offsets" (将组件移除屏幕可见区域)and "display" (css的显示模式) -默认是 "display"
     */
    hideMode: 'display',
    /**
     * @private
     * @cfg {Boolean} hideParent
     * 如果是true，当隐藏/显示组件的时候会将该组件的父容器也隐藏/显示 ，如果是false，只是隐藏/显示本身
     */
    hideParent: false,

    /**
     * @private
     * The component's owner {@link L5.Container} (defaults to undefined, and is set automatically when
     * the component is added to a container).  Read-only.
     * @type L5.Container
     * @property ownerCt
     */
    /**
     * 如果是true隐藏组件。默认是false
     * @type Boolean
     * @property
     */
    hidden : false,
    /**
     * 如果是true禁用组件。默认是false
     * @private
     * @type Boolean
     * @property
     */
    disabled : false,
    /**
     * 如果组件已经渲染完毕就设置rendered为true
     * @private
     * @type Boolean
     * @property
     */
    rendered : false,

    /**
     * @private
     */
    ctype : "L5.Component",

    /**
     * @private
     */
    actionMode : "el",

    /**
     * @private
     */
    getActionEl : function(){
        return this[this.actionMode];
    },
    /**
     * @private
     * 初始化插件
     * @param {Object} p 插件
     * @return {Object} p
     */
    initPlugin : function(p){
        p.init(this);
        return p;
    },

    initComponent : L5.emptyFn,

    /**
     * @private
     * 将组件渲染到父容器。假如该组件是其他组件的子组件就不需要手动调用该方法，layout会调用该方法
     * @param {Element/HTMLElement/String} container (可选) 将要被渲染到的Element，假如已经存在了可以忽略（比如某个组件新增/移除/.....了子组件，需要重新渲染）
     * @param {String/Number} position (可选)  父容器内DOM的索引或是父容器内元素的ID，该组件将被插入到指定的position
     * @return {L5.Component} 返回组件本身
     */
    render : function(container, position){
        if(!this.rendered && this.fireEvent("beforerender", this) !== false){
            if(!container && this.el){
                this.el = L5.get(this.el);
                container = this.el.dom.parentNode;
                this.allowDomMove = false;
            }
            this.container = L5.get(container);
            if(this.ctCls){
                this.container.addClass(this.ctCls);
            }
            this.rendered = true;
            if(position !== undefined){
                if(typeof position == 'number'){
                    position = this.container.dom.childNodes[position];
                }else{
                    position = L5.getDom(position);
                }
            }
            this.onRender(this.container, position || null);
            if(this.autoShow){
                this.el.removeClass(['l-hidden','l-hide-' + this.hideMode]);
            }
            if(this.cls){
                this.el.addClass(this.cls);
                delete this.cls;
            }
            if(this.style){
                this.el.applyStyles(this.style);
                delete this.style;
            }
            if(this.overCls){
                this.el.addClassOnOver(this.overCls);
            }
            this.fireEvent("render", this);
            this.afterRender(this.container);
            if(this.hidden){
                this.hide();
            }
            if(this.disabled){
                this.disable();
            }

            if(this.stateful !== false){
                this.initStateEvents();
            }
        }
        return this;
    },

    /**
     * @private
     * 初始化组件状态
     */
    initState : function(config){
        if(L5.state.Manager){
            var id = this.getStateId();
            if(id){
                var state = L5.state.Manager.get(id);
                if(state){
                    if(this.fireEvent('beforestaterestore', this, state) !== false){
                        this.applyState(state);
                        this.fireEvent('staterestore', this, state);
                    }
                }
            }
        }
    },

    /**
     * @private
     * 获取保存状态的注册ID
     */
    getStateId : function(){
        return this.stateId || ((this.id.indexOf('L5-comp-') == 0 || this.id.indexOf('L5-gen') == 0) ? null : this.id);
    },

    /**
     * @private
     */
    initStateEvents : function(){
        if(this.stateEvents){
            for(var i = 0, e; e = this.stateEvents[i]; i++){
                this.on(e, this.saveState, this, {delay:100});
            }
        }
    },

    /**
     * @private
     * 将保存的状态拷贝给组件
     */
    applyState : function(state, config){
        if(state){
            L5.apply(this, state);
        }
    },

    /**
     * @private
     */
    getState : function(){
        return null;
    },

    /**
     * @private
     * 保存状态
     */
    saveState : function(){
        if(L5.state.Manager){
            var id = this.getStateId();
            if(id){
                var state = this.getState();
                if(this.fireEvent('beforestatesave', this, state) !== false){
                    L5.state.Manager.set(id, state);
                    this.fireEvent('statesave', this, state);
                }
            }
        }
    },

    /**
     * @private
     * 将组件加载（渲染）到已存在的有效的标记元素上
     * @param {String/HTMLElement} el 要加载到的元素
     */
    applyToMarkup : function(el){
        this.allowDomMove = false;
        this.el = L5.get(el);
        this.render(this.el.dom.parentNode);
    },

    /**
     * 为组件增加css样式
     * @param {string} cls 要增加的css的名称
     */
    addClass : function(cls){
        if(this.el){
            this.el.addClass(cls);
        }else{
            this.cls = this.cls ? this.cls + ' ' + cls : cls;
        }
    },

    /**
     * 从组件上移除css样式
     * @param {string} cls 将要被移除的css
     */
    removeClass : function(cls){
        if(this.el){
            this.el.removeClass(cls);
        }else if(this.cls){
            this.cls = this.cls.split(' ').remove(cls).join(' ');
        }
    },

    /**
     * @private
     * 默认的方法实际上没什么大用，一般子组件的逻辑都会重写
     * @param {L5.Component} ct 父组件
     * @param {Object} position 组件渲染的位置
     */
    onRender : function(ct, position){
        if(this.autoEl){
            if(typeof this.autoEl == 'string'){
                this.el = document.createElement(this.autoEl);
            }else{
                var div = document.createElement('div');
                L5.DomHelper.overwrite(div, this.autoEl);
                this.el = div.firstChild;
            }
            if (!this.el.id) {
            	this.el.id = this.getId();
            }
        }
        if(this.el){
            this.el = L5.get(this.el);
            if(this.allowDomMove !== false){
                ct.dom.insertBefore(this.el.dom, position);
            }
        }
    },

    /**
     * @private
     */
    getAutoCreate : function(){
        var cfg = typeof this.autoCreate == "object" ?
                      this.autoCreate : L5.apply({}, this.defaultAutoCreate);
        if(this.id && !cfg.id){
            cfg.id = this.id;
        }
        return cfg;
    },

    /**
     * @private
     */
    afterRender : L5.emptyFn,

    /**
     * @private
     * 销毁组件的所有事件监听器，移除组件的DOM元素，从L5.ComponentMgr里面注销该组件，一般由框架调用该方法，而不是自己调用
     */
    destroy : function(){
        if(this.fireEvent("beforedestroy", this) !== false){
            this.beforeDestroy();
            if(this.rendered){
                this.el.removeAllListeners();
                this.el.remove();
                if(this.actionMode == "container"){
                    this.container.remove();
                }
            }
            this.onDestroy();
            L5.ComponentMgr.unregister(this);
            this.fireEvent("destroy", this);
            this.purgeListeners();
        }
    },

    /**
     * @private
     */
    beforeDestroy : L5.emptyFn,

	/**
	 * @private
	 */
    onDestroy  : L5.emptyFn,

    /**
     * @private
     * 获取组件的L5.Element对象
     * @return {L5.Element} 组件对应的element
     */
    getEl : function(){
        return this.el;
    },

    /**
     * 获取组件的ID.如果不存在就自动生成
     * @return {String} 返回组件的ID
     */
    getId : function(){
        return this.id || (this.id = "L5-comp-" + (++L5.Component.AUTO_ID));
    },

    /**
     * 获取组件的itemId
     * @private
     * @return {String}
     */
    getItemId : function(){
        return this.itemId || this.getId();
    },

    /**
     * 组件获取焦点
     * @param {Boolean} selectText (可选) 如果是true则同时组件内的文本也获取焦点
     * @param {Boolean/Number} delay (可选) 延迟获取焦点的毫秒数 (如果是true延迟10毫秒)
     * @return {L5.Component} 返回组件本身
     */
    focus : function(selectText, delay){
        if(delay){
            this.focus.defer(typeof delay == 'number' ? delay : 10, this, [selectText, false]);
            return;
        }
        if(this.rendered){
            this.el.focus();
            if(selectText === true){
                this.el.dom.select();
            }
        }
        return this;
    },

    /**
     * 组件失去焦点
     * @return {L5.Component} 返回组件本身
     */
    blur : function(){
        if(this.rendered){
            this.el.blur();
        }
        return this;
    },

    /**
     * 禁用该组件
     * @return {L5.Component} 返回组件本身
     */
    disable : function(){
        if(this.rendered){
            this.onDisable();
        }
        this.disabled = true;
        this.fireEvent("disable", this);
        return this;
    },

    /**
     * @private
     * 禁用组件底层dom
     */
    onDisable : function(){
        this.getActionEl().addClass(this.disabledClass);
        this.el.dom.disabled = true;
    },

    /**
     * 启用该组件
     * @return {L5.Component} 返回组件本身
     */
    enable : function(){
        if(this.rendered){
            this.onEnable();
        }
        this.disabled = false;
        this.fireEvent("enable", this);
        return this;
    },

	/**
	 * @private
	 */
    onEnable : function(){
        this.getActionEl().removeClass(this.disabledClass);
        this.el.dom.disabled = false;
    },

    /**
     * 通过布尔值控制参数，方便的禁用/启用组件
     * @param {Boolean} disabled  禁用/启用组件
     */
    setDisabled : function(disabled){
        this[disabled ? "disable" : "enable"]();
    },

    /**
     * 展现此组件.
     * @return {L5.Component} this
     */
    show: function(){
        if(this.fireEvent("beforeshow", this) !== false){
            this.hidden = false;
            if(this.autoRender){
                this.render(typeof this.autoRender == 'boolean' ? L5.getBody() : this.autoRender);
            }
            if(this.rendered){
                this.onShow();
            }
            this.fireEvent("show", this);
        }
        return this;
    },

    /**
     * @private
     */
    onShow : function(){
        if(this.hideParent){
            this.container.removeClass('l-hide-' + this.hideMode);
        }else{
            this.getActionEl().removeClass('l-hide-' + this.hideMode);
            //当组件从隐藏变为显示时，调用BoxComponent的onWinResize方法，重写计算并设置组件宽度、高度
            if(this.onWinResize)
            	this.onWinResize();
        }

    },
    /**
     * 隐藏此组件.
     * @return {L5.Component} this
     */
    hide: function(){
        if(this.fireEvent("beforehide", this) !== false){
            this.hidden = true;
            if(this.rendered){
                this.onHide();
            }
            this.fireEvent("hide", this);
        }
        return this;
    },

    /**
     * @private
     */
    onHide : function(){
        if(this.hideParent){
            this.container.addClass('l-hide-' + this.hideMode);
        }else{
            this.getActionEl().addClass('l-hide-' + this.hideMode);
        }
    },

    /**
     * 通过布尔值控制组件的显示/隐藏
     * @param {Boolean} visible 显示/隐藏组件
     * @return {L5.Component} this 返回组件本身
     */
    setVisible: function(visible){
        if(visible) {
            this.show();
        }else{
            this.hide();
        }
        return this;
    },

    /**
     * 判断组件是否可见
     * @return {Boolean} 返回组件的可见状态
     */
    isVisible : function(){
        return this.rendered && this.getActionEl().isVisible();
    },

    /**
     * @private
     * 通过最原始的配置参数克隆组件
     * @param {Object} overrides 新的配置参数，将覆盖老的配置参数，id属性必须不同，避免重复注册.
     * @return {L5.Component} 返回克隆的组件
     */
    cloneConfig : function(overrides){
        overrides = overrides || {};
        var id = overrides.id || L5.id();
        var cfg = L5.applyIf(overrides, this.initialConfig);
        cfg.id = id; // prevent dup id
        return new this.constructor(cfg);
    },

    /**
     * 获取组件注册的xtype信息
     * @return {String} The xtype
     */
    getXType : function(){
        return this.constructor.xtype;
    },

    /**
     * 判断当前组件是否是xtype类型的组件
     * @param {String} xtype 想要检测的xtype
     * @param {Boolean} shallow (可选) 是否递归检测，如果是false就递归检测，一次查看父类，是否是xtype默认是False 
     * @return {Boolean} 返回检测结果，true表示匹配正确
     */
    isXType : function(xtype, shallow){
        //assume a string by default
        if (typeof xtype == 'function'){
            xtype = xtype.xtype; //handle being passed the class, eg. L5.Component
        }else if (typeof xtype == 'object'){
            xtype = xtype.constructor.xtype; //handle being passed an instance
        }
            
        return !shallow ? ('/' + this.getXTypes() + '/').indexOf('/' + xtype + '/') != -1 : this.constructor.xtype == xtype;
    },

    /**
     * 获取组件的xtype。从祖先类开始一直到当前组件所属类，全部的xtype都被获取到
     * 例如：var t = new L5.form.TextField();
     * 			 alert(t.getXTypes());  // alerts 'component/box/field/textfield'
     * @return {String} xtype 字符串
     */
    getXTypes : function(){
        var tc = this.constructor;
        if(!tc.xtypes){
            var c = [], sc = this;
            while(sc && sc.constructor.xtype){
                c.unshift(sc.constructor.xtype);
                sc = sc.constructor.superclass;
            }
            tc.xtypeChain = c;
            tc.xtypes = c.join('/');
        }
        return tc.xtypes;
    },

    /**
     * 通过定制的function查找该组件的祖先组件
     * @param {Function} fcn 自定义的匹配方法
     * @return {L5.Container} 返回第一个匹配成功的祖先组件
     */
    findParentBy: function(fn) {
        for (var p = this.ownerCt; (p != null) && !fn(p, this); p = p.ownerCt);
        return p || null;
    },

    /**
     * 通过xtype查找组件的祖先组件
     * @param {String/Class} xtype 要查找的组件的xtype或者类
     * @return {L5.Container} 返回第一个匹配成功的祖先组件
     */
    findParentByType: function(xtype) {
        return typeof xtype == 'function' ?
            this.findParentBy(function(p){
                return p.constructor === xtype;
            }) :
            this.findParentBy(function(p){
                return p.constructor.xtype === xtype;
            });
    },

    /**
     * @private
     * 内部方法，用来自动处理销毁事件的
     */
    mon : function(item, ename, fn, scope, opt){
        if(!this.mons){
            this.mons = [];
            this.on('beforedestroy', function(){
                for(var i= 0, len = this.mons.length; i < len; i++){
                    var m = this.mons[i];
                    m.item.un(m.ename, m.fn, m.scope);
                }
            }, this);
        }
        this.mons.push({
            item: item, ename: ename, fn: fn, scope: scope
        });
        item.on(ename, fn, scope, opt);
    }
});

L5.reg('component', L5.Component);
