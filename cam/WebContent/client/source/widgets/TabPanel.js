//doc

/**
 * @class L5.TabPanel
 * @extends L5.Panel
 * @param {Object} config 配置属性
 * var tabs = new L5.TabPanel({
 *    renderTo: L5.getBody(),
 *    activeTab: 0,
 *    items: [{
 *        title: 'Tab 1',
 *        html: 'A simple tab'
 *    },{
 *        title: 'Tab 2',
 *        html: 'Another one'
 *    }]
 *});
 *
 * var tabs = new L5.TabPanel({
 *    renderTo: 'my-tabs',
 *    activeTab: 0,
 *    items:[
 *        {contentEl:'tab1', title:'Tab 1'},
 *        {contentEl:'tab2', title:'Tab 2'}
 *    ]
 *});
 *var tabs = new L5.TabPanel({
 *     applyTo: 'my-tabs',
 *     activeTab: 0,
 *     deferredRender: false,
 *     autoTabs: true
 * });
 *
 * 下面这些满足条件的奖杯转为标签页
 * <div id="my-tabs">
 * <div class="l-tab" title="Tab 1">A simple tab</div>
 * <div class="l-tab" title="Tab 2">Another one</div>
 */

L5.TabPanel = L5.extend(L5.Panel,  {
    /**
     * @private
     * @cfg {Boolean} layoutOnTabChange 如果是true当tab页变动的时候触发layout动作
     */
    /**
     * @private
     * @cfg {String} tabCls 这个配置项应用到TabPanel的子组件上，这个css样式应用到每个标签页得子组件上。
     */
    /**
     * @private
     * @cfg {Boolean} monitorResize 如果是true就会检测窗口的resize事件，并且重新布局（默认是true）
     */
    monitorResize : true,
    /**
     * @private
     * @cfg {Boolean} deferredRender TabPanel内部使用L5.layout.CardLayout管理tab页。这个属性将被传递给布局的L5.layout.CardLayout.deferredRender
     * ，用来确定当组件渲染的时候是否所有的tab页都渲染（默认是true，只渲染当前页面）。如果其他tab页没被渲染那么其他页面的表单也不能提交
     */
    deferredRender : true,
    /**
     * @private
     * @cfg {Number} tabWidth 每个tab页面的宽度（默认是120）
     */
    tabWidth: 120,
    /**
     * @private
     * @cfg {Number} minTabWidth tab页面的最小宽度（默认是30px）
     */
    minTabWidth: 30,
    /**
     * @private
     * @cfg {Boolean} resizeTabs 如果是true就允许自动调整每个标签，使之自动填满标签条（如果tabWidth是120，每个tab标签都是120px，
     * 默认是false)。设置成true可能引起标签覆盖标签。
     */
    resizeTabs:false,
    /**
     * @private
     * @cfg {Boolean} enableTabScroll 如果是true，当标签页太多的时候可以滚动显示标签栏（默认是false）
     */
    enableTabScroll: false,
    /**
     * @private
     * @cfg {Number} scrollIncrement 当enableTabScroll为true的时候，没按下标签栏滚动按钮的时候滚动的像素值，当resizeTabs
     * 是true的时候会计算tab的宽度
     */
    scrollIncrement : 0,
    /**
     * @private
     * @cfg {Number} scrollRepeatInterval 当按下scroll键的时候每间隔一个时间段就会滚动一次（scrollRepeatInterval就是间隔的时间段，毫秒计算
     * ，默认是400）
     */
    scrollRepeatInterval : 400,
    /**
     * @private
     * @cfg {Float} scrollDuration 每个标签滚动是动画效果需要持续的毫秒数(默认是 .35)，当animScroll时true的似乎后有效
     */
    scrollDuration : .35,
    /**
     * @private
     * @cfg {Boolean} animScroll true表示标签滚动的时候带有动画效果。前提是enableTabScroll是true
     */
    animScroll : true,
    /**
     * @private
     * @cfg {String} tabPosition 标签栏的渲染位置，有效值是：top  bottom, (默认是top）注意：标签滚动条只支持top
     */
    tabPosition: 'top',
    /**
     * @private
     * @cfg {String} baseCls tabpanel的基本css样式
     */
    baseCls: 'l-tab-panel',
    /**
     * @private
     * @cfg {Boolean} autoTabs
     * 如果是true，就就会查询DOM元素中包含'l-tab'样式的div（autoTabSelector的默认是'div.l-tab'可以定制成别的），然后转化成tabs增加到tabpanel。注意：查找的范围仅限在tabpanel这个
     * 容器范围内（所以我们可以从多个被标记的元素生成tabpanel的tab标签）。这个方法仅适用于tag标签名是div并且css样式是'l-tab'的标签。
     * 要无限制的创建TabPanel或者在已存在元素的网页上将元素都放入tab标签，我们可以参考如下例子：
     * 另外还有两个注意点：1）如果使用autoTabs这个配置项，那么需要使用applyTo，让tabpanelapply到标签页容器上
     * 2）设置deferredRender是false，这样保证tabpanel立刻能够渲染完成，否则满足条件的div将不被转化，一直可见位于tabpanel外面，直到
     * 我们切换标签页
	 * var tabs = new L5.TabPanel({
	 *     applyTo: 'my-tabs',
	 *     activeTab: 0,
	 *     deferredRender: false,
	 *     autoTabs: true
 	 * });
	 *
	 * 下面这些满足条件的奖杯转为标签页
	 * <div id="my-tabs">
	 * <div class="l-tab" title="Tab 1">A simple tab</div>
	 * <div class="l-tab" title="Tab 2">Another one</div>
     */
    autoTabs : false,
    /**
     * @private
     * @cfg {String} autoTabSelector 当autoTabs时true的时候有效。CSS选择器，用来查找满足autoTabs条件的标签。结合autoTabs
     * 使用，也就是说条件未必就是div且css是l-tab，我们可以自定义任何可以被L5.DomQuery.select接受的选择符（默认是'div.l-tab'）。
     */
    autoTabSelector:'div.l-tab',
    /**
     * @cfg {String/Number} activeTab 需要被激活的选项卡，可以是选项卡的ID也可以是index
     * (默认是第一个).
     */
    activeTab : 0,
    /**
     * @private
     * @cfg {Number} tabMargin 
     * 这个属性关系到滚动标签栏的像素计算（默认是2），假如css的margin改变就需要改变这个值，才能保证计算的正确。
     */
    tabMargin : 2,
    /**
     * @private
     * @cfg {Boolean} plain 如果是true渲染标签栏的时候不需要背景图片（默认是false）
     */
    plain: false,
    /**
     * @private
     * @cfg {Number} wheelIncrement 对于滚动栏来说，每次滚动需要滚动的像素值（默认是20）
     */
    wheelIncrement : 20,

    /**
     * This is a protected property used when concatenating tab ids to the TabPanel id for internal uniqueness.
     * It does not generally need to be changed, but can be if external code also uses an id scheme that can
     * potentially clash with this one.
     * @private
     */
    idDelimiter : '__',

    /**
     * @private
     */
    itemCls : 'l-tab-item',

    /**
     * @private
     */
    elements: 'body',
    headerAsText: false,
    frame: false,
    hideBorders:true,

    /**
     * @private
     * 初始化一些对象
     */
    initComponent : function(){
        this.frame = false;
        L5.TabPanel.superclass.initComponent.call(this);
        this.addEvents(
            /**
             * @event beforetabchange
             * Tab页改变之前触发时间，响应函数返回false阻止发生改变.
             * @param {TabPanel} this
             * @param {Panel} newTab 将被激活的页面
             * @param {Panel} currentTab 当前处于激活的页面
             */
            'beforetabchange',
            /**
             * @event tabchange
             * 当标签页发生改变的时候触发.
             * @param {TabPanel} this
             * @param {Panel} tab 刚被激活的页面
             */
            'tabchange',
            /**
             * @event contextmenu
             * TabPanel的页签的右键菜单事件.
             * @param {TabPanel} this
             * @param {Panel} tab 当前激活页
             * @param {EventObject} e
             */
            'contextmenu'
        );
        this.setLayout(new L5.layout.CardLayout({
            deferredRender: this.deferredRender
        }));
        if(this.tabPosition == 'top'){
            this.elements += ',header';
            this.stripTarget = 'header';
        }else {
            this.elements += ',footer';
            this.stripTarget = 'footer';
        }
        if(!this.stack){
            this.stack = L5.TabPanel.AccessStack();
        }
        this.initItems();
    },

    /**
     * @private
     * 渲染tabpanel，并设置当前活动的标签页
     */
    render : function(){
        L5.TabPanel.superclass.render.apply(this, arguments);
        if(this.activeTab !== undefined){
            var item = this.activeTab;
            delete this.activeTab;
            this.setActiveTab(item);
        }
    },

    /**
     * @private
     * 渲染tabpanel，操作dom，以及增加css和初始化数据
     */
    onRender : function(ct, position){
        L5.TabPanel.superclass.onRender.call(this, ct, position);

        if(this.plain){
            var pos = this.tabPosition == 'top' ? 'header' : 'footer';
            this[pos].addClass('l-tab-panel-'+pos+'-plain');
        }

        var st = this[this.stripTarget];

        this.stripWrap = st.createChild({cls:'l-tab-strip-wrap', cn:{
            tag:'ul', cls:'l-tab-strip l-tab-strip-'+this.tabPosition}});

        var beforeEl = (this.tabPosition=='bottom' ? this.stripWrap : null);
        this.stripSpacer = st.createChild({cls:'l-tab-strip-spacer'}, beforeEl);
        this.strip = new L5.Element(this.stripWrap.dom.firstChild);

        this.edge = this.strip.createChild({tag:'li', cls:'l-tab-edge'});
        this.strip.createChild({cls:'l-clear'});

        this.body.addClass('l-tab-panel-body-'+this.tabPosition);

        if(!this.itemTpl){
            var tt = new L5.Template(
                 '<li class="{cls}" id="{id}"><a class="l-tab-strip-close" onclick="return false;"></a>',
                 '<a class="l-tab-right" href="#" onclick="return false;"><em class="l-tab-left">',
                 '<span class="l-tab-strip-inner"><span class="l-tab-strip-text {iconCls}">{text}</span></span>',
                 '</em></a></li>'
            );
            tt.disableFormats = true;
            tt.compile();
            L5.TabPanel.prototype.itemTpl = tt;
        }

        this.items.each(this.initTab, this);
    },

    /**
     * @private
     * 有调用autoTabs的语句
     */
    afterRender : function(){
        L5.TabPanel.superclass.afterRender.call(this);
        if(this.autoTabs){
            this.readTabs(false);
        }
    },

    /**
     * @private
     * 初始化一些事件，用来管理tabpanel，监听动作做出反应
     */
    initEvents : function(){
        L5.TabPanel.superclass.initEvents.call(this);
        this.on('add', this.onAdd, this);
        this.on('remove', this.onRemove, this);

        this.strip.on('mousedown', this.onStripMouseDown, this);
        this.strip.on('contextmenu', this.onStripContextMenu, this);
        if(this.enableTabScroll){
            this.strip.on('mousewheel', this.onWheel, this);
        }
    },

    /**
     * @private
     */
    findTargets : function(e){
        var item = null;
        var itemEl = e.getTarget('li', this.strip);
        if(itemEl){
            item = this.getComponent(itemEl.id.split(this.idDelimiter)[1]);
            if(item.disabled){
                return {
                    close : null,
                    item : null,
                    el : null
                };
            }
        }
        return {
            close : e.getTarget('.l-tab-strip-close', this.strip),
            item : item,
            el : itemEl
        };
    },

    /**
     * @private
     */
    onStripMouseDown : function(e){
        if(e.button != 0){
            return;
        }
        e.preventDefault();
        var t = this.findTargets(e);
        if(t.close){
            if (t.item.fireEvent('beforeclose', t.item) !== false) {
                t.item.fireEvent('close', t.item);
                this.remove(t.item);
            }
            return;
        }
        if(t.item && t.item != this.activeTab){
            this.setActiveTab(t.item);
        }
    },

    /**
     * @private
     */
    onStripContextMenu : function(e){
        e.preventDefault();
        var t = this.findTargets(e);
        if(t.item){
            this.fireEvent('contextmenu', this, t.item, e);
        }
    },

    /**
     * 通过autoTabSelector定义的规则实现autoTabs的方法，用来将普通的标签转化成tab标签的
     * @private
     * @param {Boolean} removeExisting 如果是true就移除已经存在的tab页
     */
    readTabs : function(removeExisting){
        if(removeExisting === true){
            this.items.each(function(item){
                this.remove(item);
            }, this);
        }
        var tabs = this.el.query(this.autoTabSelector);
        for(var i = 0, len = tabs.length; i < len; i++){
            var tab = tabs[i];
            var title = tab.getAttribute('title');
            tab.removeAttribute('title');
            this.add({
                title: title,
                el: tab
            });
        }
    },

    /**
     * @private
     * 初始化tab页面，增加css属性增加监听方法
     */
    initTab : function(item, index){
        var before = this.strip.dom.childNodes[index];
        var cls = item.closable ? 'l-tab-strip-closable' : '';
        if(item.disabled){
            cls += ' l-item-disabled';
        }
        if(item.iconCls){
            cls += ' l-tab-with-icon';
        }
        if(item.tabCls){
            cls += ' ' + item.tabCls;
        }

        var p = {
            id: this.id + this.idDelimiter + item.getItemId(),
            text: item.title,
            cls: cls,
            iconCls: item.iconCls || ''
        };
        var el = before ?
                 this.itemTpl.insertBefore(before, p) :
                 this.itemTpl.append(this.strip, p);

        L5.fly(el).addClassOnOver('l-tab-strip-over');

        if(item.tabTip){
            L5.fly(el).child('span.l-tab-strip-text', true).qtip = item.tabTip;
        }
        item.tabEl = el;

        item.on('disable', this.onItemDisabled, this);
        item.on('enable', this.onItemEnabled, this);
        item.on('titlechange', this.onItemTitleChanged, this);
        item.on('iconchange', this.onItemIconChanged, this);
        item.on('beforeshow', this.onBeforeShowItem, this);
    },

    /**
     * @private
     */
    onAdd : function(tp, item, index){
        this.initTab(item, index);
        if(this.items.getCount() == 1){
            this.syncSize();
        }
        this.delegateUpdates();
    },

    /**
     * @private
     */
    onBeforeAdd : function(item){
        var existing = item.events ? (this.items.containsKey(item.getItemId()) ? item : null) : this.items.get(item);
        if(existing){
            this.setActiveTab(item);
            return false;
        }
        L5.TabPanel.superclass.onBeforeAdd.apply(this, arguments);
        var es = item.elements;
        item.elements = es ? es.replace(',header', '') : es;
        item.border = (item.border === true);
    },

    /**
     * @private
     */
    onRemove : function(tp, item){
        L5.destroy(L5.get(this.getTabEl(item)));
        this.stack.remove(item);
        item.un('disable', this.onItemDisabled, this);
        item.un('enable', this.onItemEnabled, this);
        item.un('titlechange', this.onItemTitleChanged, this);
        item.un('iconchange', this.onItemIconChanged, this);
        item.un('beforeshow', this.onBeforeShowItem, this);
        if(item == this.activeTab){
            var next = this.stack.next();
            if(next){
                this.setActiveTab(next);
            }else if(this.items.getCount() > 0){
                this.setActiveTab(0);
            }else{
                this.activeTab = null;
            }
        }
        this.delegateUpdates();
    },

    /**
     * @private
     */
    onBeforeShowItem : function(item){
        if(item != this.activeTab){
            this.setActiveTab(item);
            return false;
        }
    },

    /**
     * @private
     */
    onItemDisabled : function(item){
        var el = this.getTabEl(item);
        if(el){
            L5.fly(el).addClass('l-item-disabled');
        }
        this.stack.remove(item);
    },

    /**
     * @private
     */
    onItemEnabled : function(item){
        var el = this.getTabEl(item);
        if(el){
            L5.fly(el).removeClass('l-item-disabled');
        }
    },

    /**
     * @private
     */
    onItemTitleChanged : function(item){
        var el = this.getTabEl(item);
        if(el){
            L5.fly(el).child('span.l-tab-strip-text', true).innerHTML = item.title;
        }
    },
    
    //private
    onItemIconChanged: function(item, iconCls, oldCls){
        var el = this.getTabEl(item);
        if(el){
            L5.fly(el).child('span.l-tab-strip-text').replaceClass(oldCls, iconCls);
        }
    },

    /**
     * 从tab标签获取某个tab的DOM，可以通过索引或者组件本身
     * @param {Panel/Number} tab tab的索引或者tab里面的子组件
     * @return {HTMLElement} 返回tab的DOM元素
     */
    getTabEl : function(item){
        var itemId = (typeof item === 'number')?this.items.items[item].getItemId() : item.getItemId();
        return document.getElementById(this.id+this.idDelimiter+itemId);
    },

    /**
     * @private
     * 对resize事件做出反应
     */
    onResize : function(){
        L5.TabPanel.superclass.onResize.apply(this, arguments);
        this.delegateUpdates();
    },

    /**
     * 当进行批量处理的时候暂停任何的内部计算或者滚动，参考endUpdate
     * @private
     */
    beginUpdate : function(){
        this.suspendUpdates = true;
    },

    /**
     * @private
     * 恢复计算和滚动
     */
    endUpdate : function(){
        this.suspendUpdates = false;
        this.delegateUpdates();
    },

    /**
     * 隐藏tab标签选项卡。
     * @private
     * @param {Number/String/Panel} item tab标签的索引，或者id或者子组件对象
     */
    hideTabStripItem : function(item){
        item = this.getComponent(item);
        var el = this.getTabEl(item);
        if(el){
            el.style.display = 'none';
            this.delegateUpdates();
        }
        this.stack.remove(item);
    },

    /**
     * 取消隐藏tab标签选项卡。
     * @private
     * @param {Number/String/Panel} item tab标签的索引，或者id或者子组件对象
     */
    unhideTabStripItem : function(item){
        item = this.getComponent(item);
        var el = this.getTabEl(item);
        if(el){
            el.style.display = '';
            this.delegateUpdates();
        }
    },

    /**
     * @private
     */
    delegateUpdates : function(){
        if(this.suspendUpdates){
            return;
        }
        if(this.resizeTabs && this.rendered){
            this.autoSizeTabs();
        }
        if(this.enableTabScroll && this.rendered){
            this.autoScrollTabs();
        }
    },

    /**
     * @private
     */
    autoSizeTabs : function(){
        var count = this.items.length;
        var ce = this.tabPosition != 'bottom' ? 'header' : 'footer';
        var ow = this[ce].dom.offsetWidth;
        var aw = this[ce].dom.clientWidth;

        if(!this.resizeTabs || count < 1 || !aw){ // !aw for display:none
            return;
        }

        var each = Math.max(Math.min(Math.floor((aw-4) / count) - this.tabMargin, this.tabWidth), this.minTabWidth); // -4 for float errors in IE
        this.lastTabWidth = each;
        var lis = this.stripWrap.dom.getElementsByTagName('li');
        for(var i = 0, len = lis.length-1; i < len; i++) { // -1 for the "edge" li
            var li = lis[i];
            var inner = li.childNodes[1].firstChild.firstChild;
            var tw = li.offsetWidth;
            var iw = inner.offsetWidth;
            inner.style.width = (each - (tw-iw)) + 'px';
        }
    },

    /**
     * @private
     */
    adjustBodyWidth : function(w){
        if(this.header){
            this.header.setWidth(w);
        }
        if(this.footer){
            this.footer.setWidth(w);
        }
        return w;
    },

    /**
     * 激活某个选项卡.这个方法将激发{@link #beforetabchange}事件
     * 如果其响应函数返回false，将不会发生激活选项卡的动作.
     * @param {String/Panel} tab Panel的id或者Panel对象自身
     */
    setActiveTab : function(item){
        item = this.getComponent(item);
        var itemrender = item.rendered;
        if(!item || this.fireEvent('beforetabchange', this, item, this.activeTab) === false){
            return;
        }
        if(!this.rendered){
            this.activeTab = item;
            return;
        }
        if(this.activeTab != item){
            if(this.activeTab){
                var oldEl = this.getTabEl(this.activeTab);
                if(oldEl){
                    L5.fly(oldEl).removeClass('l-tab-strip-active');
                }
                this.activeTab.fireEvent('deactivate', this.activeTab);
            }
            var el = this.getTabEl(item);
            L5.fly(el).addClass('l-tab-strip-active');
            this.activeTab = item;
            this.stack.add(item);

            this.layout.setActiveItem(item);
            if((this.layoutOnTabChange||!itemrender) && item.doLayout){
                item.doLayout();
            }
            if(this.scrolling){
                this.scrollToTab(item, this.animScroll);
            }
            
            item.fireEvent('activate', item);
            this.fireEvent('tabchange', this, item);
        }
    },

    /**
     * 获取处于激活状态的Panel.
     * @return {Panel} 激活状态的Panel
     */
    getActiveTab : function(){
        return this.activeTab || null;
    },

    /**
     * 通过id获取标签页
     * @private
     * @param {String} id 标签页的id
     * @return {Panel} 返回符合条件的id
     */
    getItem : function(item){
        return this.getComponent(item);
    },

    /**
     * @private
     */
    autoScrollTabs : function(){
        this.pos = this.tabPosition=='bottom' ? this.footer : this.header;
        var count = this.items.length;
        var ow = this.pos.dom.offsetWidth;
        var tw = this.pos.dom.clientWidth;

        var wrap = this.stripWrap;
        var wd = wrap.dom;
        var cw = wd.offsetWidth;
        var pos = this.getScrollPos();
        var l = this.edge.getOffsetsTo(this.stripWrap)[0] + pos;

        if(!this.enableTabScroll || count < 1 || cw < 20){ // 20 to prevent display:none issues
            return;
        }
        if(l <= tw){
            wd.scrollLeft = 0;
            wrap.setWidth(tw);
            if(this.scrolling){
                this.scrolling = false;
                this.pos.removeClass('l-tab-scrolling');
                this.scrollLeft.hide();
                this.scrollRight.hide();
                if(L5.isAir || L5.isSafari){
                    wd.style.marginLeft = '';
                    wd.style.marginRight = '';
                }
            }
        }else{
            if(!this.scrolling){
                this.pos.addClass('l-tab-scrolling');
                if(L5.isAir || L5.isSafari){
                    wd.style.marginLeft = '18px';
                    wd.style.marginRight = '18px';
                }
            }
            tw -= wrap.getMargins('lr');
            wrap.setWidth(tw > 20 ? tw : 20);
            if(!this.scrolling){
                if(!this.scrollLeft){
                    this.createScrollers();
                }else{
                    this.scrollLeft.show();
                    this.scrollRight.show();
                }
            }
            this.scrolling = true;
            if(pos > (l-tw)){ // ensure it stays within bounds
                wd.scrollLeft = l-tw;
            }else{ // otherwise, make sure the active tab is still visible
                this.scrollToTab(this.activeTab, false);
            }
            this.updateScrollButtons();
        }
    },

    /**
     * @private
     */
    createScrollers : function(){
        this.pos.addClass('l-tab-scrolling-' + this.tabPosition);
        var h = this.stripWrap.dom.offsetHeight;

        // left
        var sl = this.pos.insertFirst({
            cls:'l-tab-scroller-left'
        });
        sl.setHeight(h);
        sl.addClassOnOver('l-tab-scroller-left-over');
        this.leftRepeater = new L5.util.ClickRepeater(sl, {
            interval : this.scrollRepeatInterval,
            handler: this.onScrollLeft,
            scope: this
        });
        this.scrollLeft = sl;

        // right
        var sr = this.pos.insertFirst({
            cls:'l-tab-scroller-right'
        });
        sr.setHeight(h);
        sr.addClassOnOver('l-tab-scroller-right-over');
        this.rightRepeater = new L5.util.ClickRepeater(sr, {
            interval : this.scrollRepeatInterval,
            handler: this.onScrollRight,
            scope: this
        });
        this.scrollRight = sr;
    },

    /**
     * @private
     */
    getScrollWidth : function(){
        return this.edge.getOffsetsTo(this.stripWrap)[0] + this.getScrollPos();
    },

    /**
     * @private
     */
    getScrollPos : function(){
        return parseInt(this.stripWrap.dom.scrollLeft, 10) || 0;
    },

    /**
     * @private
     */
    getScrollArea : function(){
        return parseInt(this.stripWrap.dom.clientWidth, 10) || 0;
    },

    /**
     * @private
     */
    getScrollAnim : function(){
        return {duration:this.scrollDuration, callback: this.updateScrollButtons, scope: this};
    },

    /**
     * @private
     */
    getScrollIncrement : function(){
        return this.scrollIncrement || (this.resizeTabs ? this.lastTabWidth+2 : 100);
    },

    /**
     * 滚动到特定的标签
     * @param {Panel/Number} item 要滚动到的标签的子组件或者索引
     * @param {Boolean} animate 是否有动画效果
     */
    scrollToTab : function(item, animate){
        if(!item){ return; }
        var el = this.getTabEl(item);
        var pos = this.getScrollPos(), area = this.getScrollArea();
        var left = L5.fly(el).getOffsetsTo(this.stripWrap)[0] + pos;
        var right = left + el.offsetWidth;
        if(left < pos){
            this.scrollTo(left, animate);
        }else if(right > (pos + area)){
            this.scrollTo(right - area, animate);
        }
    },

    /**
     * @private
     */
    scrollTo : function(pos, animate){
        this.stripWrap.scrollTo('left', pos, animate ? this.getScrollAnim() : false);
        if(!animate){
            this.updateScrollButtons();
        }
    },
    /**
     * @private
     */
    onWheel : function(e){
        var d = e.getWheelDelta()*this.wheelIncrement*-1;
        e.stopEvent();

        var pos = this.getScrollPos();
        var newpos = pos + d;
        var sw = this.getScrollWidth()-this.getScrollArea();

        var s = Math.max(0, Math.min(sw, newpos));
        if(s != pos){
            this.scrollTo(s, false);
        }
    },

    /**
     * @private
     */
    onScrollRight : function(){
        var sw = this.getScrollWidth()-this.getScrollArea();
        var pos = this.getScrollPos();
        var s = Math.min(sw, pos + this.getScrollIncrement());
        if(s != pos){
            this.scrollTo(s, this.animScroll);
        }
    },

    /**
     * @private
     */
    onScrollLeft : function(){
        var pos = this.getScrollPos();
        var s = Math.max(0, pos - this.getScrollIncrement());
        if(s != pos){
            this.scrollTo(s, this.animScroll);
        }
    },

    /**
     * @private
     */
    updateScrollButtons : function(){
        var pos = this.getScrollPos();
        if(this.scrollLeft)
        	this.scrollLeft[pos == 0 ? 'addClass' : 'removeClass']('l-tab-scroller-left-disabled');
        if(this.scrollRight)
        	this.scrollRight[pos >= (this.getScrollWidth()-this.getScrollArea()) ? 'addClass' : 'removeClass']('l-tab-scroller-right-disabled');
    },

    /**
     * @private
     */
    beforeDestroy : function() {
        if(this.items){
            this.items.each(function(item){
                if(item && item.tabEl){
                    L5.get(item.tabEl).removeAllListeners();
                    item.tabEl = null;
                }
            }, this);
        }
        if(this.stack){
        	this.stack.clear();
        }
        if(this.strip){
            this.strip.removeAllListeners();
        }
        L5.TabPanel.superclass.beforeDestroy.apply(this);
    }

    /**
     * @private
     * @cfg {Boolean} collapsible
     * @hide
     */
    /**
     * @cfg {String} header
     * @hide
     */
    /**
     * @private
     * @cfg {Boolean} headerAsText
     * @hide
     */
    /**
     * @private
     * @property header
     * @hide
     */
    /**
     * @private
     * @property title
     * @hide
     */
    /**
     * @private
     * @cfg {Array} tools
     * @hide
     */
    /**
     * @private
     * @cfg {Boolean} hideCollapseTool
     * @hide
     */
    /**
     * @private
     * @cfg {Boolean} titleCollapse
     * @hide
     */
    /**
     * @private
     * @cfg {Boolean} collapsed
     * @hide
     */
    /**
     * @private
     * @cfg {String} layout
     * @hide
     */
    /**
     * @private
     * @cfg {Object} layoutConfig
     * @hide
     */

});
L5.reg('tabpanel', L5.TabPanel);

/**
 * setActiveTab的简写，激活某个选项卡.这个方法将激发{@link #beforetabchange}事件
 * 如果其响应函数返回false，将不会发生激活选项卡的动作.
 * @param {String/Panel} tab Panel的id或者Panel对象自身
 */
L5.TabPanel.prototype.activate = L5.TabPanel.prototype.setActiveTab;

/**
 * @private
 * 私有的工具类，只被L5.TabPanel使用
 */
L5.TabPanel.AccessStack = function(){
    var items = [];
    return {
        add : function(item){
            items.push(item);
            if(items.length > 10){
                items.shift();
            }
        },

        remove : function(item){
            var s = [];
            for(var i = 0, len = items.length; i < len; i++) {
                if(items[i] != item){
                    s.push(items[i]);
                }
            }
            items = s;
        },
        clear:function(){
        	items.length=0;
        },
        next : function(){
            return items.pop();
        }
    };
};

