//doc
/**
 * @class L5.Window
 * @extends L5.Panel
 * 用来代替应用程序窗口的特殊面板。该面板（window）有悬浮效果，可以拖动，可以实现最大化最小化的功能
 * @constructor
 * @param {Object} config 配置对象
 */
L5.Window = L5.extend(L5.Panel, {
    /**
     * @cfg {Number} x  
     * 窗口的x坐标，默认情况下是将window显示在父容器的中间位置
     * @ignore
     * @hide
     */
    /**
     * @cfg {Number} y 
     * 窗口的y坐标，默认情况下是将window显示在父容器的中间位置
     * @hide
     * @ignore
     */
    /**
     * @cfg {Boolean} modal 
     * 如果设置成true，任何其它组件都会被它遮挡住, false就没有这个效果(默认是false).
     * @ignore
     */
    /**
     * @cfg {String/Element} animateTarget 
     * 当窗口打开关闭时候的动画效果，默认没有动画效果
     * @hide
     * @ignore
     */
    /**
     * @cfg {String} resizeHandles 
     * @hide
     * @ignore
     * A valid {@link L5.Resizable} handles config string (defaults to 'all').  Only applies when resizable = true.
     */
    /**
     * @cfg {L5.WindowGroup} manager @hide
     * @ignore
     * A reference to the WindowGroup that should manage this window (defaults to {@link L5.WindowMgr}).
     */
    /**
    * @cfg {String/Number/Button} defaultButton @hide
    * @ignore
    * The id / index of a button or a button instance to focus when this window received the focus.
    */
    /**
    * @cfg {Function} onEsc @hide
    * @ignore
    * Allows override of the built-in processing for the escape key. Default action
    * is to close the Window (performing whatever action is specified in {@link #closeAction}.
    * To prevent the Window closing when the escape key is pressed, specify this as
    * L5.emptyFn (See {@link L5#emptyFn}).
    */
    /**
     * @cfg {Boolean} collapsed @hide
     * @ignore
     * True to render the window collapsed, false to render it expanded (defaults to false). Note that if 
     * {@link #expandOnShow} is true (the default) it will override the <tt>collapsed</tt> config and the window 
     * will always be expanded when shown.
     */
    /**
     * @cfg {Boolean} maximized @hide
     * @ignore
     * True to initially display the window in a maximized state. (Defaults to false).
     */
    
    /**
    * @cfg {String} baseCls
    * @ignore 
    * @hide
    * window的基本的css样式
    */
    baseCls : 'l-window',
    /**
     * @cfg {Boolean} resizable 
     * 设置成true允许改变大小，false不允许改变大小(默认是true).
     */
    resizable:true,
    /**
     * @cfg {Boolean} draggable 
     * @hide
     * 如果是true允许拖动，默认是true。注意：如果禁用拖动，需要渲染完成后才行
     */
    draggable:true,
    /**
     * @cfg {Boolean} closable 
     * @hide
     * 如果是true就会将关闭按钮显示出来，允许关闭窗口（默认是true）。
     */
    closable : true,
    /**
     * @cfg {Boolean} constrain 
     * @hide
     * @ignore
     * 如果是true就会限制window在可视父容器内部，如果是false就允许移动外外面去。（默认是false）
     */
    constrain:false,
    /**
     * @cfg {Boolean} constrainHeader 
     * @hide
     * @ignore
     * 如果是true，window的header部分就会限制在可视父容器内部，但是允许body部分移动到外面。如果是false允许header部分
     * 移动到可视父组件外面（默认是false）
     */
    constrainHeader:false,
    /**
     * @cfg {Boolean} plain 
     * @hide
     * @ignore
     * 如果是true，将吧窗口的body背景渲染成透明，如果是false就会为body增加淡淡的背景颜色造成body部分高亮，使其看
     * 起来更突出（默认是false）
     */
    plain:false,
    /**
     * @cfg {Boolean} minimizable 
     * true可以有最小化按钮，可以最小化窗口.
     */
    minimizable : false,
    /**
     * @cfg {Boolean} maximizable
     * True可以有最大化按钮，可以最大化窗口.
     */
    maximizable : false,
    /**
     * @cfg {Number} minHeight 
     * @hide
     * @ignore
     * 窗口的最小高度（默认是100px）,仅当resizable是true的时候有效
     */
    minHeight: 100,
    /**
     * @cfg {Number} minWidth 
     * @hide
     * @ignore
     * 窗口的最小宽度（默认是200px）仅当resizable是true的时候有效
     */
    minWidth: 200,
    /**
     * @cfg {Boolean} expandOnShow 
     * @hide
     * @ignore
     * 如果是true，当window展现的时候总是展开的，如果是false就会保持原有的状态（可能是闭合的可能是展开的，默认是true）
     */
    expandOnShow: true,
    /**
     * @cfg {String} closeAction 
     * 点击关闭按钮时执行的动作.默认动作是'close'将会销毁创建的窗口DOM元素.另一个可选的操作是'hide' 它会将窗口隐藏掉。
     * 查看{@link #show}方法.
     */
    closeAction: 'close',
    /**
     * @cfg {String} elements @hide
     * 这是一个用逗号分隔的字符串，里面包含了一系列的panel的元素，当panel渲染的时候会将这些初始化。正常情况下当初始化配置的时候
     * 会随着panel里面子组件的添加而自动添加，但是如果panel已经渲染完成，而又需要增加子组件的时候也需要去维护这个elements字符串，
     * 以确保结构化完整化。支持的子组件有效名称如下：
     * <ul>
     * <li><b>header</b></li>
     * <li><b>tbar</b> (top bar)</li>
     * <li><b>body</b> (required)</li>
     * <li><b>bbar</b> (bottom bar)</li>
     * <li><b>footer</b><li>
     * </ul>
     * 默认已经有 'header,body'.
     */
    elements: 'header,body',

    /**
     * @cfg {Boolean} collapsible
     * 设置true可以使window伸缩展开，并且有伸缩展开按钮在header的右边，否则不具有该功能。
     * (默认是false).
     */
    collapsible:false,

    /**
     * @cfg {Boolean} initHidden
     * 如果是true，当初始化后是隐藏的。（默认是true)
     */
    initHidden : true,
    /**
    * @cfg {Boolean} monitorResize 
    * @hide 
    * This is automatically managed based on the value of constrain and constrainToHeader
    */
    monitorResize : true,
    /** @cfg {Boolean} frame @hide  @ignore*/
    frame:true,
    /** @cfg {Boolean} floating @hide @ignore*/
    floating:true,

    /**
     * @private
     * 增加了部分事件
     */
    initComponent : function(){
        L5.Window.superclass.initComponent.call(this);
        this.addEvents(
            /**
             * @event activate
             * 窗口被激活的时候触发事件，{@link setActive}.
             * @param {L5.Window} this
             */
            /**
             * @event deactivate
             * 窗口不会激活的时候触发事件，{@link setActive}.
             * @param {L5.Window} this
             */
            /**
             * @event resize
             * 调整窗口大小的时候触发事件.
             * @param {L5.Window} this
             * @param {Number} width 窗口的新宽度
             * @param {Number} height 窗口的新高度
             */
            'resize',
            /**
             * @event maximize
             * 最大化的时候触发事件.
             * @param {L5.Window} this
             */
            'maximize',
            /**
             * @event minimize
             * 最小化的时候触发时间.
             * @param {L5.Window} this
             */
            'minimize',
            /**
             * @ignore
             * @event restore
             * Fires after the window has been restored to its original size after being maximized.
             * @param {L5.Window} this
             */
            'restore'
        );
    },

    /**
     * @private
     */
    getState : function(){
        return L5.apply(L5.Window.superclass.getState.call(this) || {}, this.getBox());
    },

    /**
     * @private
     */
    onRender : function(ct, position){
        L5.Window.superclass.onRender.call(this, ct, position);

        if(this.plain){
            this.el.addClass('l-window-plain');
        }

        // this element allows the Window to be focused for keyboard events
        this.focusEl = this.el.createChild({
                    tag: "a", href:"#", cls:"l-dlg-focus",
                    tabIndex:"-1", html: "&#160;"});
        this.focusEl.swallowEvent('click', true);

        this.proxy = this.el.createProxy("l-window-proxy");
        this.proxy.enableDisplayMode('block');

        if(this.modal){
            this.mask = this.container.createChild({cls:"L5-el-mask"}, this.el.dom);
            this.mask.enableDisplayMode("block");
            this.mask.hide();
            this.mask.on('click', this.focus, this);
        }
    },

    /**
     * @private
     */
    initEvents : function(){
        L5.Window.superclass.initEvents.call(this);
        if(this.animateTarget){
            this.setAnimateTarget(this.animateTarget);
        }

        if(this.resizable){
            this.resizer = new L5.Resizable(this.el, {
                minWidth: this.minWidth,
                minHeight:this.minHeight,
                handles: this.resizeHandles || "all",
                pinned: true,
                resizeElement : this.resizerAction
            });
            this.resizer.window = this;
            this.resizer.on("beforeresize", this.beforeResize, this);
        }

        if(this.draggable){
            this.header.addClass("l-window-draggable");
        }
        this.initTools();

        this.el.on("mousedown", this.toFront, this);
        this.manager = this.manager || L5.WindowMgr;
        this.manager.register(this);
        this.hidden = true;
        if(this.maximized){
            this.maximized = false;
            this.maximize();
        }
        if(this.closable){
            var km = this.getKeyMap();
            km.on(27, this.onEsc, this);
            km.disable();
        }
    },
    /**
     * @private
     * 初始化拖动
     */
    initDraggable : function(){
        /**
         * 假如window是可拖动的就会初始化拖动
         * @ignore
         * @type L5.dd.DD
         * @property dd
         */
        this.dd = new L5.Window.DD(this);
    },

    /**
     * @private
     */
    onEsc : function(){
        this[this.closeAction]();
    },

    /**
     * @private
     */
    beforeDestroy : function(){
        this.hide();
        if(this.doAnchor){
            L5.EventManager.removeResizeListener(this.doAnchor, this);
            L5.EventManager.un(window, 'scroll', this.doAnchor, this);
        }
        L5.destroy(
            this.focusEl,
            this.resizer,
            this.dd,
            this.proxy,
            this.mask
        );
        L5.Window.superclass.beforeDestroy.call(this);
    },

    /**
     * @private
     */
    onDestroy : function(){
        if(this.manager){
            this.manager.unregister(this);
        }
        L5.Window.superclass.onDestroy.call(this);
    },

    /**
     * @private
     */
    initTools : function(){
        if(this.minimizable){
            this.addTool({
                id: 'minimize',
                handler: this.minimize.createDelegate(this, [])
            });
        }
        if(this.maximizable){
            this.addTool({
                id: 'maximize',
                handler: this.maximize.createDelegate(this, [])
            });
            this.addTool({
                id: 'restore',
                handler: this.restore.createDelegate(this, []),
                hidden:true
            });
            this.header.on('dblclick', this.toggleMaximize, this);
        }
        if(this.closable){
            this.addTool({
                id: 'close',
                handler: this[this.closeAction].createDelegate(this, [])
            });
        }
    },

    /**
     * @private
     */
    resizerAction : function(){
        var box = this.proxy.getBox();
        this.proxy.hide();
        this.window.handleResize(box);
        return box;
    },

    /**
     * @private
     */
    beforeResize : function(){
        this.resizer.minHeight = Math.max(this.minHeight, this.getFrameHeight() + 40); // 40 is a magic minimum content size?
        this.resizer.minWidth = Math.max(this.minWidth, this.getFrameWidth() + 40);
        this.resizeBox = this.el.getBox();
    },

    /**
     * @private
     */
    updateHandles : function(){
        if(L5.isIE && this.resizer){
            this.resizer.syncHandleHeight();
            this.el.repaint();
        }
    },

    /**
     * @private
     */
    handleResize : function(box){
        var rz = this.resizeBox;
        if(rz.x != box.x || rz.y != box.y){
            this.updateBox(box);
        }else{
            this.setSize(box);
        }
        this.focus();
        this.updateHandles();
        this.saveState();
        if(this.layout){
            this.doLayout();
        }
        this.fireEvent("resize", this, box.width, box.height);
    },

    /**
     * 聚焦到window上，假如设置了默认的按钮将聚焦到按钮上，否则聚焦到窗口本身
     */
    focus : function(){
        var f = this.focusEl, db = this.defaultButton, t = typeof db;
        if(t != 'undefined'){
            if(t == 'number'){
                f = this.buttons[db];
            }else if(t == 'string'){
                f = L5.getCmp(db);
            }else{
                f = db;
            }
        }
        f.focus.defer(10, f);
    },

    /**
     * 设置动画效果的目标元素
     * @private
     * @param {String/Element} el 目标元素或者目标元素id
     */
    setAnimateTarget : function(el){
        el = L5.get(el);
        this.animateTarget = el;
    },

    /**
     * @private
     */
    beforeShow : function(){
        delete this.el.lastXY;
        delete this.el.lastLT;
        if(this.x === undefined || this.y === undefined){
//            var xy = this.el.getAlignToXY(this.container, 'c-c');
        	var xy=this.el.getCenterXY();
            var pos = this.el.translatePoints(xy[0], xy[1]);
            this.x = this.x === undefined? pos.left : this.x;
            this.y = this.y === undefined? pos.top : this.y;
        }
        this.el.setLeftTop(this.x, this.y);

        if(this.expandOnShow){
            this.expand(false);
        }

        if(this.modal){
            L5.getBody().addClass("l-body-masked");
            this.mask.setSize(L5.lib.Dom.getViewWidth(true), L5.lib.Dom.getViewHeight(true));
            this.mask.show();
        }
    },

    /**
     * 展示窗口,如果第一次展示，则创建它,如果是隐藏的，则直接展示到最前面.
     * @param {String/Element} animateTarget (可选) 窗口从哪个地方弹出，带动画效果。
     * (默认无动画效果)
     * @param {Function} callback (可选) 当窗口展现之后，会回调这个函数
     * @param {Object} scope (可选) 回调函数的作用域
     */
    show : function(animateTarget, cb, scope){
        if(!this.rendered){
            this.render(L5.getBody());
        }
        if(this.hidden === false){
            this.toFront();
            return;
        }
        if(this.fireEvent("beforeshow", this) === false){
            return;
        }
        if(cb){
            this.on('show', cb, scope, {single:true});
        }
        this.hidden = false;
        if(animateTarget !== undefined){
            this.setAnimateTarget(animateTarget);
        }
        this.beforeShow();
        if(this.animateTarget){
            this.animShow();
        }else{
            this.afterShow();
        }
    },

    /**
     * @private
     */
    afterShow : function(){
        this.proxy.hide();
        this.el.setStyle('display', 'block');
        this.el.show();
        if(this.maximized){
            this.fitContainer();
        }
        if(L5.isMac && L5.isGecko){ // work around stupid FF 2.0/Mac scroll bar bug
        	this.cascade(this.setAutoScroll);
        }

        if(this.monitorResize || this.modal || this.constrain || this.constrainHeader){
            L5.EventManager.onWindowResize(this.onWindowResize, this);
        }
        this.doConstrain();
        if(this.layout){
            this.doLayout();
        }
        if(this.keyMap){
            this.keyMap.enable();
        }
        this.toFront();
        this.updateHandles();
        this.fireEvent("show", this);
    },

    /**
     * @private
     */
    animShow : function(){
        this.proxy.show();
        this.proxy.setBox(this.animateTarget.getBox());
        this.proxy.setOpacity(0);
        var b = this.getBox(false);
        b.callback = this.afterShow;
        b.scope = this;
        b.duration = .25;
        b.easing = 'easeNone';
        b.opacity = .5;
        b.block = true;
        this.el.setStyle('display', 'none');
        this.proxy.shift(b);
    },

    /**
     * 隐藏窗口.
     * @param {String/Element} animateTarget (可选) 从那个地方隐藏进去，带动画效果。
     * (默认无动画效果)
     * @param {Function} callback (可选) 当隐藏的时候，会回调这个函数。
     * @param {Object} scope (可选) 回调函数的作用域。
     */
    hide : function(animateTarget, cb, scope){
        if(this.activeGhost){ // drag active?
            this.hide.defer(100, this, [animateTarget, cb, scope]);
            return;
        }
        if(this.hidden || this.fireEvent("beforehide", this) === false){
            return;
        }
        if(cb){
            this.on('hide', cb, scope, {single:true});
        }
        this.hidden = true;
        if(animateTarget !== undefined){
            this.setAnimateTarget(animateTarget);
        }
        if(this.animateTarget){
            this.animHide();
        }else{
            this.el.hide();
            this.afterHide();
        }
    },

	/**
	 * @private
	 */
    afterHide : function(){
        this.proxy.hide();
        if(this.monitorResize || this.modal || this.constrain || this.constrainHeader){
            L5.EventManager.removeResizeListener(this.onWindowResize, this);
        }
        if(this.modal){
            this.mask.hide();
            L5.getBody().removeClass("l-body-masked");
        }
        if(this.keyMap){
            this.keyMap.disable();
        }
        this.fireEvent("hide", this);
    },

    /**
	 * @private
	 */
    animHide : function(){
        this.proxy.setOpacity(.5);
        this.proxy.show();
        var tb = this.getBox(false);
        this.proxy.setBox(tb);
        this.el.hide();
        var b = this.animateTarget.getBox();
        b.callback = this.afterHide;
        b.scope = this;
        b.duration = .25;
        b.easing = 'easeNone';
        b.block = true;
        b.opacity = 0;
        this.proxy.shift(b);
    },

    /**
	 * @private
	 */
    onWindowResize : function(){
        if(this.maximized){
            this.fitContainer();
        }
        if(this.modal){
            this.mask.setSize('100%', '100%');
            var force = this.mask.dom.offsetHeight;
            this.mask.setSize(L5.lib.Dom.getViewWidth(true), L5.lib.Dom.getViewHeight(true));
        }
        this.doConstrain();
    },

    /**
	 * @private
	 */
    doConstrain : function(){
        if(this.constrain || this.constrainHeader){
            var offsets;
            if(this.constrain){
                offsets = {
                    right:this.el.shadowOffset,
                    left:this.el.shadowOffset,
                    bottom:this.el.shadowOffset
                };
            }else {
                var s = this.getSize();
                offsets = {
                    right:-(s.width - 100),
                    bottom:-(s.height - 25)
                };
            }

            var xy = this.el.getConstrainToXY(this.container, true, offsets);
            if(xy){
                this.setPosition(xy[0], xy[1]);
            }
        }
    },

    /**
	 * @private
	 */
    ghost : function(cls){
        var ghost = this.createGhost(cls);
        var box = this.getBox(true);
        ghost.setLeftTop(box.x, box.y);
        ghost.setWidth(box.width);
        this.el.hide();
        this.activeGhost = ghost;
        return ghost;
    },

    /**
	 * @private
	 */
    unghost : function(show, matchPosition){
        if(show !== false){
            this.el.show();
            this.focus();
	        if(L5.isMac && L5.isGecko){ // work around stupid FF 2.0/Mac scroll bar bug
	        	this.cascade(this.setAutoScroll);
	        }
        }
        if(matchPosition !== false){
            this.setPosition(this.activeGhost.getLeft(true), this.activeGhost.getTop(true));
        }
        this.activeGhost.hide();
        this.activeGhost.remove();
        delete this.activeGhost;
    },

    /**
     * 仅触发minimize事件的方法，如果想要自定义行为可以重写这个方法
     * @private
     */
    minimize : function(){
        this.fireEvent('minimize', this);
    },

    /**
     * 关闭这个窗口，将其从DOM中移除，触发beforeclose和close事件
     */
    close : function(){
        if(this.fireEvent("beforeclose", this) !== false){
            this.hide(null, function(){
                this.fireEvent('close', this);
                this.destroy();
            }, this);
        }
    },

    /**
     * 是窗口最大化，同时将最大化的按钮换成还原按钮
     * @private
     */
    maximize : function(){
        if(!this.maximized){
            this.expand(false);
            this.restoreSize = this.getSize();
            this.restorePos = this.getPosition(true);
            if (this.maximizable){
                this.tools.maximize.hide();
                this.tools.restore.show();
            }
            this.maximized = true;
            this.el.disableShadow();

            if(this.dd){
                this.dd.lock();
            }
            if(this.collapsible){
                this.tools.toggle.hide();
            }
            this.el.addClass('l-window-maximized');
            this.container.addClass('l-window-maximized-ct');

            this.setPosition(0, 0);
            this.fitContainer();
            this.fireEvent('maximize', this);
        }
    },

    /**
     * 还原窗口大小，同时将还原按钮换成最大化按钮
     * @private
     */
    restore : function(){
        if(this.maximized){
            this.el.removeClass('l-window-maximized');
            this.tools.restore.hide();
            this.tools.maximize.show();
            this.setPosition(this.restorePos[0], this.restorePos[1]);
            this.setSize(this.restoreSize.width, this.restoreSize.height);
            delete this.restorePos;
            delete this.restoreSize;
            this.maximized = false;
            this.el.enableShadow(true);

            if(this.dd){
                this.dd.unlock();
            }
            if(this.collapsible){
                this.tools.toggle.show();
            }
            this.container.removeClass('l-window-maximized-ct');

            this.doConstrain();
            this.fireEvent('restore', this);
        }
    },

    /**
     * 在最大化和还原之间切换
     * @private
     */
    toggleMaximize : function(){
        this[this.maximized ? 'restore' : 'maximize']();
    },

    /**
     * @private
     */
    fitContainer : function(){
        var vs = this.container.getViewSize();
        this.setSize(vs.width, vs.height);
    },

    /**
     * 设置窗口的z-index
     * @private
     */
    setZIndex : function(index){
        if(this.modal){
            this.mask.setStyle("z-index", index);
        }
        this.el.setZIndex(++index);
        index += 5;

        if(this.resizer){
            this.resizer.proxy.setStyle("z-index", ++index);
        }

        this.lastZIndex = index;
    },

    /**
     * 将窗口对齐到指定的元素。
     * @private
     * @param {Mixed} element 要对齐到的元素.
     * @param {String} position 要设置的位置 (see {@link L5.Element#alignTo} for more details).
     * @param {Array} offsets (可选) 通过 [x, y]设置偏移量
     * @return {L5.Window} 返回窗口本身
     */
    alignTo : function(element, position, offsets){
        var xy = this.el.getAlignToXY(element, position, offsets);
        this.setPagePosition(xy[0], xy[1]);
        return this;
    },

    /**
     * 将窗口定位到其他元素
     * @private
     * @param {Mixed} element 要定位到的元素
     * @param {String} position 要对齐的位置
     * @param {Array} offsets (可选) 通过 [x, y]设置偏移量
     * @param {Boolean/Number} monitorScroll (可选) 如果是true就会监控body的滚动条将其复位，
     * 																	假如这个参数是数字，就会延迟参数指定的毫秒数（默认是50毫秒）
     * @return {L5.Window} this
     */
    anchorTo : function(el, alignment, offsets, monitorScroll){
      if(this.doAnchor){
          L5.EventManager.removeResizeListener(this.doAnchor, this);
          L5.EventManager.un(window, 'scroll', this.doAnchor, this);
      }
      this.doAnchor = function(){
          this.alignTo(el, alignment, offsets);
      };
      L5.EventManager.onWindowResize(this.doAnchor, this);
      
      var tm = typeof monitorScroll;
      if(tm != 'undefined'){
          L5.EventManager.on(window, 'scroll', this.doAnchor, this,
              {buffer: tm == 'number' ? monitorScroll : 50});
      }
      this.doAnchor();
      return this;
    },

    /**
     * 将窗口置前，设置到其他窗口之前
     * @private
     * @return {L5.Window} this
     */
    toFront : function(e){
        if(this.manager.bringToFront(this)){
            if(!e || !e.getTarget().focus){
                this.focus();
            }
        }
        return this;
    },

    /**
     * 设置窗口为活动/非活动 窗口。这个方法触发activate/deactivate事件
     * @private
     * @param {Boolean} active 如果是true，就设置该窗口是活动窗口否则是非活动窗口 (默认是false)
     */
    setActive : function(active){
        if(active){
            if(!this.maximized){
                this.el.enableShadow(true);
            }
            this.fireEvent('activate', this);
        }else{
            this.el.disableShadow();
            this.fireEvent('deactivate', this);
        }
    },

    /**
     * 将窗口设置到其他低于他的z-index窗口之后
     * @private
     * @return {L5.Window} this
     */
    toBack : function(){
        this.manager.sendToBack(this);
        return this;
    },

    /**
     * 将窗口设置到父容器的中央位置
     * @private
     * @return {L5.Window} this
     */
    center : function(){
        var xy = this.el.getAlignToXY(this.container, 'c-c');
        this.setPagePosition(xy[0], xy[1]);
        return this;
    }

    /**
     * @cfg {Boolean} autoWidth @hide
     * @ignore
     **/
});
L5.reg('window', L5.Window);

/**
 * @private
 * 窗口的自定义拖拽
 */
L5.Window.DD = function(win){
    this.win = win;
    L5.Window.DD.superclass.constructor.call(this, win.el.id, 'WindowDD-'+win.id);
    this.setHandleElId(win.header.id);
    this.scroll = false;
};

L5.extend(L5.Window.DD, L5.dd.DD, {
    moveOnly:true,
    headerOffsets:[100, 25],
    startDrag : function(){
        var w = this.win;
        this.proxy = w.ghost();
        if(w.constrain !== false){
            var so = w.el.shadowOffset;
            this.constrainTo(w.container, {right: so, left: so, bottom: so});
        }else if(w.constrainHeader !== false){
            var s = this.proxy.getSize();
            this.constrainTo(w.container, {right: -(s.width-this.headerOffsets[0]), bottom: -(s.height-this.headerOffsets[1])});
        }
    },
    b4Drag : L5.emptyFn,

    onDrag : function(e){
        this.alignElWithMouse(this.proxy, e.getPageX(), e.getPageY());
    },

    endDrag : function(e){
        this.win.unghost();
        this.win.saveState();
    }
});
