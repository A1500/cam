/**
 * @class L5.Panel
 * @extends L5.Container
 * @param {Object} config 配置Panel的一些初始化属性。
 * Panel是最基本的一个容器组件，它可以有top,body,bottom等位置放置按钮或者HTML元素
 * 同时它也是布局或者其它容器的基本组成部分，它是使用最广泛的组件。
 */
L5.Panel = L5.extend(L5.Container, {
    /**
     * Panel的头部，是Element类型元素，只读属性.
     * <p>头部可以包含标题(title)，但是标题一般通过方法setTitle(string)重新设置</p>
     * @type L5.Element
     * @property header
     */
    /**
     * Panel的body可以包含HTML元素.
     * @type L5.Element
     * @property body
     */
   
    /**
     * Panel的title
     * @type String
     * @property title 
     */
    /**
     * @private
     * @cfg {Array} buttons
     * L5.Button的数组或者L5.Button的配置参数的数组
     */
    /**
     * @ignore
     * @cfg {Object/String/Function} autoLoad
     * panel会通过Updater中的方法L5.Updater.update调用一个有效的url，更新panel里面的内容，URL将变成该panel的默认的url，方便随时刷新
     */
    /**
     * @cfg {Boolean} frame
     * 设置true的话，则使用特殊的borer样式,否则的话使用1px的border(默认是false).
     */
    /**
     * @cfg {Boolean} border
     * 设置true的话，则有1px的border,否则隐藏border(默认是true).
     */
    /**
     * @private
     * @cfg {Boolean} bodyBorder
     * 如果是true就会显示panel的body部分的边框，false就会隐藏（默认是true）。这个属性依赖border属性，只有当border是true的时候
     * 才起作用。假如border == true 同时 bodyBorder == false,那么border将会有1px的边框宽度，
     */
    /**
     * @private
     * @cfg {String/Object/Function} bodyStyle
     * 为panel的body自定义CSS样式，格式必须符合L5.Element.applyStyles的标准（默认是null）
     */
    /**
     * @private
     * @cfg {String} iconCls
     * 一个css样式，提供一个供头部图标使用的背景图片（默认是 ''），可以自定义，例如：
     * .my-icon { background: url(../images/my-icon.gif) 0 6px no-repeat !important;}
     */
    /**
     * @cfg {Boolean} collapsible
     * 设置true可以使Panel伸缩展开并且有伸缩展开按钮在header的右边，否则不具有该功能。
     * (默认是false).
     */
    /**
     * @private
     * @cfg {Array} tools
     * 一个工具按钮的数组，这些按钮可以添加到头部的工具栏区域，当渲染的时候，每个工具都会被包装成一个L5.Element对象，
     * id属性是表示工具的具体样式采用，可以支持的id有效值如下：
     * <li><tt>toggle</tt> 当collapsible是true的时候自动创建</li>
     * <li><tt>close</tt></li>
     * <li><tt>minimize</tt></li>
     * <li><tt>maximize</tt></li>
     * <li><tt>restore</tt></li>
     * <li><tt>gear</tt></li>
     * <li><tt>pin</tt></li>
     * <li><tt>unpin</tt></li>
     * <li><tt>right</tt></li>
     * <li><tt>left</tt></li>
     * <li><tt>up</tt></li>
     * <li><tt>down</tt></li>
     * <li><tt>refresh</tt></li>
     * <li><tt>minus</tt></li>
     * <li><tt>plus</tt></li>
     * <li><tt>help</tt></li>
     * <li><tt>search</tt></li>
     * <li><tt>save</tt></li>
     * <li><tt>print</tt></li>
     * </ul></div></li>
     * 其他属性如下：
     * <li><b>handler</b> : 当点击图标的时候调用的方法，传递的参数包括：
     * 				<li><b>event</b> : L5.EventObject：点击事件.</div></li>
     * 				<li><b>toolEl</b> : L5.Element：工具Element</div></li>
     * 				<li><b>Panel</b> : L5.Panel：所属的panel</div></li>
     * </ul></div></li>
     * <li><b>scope</b> : 回调方法的作用域.</div></li>
     * <li><b>qtip</b> {String/Object}：快捷提示</div></li>
     * <li><b>hidden</b>  {Boolean}: 是否隐藏.</div></li>
     * <li><b>on</b> : {Object}：增加监听器</li>
     * </ul></div>
     * 例子：
     * tools:[{
     * id:'refresh',
     * qtip: 'Refresh form Data',
     * // hidden:true,
     *  handler: function(event, toolEl, panel){
     *     // refresh logic
     * }
     * }]
     * 
	 * tools:[{
	 *     id:'refresh',
	 *     qtip: 'Refresh form Data',
	 *     // hidden:true,
	 *     handler: function(event, toolEl, panel){
	 *         // refresh logic
	 *     }
	 * }]
	 * 主意：添加工具只是添加了按钮，如果想要实现功能还必须要自己去写实现的方法
     */
    /**
     * @ignore
     * @cfg {Boolean} hideCollapseTool
     * 当collapsible时true的时候，如果是true就隐藏展开/收起按钮，false就会显示（默认是false）
     */
    /**
     * @ignore
     * @cfg {Boolean} titleCollapse
     * 当collapsible=true的时候，如果是true就会点击title任意一个地方的时候都会收起/展开panel
     */
    /**
     * @cfg {Boolean} autoScroll
     * 设置true则Panel的body会使用overflow:'auto'，当高度不够的时候会自动出现滚动条。
     * (默认是true).
     */
    /**
     * @private
     * @cfg {Boolean/Object} floating
     * 如果是true，panel有悬浮效果，默认是false。注意：默认情况下，如果设置成floating是true，将引起panel负便宜导致panel隐藏
     * ，因为panel是绝对位置，这个位置应该是再渲染完后设置的。因此当悬浮panel的时候需要总是设置宽度，否则就会自动充满父容器.
     * 如果是Object，将会出现悬浮效果，并且这个object将会作为panel浮动效果层对象创建的配置项，可以设置zindex，等
     */
    /**
     * @cfg {Boolean/String} shadow @hide
     * 如果是true（或者是有效的阴影效果值如'sides'）就会显示panel的阴影效果（默认是'sides'）。前提是floating = true.
     */
    /**
     * @cfg {Number} shadowOffset @hide
     * 阴影与panel的偏离像素值，紧紧当 floating = true.的时候起作用
     */
    /**
     * @ignore
     * @cfg {Boolean} shim
     * false的时候在浏览器禁用iframe（默认是true）。注意当floating = true的时候shim才起作用
     */
    /**
     * @ignore
     * @cfg {String/Object} html
     * 一个HTML片段或者是符合L5.DomHelper规范的配置，这些被用来当做panel的主体内容。HTML片段被afterRender加载到body上，
     * 所以当panel发出render事件的时候，document并未包含这些HTML。（事件在afterRender之前）。
     */
    /**
     * @private
     * @cfg {String} contentEl
     * 用已存在的HTML代码当做panel的body内容部分，contentEl是这些HTML的id，这个特殊的元素被afterRender增加到
     * panel的body上。所以当panel发出render事件的时候，document并未包含这些HTML。（事件在afterRender之前）。
     */
    /**
     * @private
     * @cfg {Object/Array} keys
     * 一个KeyMap配置对象（格式参考L5.KeyMap.addBinding）用来处理panel里面的自定义键
     */
     /**
      * @private
       * @cfg {Boolean} draggable
       * 如果是true，就允许拖动panel（默认是false），，可以通过配置L5.Panel.DD来实现drag/drop的抽象接口，例如：
       * new L5.Panel({
       *     title: 'Drag me',
       *     x: 100,
       *     y: 100,
       *     renderTo: L5.getBody(),
       *     floating: true,
       *     frame: true,
       *     width: 400,
       *     height: 200,
       *     draggable: {
       * //      Config option of L5.Panel.DD class.
       * //      It's a floating Panel, so do not show a placeholder proxy in the original position.
       *         insertProxy: false,
       * 
       * //      Called for each mousemove event while dragging the DD object.
       *         onDrag : function(e){
       * //          Record the x,y position of the drag proxy so that we can
       * //          position the Panel at end of drag.
       *             var pel = this.proxy.getEl();
       *             this.x = pel.getLeft(true);
       *             this.y = pel.getTop(true);
       * 
       * //          Keep the Shadow aligned if there is one.
       *             var s = this.panel.getEl().shadow;
       *             if (s) {
       *                 s.realign(this.x, this.y, pel.getWidth(), pel.getHeight());
       *             }
       *        },
       * 
       * //      Called on the mouseup event.
       *         endDrag : function(e){
       *           this.panel.setPosition(this.x, this.y);
       *        }
       *     }
       * }).show();
       */
    /**
       * @cfg {String} tabTip
       * 当Panel作为TabPanel的一部分的时候，设置此属性当鼠标移动到其title上的时候会显示提示。
       * 如果需要使用此功能L5.QuickTips.init()必须先执行.
       */
    /**
     * @private
     * @cfg {Boolean} disabled
     * 如果是true渲染完后panel将是不可用状态（默认是false）。当使用disabled这个配置参数的时候，ie在初始化的时候如果布局还未结束
     * 并且在渲染过程中panel是不可用状态，那么标记panel里面元素不可用的时候一般将会出错，假如遇到该问题，需要在布局完成后（发生
     * afterlayout事件后）再调用disable方法，例如：
	 * new L5.Panel({
	 *     ...
	 *     listeners: {
	 *         'afterlayout': {
	 *             fn: function(p){
	 *                 p.disable();
	 *             },
	 *             single: true // important, as many layouts can occur
	 *         }
	 *     }
	 * });
     */
    /**
     * @cfg {Boolean} autoHeight
     * 设置true，相当于设置height:"auto"; 
     */

    /**
     * @ignore
    * @cfg {String} baseCls
    * panel里面的元素的基本的css样式（默认是'l-panel').
    */
    baseCls : 'l-panel',
    /**
     * @ignore
    * @cfg {String} collapsedCls
    * 当panel收起的时候为里面子元素增加的CSS样式（默认是'l-panel-collapsed'）
    */
    collapsedCls : 'l-panel-collapsed',
    /**
     * @private
    * @cfg {Boolean} maskDisabled
    * 如果是true，当panel不可用的时候会被标记，如果是false就不会被标记（默认是true）。无论是哪种模式，当面板不可用时总是话通知
    * 面板里面的元素不可用，但是如果标记不可用将呈现出不同的视觉效果（不可用的视觉效果）。
    */
    maskDisabled: true,
    /**
     * @private
    * @cfg {Boolean} animCollapse
    * 如果是true收起的时候就会展示动画效果，如果是false就不会有动画效果(假如L5.Fx可用默认就是true，参考L5.enableFx，否则是false）
    */
    animCollapse: L5.enableFx,
    /**
     * @private
     * @cfg {Boolean} headerAsText
     * 如果是true标题就会显示在panel的头部，如果是false就会隐藏标题（默认是true）
     */
    headerAsText: true,
    /**
     * @private
    * @cfg {String} buttonAlign
    * 当按钮被添加到panel的时候位置。有效值：'right' , 'left' , 'center' （默认是右边）
    */
    buttonAlign: 'right',
    /**
     * @private
     * @cfg {Boolean} collapsed
     * 如果是true，渲染完了panel后是收起的，如果是false渲染完后是展开的（默认是false）
     */
    collapsed : false,
    /**
     * @private
     * @cfg {Boolean} collapseFirst
     * 如果是true就确保展开/收起按钮总是第一个被渲染的，false就不能确保最先被渲染（默认是true）
     */
    collapseFirst: true,
    /**
     * @ignore
     * @cfg {Number} minButtonWidth
     * panel里面的按钮的最小值是75px
     */
    minButtonWidth:75,
    /**
     * @ignore
     * @private
     * @cfg {String} elements
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
     * 默认已经有 'body'.
     */
    elements : 'body',

    /**
     * @ignore
     * @private
     * 这个属性可以用来自定义窗口的一些特性，但是如果修改它可能导致意外或不良后果。
     */
    toolTarget : 'header',
    collapseEl : 'bwrap',
    slideAnchor : 't',
    disabledClass: '',
    autoScroll:false,
    /**
     * @private
     */
    deferHeight: true,
    /**
     * @private
     */
    expandDefaults: {
        duration:.25
    },
    /**
     * @private
     */
    collapseDefaults: {
        duration:.25
    },
    toggleIconCls : "l-tool",
    /**
     * @private
     */ 
    initComponent : function(){
        L5.Panel.superclass.initComponent.call(this);
        this.addEvents(
            /**
             * @ignore
             * @event bodyresize
             * @description 当panel的大小发生变化的时候触发
             * @param {L5.Panel} p panel本身
             * @param {Number} width 新的宽度
             * @param {Number} height 新的高度.
             */
            'bodyresize',
            /**
             * @ignore
             * @event titlechange
             * @description 当panel的标题改变的时候触发
             * @param {L5.Panel} p panel本身
             * @param {String} The 新的标题
             */
            'titlechange',
            /**
             * @ignore
             * @event iconchange
             * @description 当panel图标CSS样式更换的时候触发 
             * @param {L5.Panel} p 变换图标的panel本身
             * @param {String} The 新的图标css
             * @param {String} The 就的图标css
             */
            'iconchange',
            /**
             * @event collapse
             * 当Panel收缩的时候触发事件.
             * @param {L5.Panel} p 当前Panel.
             */
            'collapse',
            /**
             * @event expand
             * 当Panel展开的时候触发事件.
             * @param {L5.Panel} p 当前Panel.
             */
            'expand',
            /**
             * @ignore
             * @event beforecollapse
             * @description 在panel收起之前触发，如果返回false就不收起
             * @param {L5.Panel} p 要展开的panel
             * @param {Boolean} animate 是否带偶动画效果.
             */
            'beforecollapse',
            /**
             * @ignore
             * @event beforeexpand
             * @description 当panel展开之前触发，如果返回false就停止展开
             * @param {L5.Panel} p 要展开的panel
             * @param {Boolean} animate 是否带偶动画效果.
             */
            'beforeexpand',
            /**
             * @ignore
             * @event beforeclose
             * Panel被关闭前触发(例如 {@link L5.Window}).当响应函数返回false的时候阻止关闭.
             * @param {L5.Panel} p 当前Panel.
             */
            'beforeclose',
            /**
             * @event close
             * Panel被关闭的时候触发(例如 {@link L5.Window}).
             * @param {L5.Panel} p 当前Panel.
             */
            'close',
            /**
             * @event activate
             * 当前Panel处于激活状态的时候触发.
             * @param {L5.Panel} p 当前Panel.
             */
            'activate',
            /**
             * @event deactivate
             * 当前Panel处于非激活状态的时候触发.
             * @param {L5.Panel} p 当前Panel.
             */
            'deactivate',
            /**
             * @event beforebinding
             * 绑定之前触发事件
             * 
             */
            'beforebinding',
            /**
             * @event paramchange
             * widget自定义事件，自身参数改变的时候触发
             */
            'paramchange',
            /**
             * @event paramchange
             * widget自定义事件，widget之间发送消息的时候触发
             */
            'message'
        );

        // shortcuts
        if(this.tbar){
            this.elements += ',tbar';
            if(typeof this.tbar == 'object'){
                this.topToolbar = this.tbar;
            }
            delete this.tbar;
        }
        if(this.bbar){
            this.elements += ',bbar';
            if(typeof this.bbar == 'object'){
                this.bottomToolbar = this.bbar;
            }
            delete this.bbar;
        }

        if(this.header === true){
            this.elements += ',header';
            delete this.header;
        }else if(this.title && this.header !== false){
            this.elements += ',header';
        }

        if(this.footer === true){
            this.elements += ',footer';
            delete this.footer;
        }

        if(this.buttons){
            var btns = this.buttons;
            /**
             * panel的按钮数组
             * @ignore
             * @type Array
             * @property buttons
             */
            this.buttons = [];
            for(var i = 0, len = btns.length; i < len; i++) {
                if(btns[i].render){ // button instance
                    btns[i].ownerCt = this;
                    this.buttons.push(btns[i]);
                }else{
                    this.addButton(btns[i]);
                }
            }
        }
        if(this.autoLoad){
            this.on('render', this.doAutoLoad, this, {delay:10});
        }
    },

    /**
     * @private
     * 为当前panel创建元素（L5.Element），同时根据名称增加对应的css样式
     * @param {String} 要创建的元素的名称
     * @param {DOM} 新创建的节点的父节点
     */
    createElement : function(name, pnode){
        if(this[name]){
            pnode.appendChild(this[name].dom);
            return;
        }

        if(name === 'bwrap' || this.elements.indexOf(name) != -1){
            if(this[name+'Cfg']){
                this[name] = L5.fly(pnode).createChild(this[name+'Cfg']);
            }else{
                var el = document.createElement('div');
                el.className = this[name+'Cls'];
                this[name] = L5.get(pnode.appendChild(el));
            }
            if(this[name+'CssClass']){
                this[name].addClass(this[name+'CssClass']);
            }
            if(this[name+'Style']){
                this[name].applyStyles(this[name+'Style']);
            }
        }
    },

    /**
     * @private
     * 当组件渲染的时候调用，主要是初始化组件内部的小组件以及增加样式等
     */
    onRender : function(ct, position){
        L5.Panel.superclass.onRender.call(this, ct, position);

        this.createClasses();

        if(this.el){ // existing markup
            this.el.addClass(this.baseCls);
            this.header = this.el.down('.'+this.headerCls);
            this.bwrap = this.el.down('.'+this.bwrapCls);
            var cp = this.bwrap ? this.bwrap : this.el;
            this.tbar = cp.down('.'+this.tbarCls);
            this.body = cp.down('.'+this.bodyCls);
            this.bbar = cp.down('.'+this.bbarCls);
            this.footer = cp.down('.'+this.footerCls);
            this.fromMarkup = true;
        }else{
            this.el = ct.createChild({
                id: this.id,
                cls: this.baseCls
            }, position);
        }
        var el = this.el, d = el.dom;

        if(this.cls){
            this.el.addClass(this.cls);
        }

        if(this.buttons){
            this.elements += ',footer';
        }

        // This block allows for maximum flexibility and performance when using existing markup

        // framing requires special markup
        if(this.frame){
            el.insertHtml('afterBegin', String.format(L5.Element.boxMarkup, this.baseCls));

            this.createElement('header', d.firstChild.firstChild.firstChild);
            this.createElement('bwrap', d);

            // append the mid and bottom frame to the bwrap
            var bw = this.bwrap.dom;
            var ml = d.childNodes[1], bl = d.childNodes[2];
            bw.appendChild(ml);
            bw.appendChild(bl);

            var mc = bw.firstChild.firstChild.firstChild;
            this.createElement('tbar', mc);
            this.createElement('body', mc);
            this.createElement('bbar', mc);
            this.createElement('footer', bw.lastChild.firstChild.firstChild);

            if(!this.footer){
                this.bwrap.dom.lastChild.className += ' l-panel-nofooter';
            }
        }else{
            this.createElement('header', d);
            this.createElement('bwrap', d);

            // append the mid and bottom frame to the bwrap
            var bw = this.bwrap.dom;
            this.createElement('tbar', bw);
            this.createElement('body', bw);
            this.createElement('bbar', bw);
            this.createElement('footer', bw);

            if(!this.header){
                this.body.addClass(this.bodyCls + '-noheader');
                if(this.tbar){
                    this.tbar.addClass(this.tbarCls + '-noheader');
                }
            }
        }

        if(this.border === false){
            this.el.addClass(this.baseCls + '-noborder');
            this.body.addClass(this.bodyCls + '-noborder');
            if(this.header){
                this.header.addClass(this.headerCls + '-noborder');
            }
            if(this.footer){
                this.footer.addClass(this.footerCls + '-noborder');
            }
            if(this.tbar){
                this.tbar.addClass(this.tbarCls + '-noborder');
            }
            if(this.bbar){
                this.bbar.addClass(this.bbarCls + '-noborder');
            }
        }

        if(this.bodyBorder === false){
           this.body.addClass(this.bodyCls + '-noborder');
        }

        this.bwrap.enableDisplayMode('block');

        if(this.header){
            this.header.unselectable();
            this.header.dom.align="left";
            // for tools, we need to wrap any existing header markup
            if(this.headerAsText){
                this.header.dom.innerHTML =
                    '<span class="' + this.headerTextCls + '">'+this.header.dom.innerHTML+'</span>';

                if(this.iconCls){
                    this.setIconClass(this.iconCls);
                }
            }
        }

        if(this.floating){
            this.makeFloating(this.floating);
        }

        if(this.collapsible){
            this.tools = this.tools ? this.tools.slice(0) : [];
            if(!this.hideCollapseTool){
                this.tools[this.collapseFirst?'unshift':'push']({
                    id: 'toggle',
                    handler : this.toggleCollapse,
                    scope: this
                });
            }
            if(this.titleCollapse && this.header){
                this.header.on('click', this.toggleCollapse, this);
                this.header.setStyle('cursor', 'pointer');
            }
        }
        if(this.tools){
            var ts = this.tools;
            this.tools = {};
            this.addTool.apply(this, ts);
        }else{
            this.tools = {};
        }

        if(this.buttons && this.buttons.length > 0){
            // tables are required to maintain order and for correct IE layout
            var tb = this.footer.createChild({cls:'l-panel-btns-ct', cn: {
                cls:"l-panel-btns l-panel-btns-"+this.buttonAlign,
                html:'<table cellspacing="0"><tbody><tr></tr></tbody></table><div class="l-clear"></div>'
            }}, null, true);
            var tr = tb.getElementsByTagName('tr')[0];
            for(var i = 0, len = this.buttons.length; i < len; i++) {
                var b = this.buttons[i];
                var td = document.createElement('td');
                td.className = 'l-panel-btn-td';
                b.render(tr.appendChild(td));
            }
        }

        if(this.tbar && this.topToolbar){
            if(L5.isArray(this.topToolbar)){
                this.topToolbar = new L5.Toolbar(this.topToolbar);
            }
            this.topToolbar.render(this.tbar);
            this.topToolbar.ownerCt = this;
        }
        if(this.bbar && this.bottomToolbar){
            if(L5.isArray(this.bottomToolbar)){
                this.bottomToolbar = new L5.Toolbar(this.bottomToolbar);
            }
            if(!this.isGrid){
            	this.bottomToolbar.render(this.bbar);
            	this.bottomToolbar.ownerCt = this;
            }
        }
    },

    /**
     * 设置图标的CSS样式，假如已经有CSS样式，将被替换掉
     * @param {String} cls 新的图标CSS样式
     */
    setIconClass : function(cls){
        var old = this.iconCls;
        this.iconCls = cls;
        if(this.rendered && this.header){
            if(this.frame){
                this.header.addClass('l-panel-icon');
                this.header.replaceClass(old, this.iconCls);
            }else{
                var hd = this.header.dom;
                var img = hd.firstChild && String(hd.firstChild.tagName).toLowerCase() == 'img' ? hd.firstChild : null;
                if(img){
                    L5.fly(img).replaceClass(old, this.iconCls);
                }else{
                    L5.DomHelper.insertBefore(hd.firstChild, {
                        tag:'img', src: L5.BLANK_IMAGE_URL, cls:'l-panel-inline-icon '+this.iconCls
                    });
                 }
            }
        }
        this.fireEvent('iconchange', this, cls, old);
    },

    /**
     * @private
     * 为组件增加悬浮效果
     */
    makeFloating : function(cfg){
        this.floating = true;
        this.el = new L5.Layer(
            typeof cfg == 'object' ? cfg : {
                shadow: this.shadow !== undefined ? this.shadow : 'sides',
                shadowOffset: this.shadowOffset,
                constrain:false,
                shim: this.shim === false ? false : undefined
            }, this.el
        );
    },

    /**
     * 获取顶部的toolbar（topToolbar）
     * @private
     * @return {L5.Toolbar} The toolbar
     */
    getTopToolbar : function(){
        return this.topToolbar;
    },

    /**
     * 获取底部的toolbar（bottomToolbar）
     * @private
     * @return {L5.Toolbar} 返回toolbar
     */
    getBottomToolbar : function(){
        return this.bottomToolbar;
    },

    /**
     * @private
     * 为组件增加按钮，此方法必须在渲染之前调用，通过按钮的配置参数添加按钮
     * @param {String/Object} config 有效的L5.Button配置参数，如果是string就被当做是按钮上的文本，如果是object就会被当做是按钮的配置对象
     * @param {Function} handler 当按钮被点击的时候调用的方法
     * @param {Object} scope被调用方法的作用域
     * @return {L5.Button} 返回添加的按钮
     */
    addButton : function(config, handler, scope){
        var bc = {
            handler: handler,
            scope: scope,
            minWidth: this.minButtonWidth,
            hideParent:true
        };
        if(typeof config == "string"){
            bc.text = config;
        }else{
            L5.apply(bc, config);
        }
        var btn = new L5.Button(bc);
        btn.ownerCt = this;
        if(!this.buttons){
            this.buttons = [];
        }
        this.buttons.push(btn);
        return btn;
    },

    /**
     * @private
     * 为组件增加工具，同时管理小工具样式变化
     */
    addTool : function(){
        if(!this[this.toolTarget]) { // no where to render tools!
            return;
        }
        if(!this.toolTemplate){
            // initialize the global tool template on first use
            var tt = new L5.Template(
//                 '<div class="l-tool l-tool-{id}">&#160;</div>'
            		'<div class="l-tool '+this.toggleIconCls+'-{id}">&#160;</div>'
            );
            tt.disableFormats = true;
            tt.compile();
            L5.Panel.prototype.toolTemplate = tt;
        }
        for(var i = 0, a = arguments, len = a.length; i < len; i++) {
            var tc = a[i];
            if(!this.tools[tc.id]){
	            var overCls = this.toggleIconCls+'-'+tc.id+'-over';
	            var t = this.toolTemplate.insertFirst((tc.align !== 'left') ? this[this.toolTarget] : this[this.toolTarget].child('span'), tc, true);
	            this.tools[tc.id] = t;
	            t.enableDisplayMode('block');
	            t.on('click', this.createToolHandler(t, tc,overCls, this));
	            if(tc.on){
	                t.on(tc.on);
	            }
	            if(tc.hidden){
	                t.hide();
	            }
	            if(tc.qtip){
	                if(typeof tc.qtip == 'object'){
	                    L5.QuickTips.register(L5.apply({
	                          target: t.id
	                    }, tc.qtip));
	                } else {
	                    t.dom.qtip = tc.qtip;
	                }
	            }
	            t.addClassOnOver(overCls);
            }
        }
    },

    /**
     * @private
     */
    onShow : function(){
        if(this.floating){
            return this.el.show();
        }
        L5.Panel.superclass.onShow.call(this);
    },

    /**
     * @private
     */
    onHide : function(){
        if(this.floating){
            return this.el.hide();
        }
        L5.Panel.superclass.onHide.call(this);
    },

    /**
     * @private
     * 创建回调方法
     */
    createToolHandler : function(t, tc, overCls, panel){
        return function(e){
            t.removeClass(overCls);
            e.stopEvent();
            if(tc.handler){
                tc.handler.call(tc.scope || t, e, t, panel);
            }
        };
    },

    /**
     * @private
     * render最后调用，主要是更新panel的内容，进行数据绑定收缩展开等
     */
    afterRender : function(){
        if(this.fromMarkup && this.height === undefined && !this.autoHeight){
            this.height = this.el.getHeight();
        }
        if(this.floating && !this.hidden && !this.initHidden){
            this.el.show();
        }
        if(this.title){
            this.setTitle(this.title);
        }
        this.setAutoScroll();
        if(this.html){
            this.body.update(typeof this.html == 'object' ?
                             L5.DomHelper.markup(this.html) :
                             this.html);
          	this.fireEvent('beforebinding',this.body.dom,this);                   
           
            var dom = this.body.dom;
            if(L5.DomQuery.selectNode("*[@dataset]", dom) != null){
            	L5.bindingdata(dom);
            }
            
            delete this.html;
        }
        if(this.contentEl){
            var ce = L5.getDom(this.contentEl);
            L5.fly(ce).removeClass(['l-hidden', 'l-hide-display']);
            this.body.dom.appendChild(ce);
        }
        if(this.collapsed){
            this.collapsed = false;
            this.collapse(false);
        }
        L5.Panel.superclass.afterRender.call(this); // do sizing calcs last
        this.initEvents();
    },

    /**
     * @private
     * 设置滚动条，受初始化参数autoScroll的制约
     */
    setAutoScroll : function(){
        if(this.rendered && this.autoScroll){
            var el = this.body || this.el;
            if(el){
                el.setOverflow('auto');
            }
        }
    },

    /**
     * @private
     * 获取一个keyMap对象，方便对按键操作
     */
    getKeyMap : function(){
        if(!this.keyMap){
            this.keyMap = new L5.KeyMap(this.el, this.keys);
        }
        return this.keyMap;
    },

    /**
     * @private
     */
    initEvents : function(){
        if(this.keys){
            this.getKeyMap();
        }
        if(this.draggable){
            this.initDraggable();
        }
    },

   /**
    * @ignore
    * @private
    * 初始化panel的拖动，假如panel配置了draggable属性，该属性将包含一个L5.dd.DragSource的实例，该实例处理panel的拖动操作。
    * 开发人员必须实现抽象类L5.dd.DragSource的抽象方法才能支持拖动动作处理
    */
    initDraggable : function(){
        /**
         * @ignore
         * 假如panel配置了draggable属性，该属性将包含一个L5.dd.DragSource的实例，该实例处理panel的拖动操作。
         * 开发人员必须实现抽象类L5.dd.DragSource的抽象方法才能支持拖动动作处理
         * @type L5.dd.DragSource.
         * @property dd
         */
        this.dd = new L5.Panel.DD(this, typeof this.draggable == 'boolean' ? null : this.draggable);
    },

    /**
     * @private
     */
    beforeEffect : function(){
        if(this.floating){
            this.el.beforeAction();
        }
        this.el.addClass('l-panel-animated');
    },

    /**
     * @private
     */
    afterEffect : function(){
        this.syncShadow();
        this.el.removeClass('l-panel-animated');
    },

    /**
     * @private
     * 内部包装了一个回调动画参数
     */
    createEffect : function(a, cb, scope){
        var o = {
            scope:scope,
            block:true
        };
        if(a === true){
            o.callback = cb;
            return o;
        }else if(!a.callback){
            o.callback = cb;
        }else { // wrap it up
            o.callback = function(){
                cb.call(scope);
                L5.callback(a.callback, a.scope);
            };
        }
        return L5.applyIf(o, a);
    },

    /**
     * 收起panel的主体部分，触发beforecollapse事件如果返回false就会终止收起动作。
     * 注意：这个操作会引起状态更改，这个更改是异步的，所以如果紧接着调用expand方法可能不会起到作用。
     * 例如：p.collapse();p.expand();不会出现panel收缩然后立即展开的效果，最后结果就是panel收缩了。
     * @param {Boolean} animate 是否需要动画效果（默认值参考animCollapse这个配置参数）
     * @return {L5.Panel} 返回panel本身
     */
    collapse : function(animate){
        if(this.collapsed || this.el.hasFxBlock() || this.fireEvent('beforecollapse', this, animate) === false){
            return;
        }
        var doAnim = animate === true || (animate !== false && this.animCollapse);
        this.beforeEffect();
        this.onCollapse(doAnim, animate);
        return this;
    },

    /**
     * @private
     */
    onCollapse : function(doAnim, animArg){
        if(doAnim){
            this[this.collapseEl].slideOut(this.slideAnchor,
                    L5.apply(this.createEffect(animArg||true, this.afterCollapse, this),
                        this.collapseDefaults));
        }else{
            this[this.collapseEl].hide();
            this.afterCollapse();
        }
    },

    /**
     * @private
     */
    afterCollapse : function(){
        this.collapsed = true;
        this.el.addClass(this.collapsedCls);
        this.afterEffect();
        this.fireEvent('collapse', this);
    },

    /**
     * 展开panel的主体部分，触发beforeexpand事件，如果返回false终止展开动作。
     * 注意：这个操作会引起状态更改，这个更改是异步的，所以如果紧接着调用collapse方法可能不会起到作用。
     * 例如：p.expand();p.collapse();不会出现panel展开然后立即收缩的的效果，最后结果就是panel展开了。
     * @param {Boolean} animate 是否需要动画效果（默认值参考animCollapse这个配置参数）
     * @return {L5.Panel} 返回panel本身
     */
    expand : function(animate){
        if(!this.collapsed || this.el.hasFxBlock() || this.fireEvent('beforeexpand', this, animate) === false){
            return;
        }
        var doAnim = animate === true || (animate !== false && this.animCollapse);
        this.el.removeClass(this.collapsedCls);
        this.beforeEffect();
        this.onExpand(doAnim, animate);
        return this;
    },

    /**
     * @private
     */
    onExpand : function(doAnim, animArg){
        if(doAnim){
            this[this.collapseEl].slideIn(this.slideAnchor,
                    L5.apply(this.createEffect(animArg||true, this.afterExpand, this),
                        this.expandDefaults));
        }else{
            this[this.collapseEl].show();
            this.afterExpand();
        }
    },

    /**
     * @private
     */
    afterExpand : function(){
        this.collapsed = false;
        this.afterEffect();
        this.fireEvent('expand', this);
    },

    /**
     * 在展开/收起状态之间切换
     * @param {Boolean} animate 是否需要动画效果（默认值参考animCollapse这个配置参数）
     * @return {L5.Panel} 返回panel组件本身
     */
    toggleCollapse : function(animate){
        this[this.collapsed ? 'expand' : 'collapse'](animate);
        return this;
    },

    /**
     * @private
     */
    onDisable : function(){
        if(this.rendered && this.maskDisabled){
            this.el.mask();
        }
        L5.Panel.superclass.onDisable.call(this);
    },

    /**
     * @private
     */
    onEnable : function(){
        if(this.rendered && this.maskDisabled){
            this.el.unmask();
        }
        L5.Panel.superclass.onEnable.call(this);
    },

    /**
     * @private
     * 改变大小的时候被调用
     */
    onResize : function(w, h){
        if(w !== undefined || h !== undefined){
            if(!this.collapsed){
                if(typeof w == 'number'){
                    this.body.setWidth(
                            this.adjustBodyWidth(w - this.getFrameWidth()));
                }else if(w == 'auto'){
                    this.body.setWidth(w);
                }

                if(typeof h == 'number'){
                    this.body.setHeight(
                            this.adjustBodyHeight(h - this.getFrameHeight()));
                }else if(h == 'auto'){
                    this.body.setHeight(h);
                }
                
                if(this.disabled && this.el._mask){
                    this.el._mask.setSize(this.el.dom.clientWidth, this.el.getHeight());
                }
            }else{
                this.queuedBodySize = {width: w, height: h};
                if(!this.queuedExpand && this.allowQueuedExpand !== false){
                    this.queuedExpand = true;
                    this.on('expand', function(){
                        delete this.queuedExpand;
                        this.onResize(this.queuedBodySize.width, this.queuedBodySize.height);
                        this.doLayout();
                    }, this, {single:true});
                }
            }
            this.fireEvent('bodyresize', this, w, h);
        }
        this.syncShadow();
    },

    /**
     * @private
     * 在panel组件中基本上不用处理，有些情况单位，或者经过算法处理可以将逻辑写在这个方法里面
     */
    adjustBodyHeight : function(h){
        return h;
    },

    /**
     * @private
     * 在panel组件中基本上不用处理，有些情况单位，或者经过算法处理可以将逻辑写在这个方法里面
     */
    adjustBodyWidth : function(w){
        return w;
    },

    /**
     * @private
     * 位置改变的时候调用
     */
    onPosition : function(){
        this.syncShadow();
    },

    /**
     * 获取组件的宽度，包含边框的宽度
     * @return {Number} 返回宽度（包含边框的宽度）
     */
    getFrameWidth : function(){
        var w = this.el.getFrameWidth('lr');

        if(this.frame){
            var l = this.bwrap.dom.firstChild;
            w += (L5.fly(l).getFrameWidth('l') + L5.fly(l.firstChild).getFrameWidth('r'));
            var mc = this.bwrap.dom.firstChild.firstChild.firstChild;
            w += L5.fly(mc).getFrameWidth('lr');
        }
        return w;
    },

    /**
     * 获取组件的高度，包含边框的高度
     * @return {Number} 返回高度（包含边框的高度）
     */
    getFrameHeight : function(){
        var h  = this.el.getFrameWidth('tb');
        h += (this.tbar ? this.tbar.getHeight() : 0) +
             (this.bbar ? this.bbar.getHeight() : 0);

        if(this.frame){
            var hd = this.el.dom.firstChild;
            var ft = this.bwrap.dom.lastChild;
            h += (hd.offsetHeight + ft.offsetHeight);
            var mc = this.bwrap.dom.firstChild.firstChild.firstChild;
            h += L5.fly(mc).getFrameWidth('tb');
        }else{
            h += (this.header ? this.header.getHeight() : 0) +
                (this.footer ? this.footer.getHeight() : 0);
        }
        return h;
    },

    /**
     * 获取组件的宽度，但是不包含边框的宽度
     * @return {Number} 返回宽度（不包含边框的宽度）
     */
    getInnerWidth : function(){
        return this.getSize().width - this.getFrameWidth();
    },

    /**
     * 获取组件的高度，但是不包含边框的高度
     * @return {Number} 返回高度（不包含边框的高度）
     */
    getInnerHeight : function(){
        return this.getSize().height - this.getFrameHeight();
    },

    /**
     * @private
     */
    syncShadow : function(){
        if(this.floating){
            this.el.sync(true);
        }
    },

    /**
     * @private
     * @returns {L5.Element} 获取布局的目标对象
     */
    getLayoutTarget : function(){
        return this.body;
    },

    /**
     * 设置Panel的标题(title)文本和可选的图标样式.
     * @param {String} title 需要设置的标题文本
     * @param {String} iconCls (可选) 图标对应的样式类，样式需要设置图标背景
     */
    setTitle : function(title, iconCls){
        this.title = title;
        if(this.header && this.headerAsText){
            this.header.child('span').update(title);
        }
        if(iconCls){
            this.setIconClass(iconCls);
        }
        this.fireEvent('titlechange', this, title);
        return this;
    },

    /**
     * @private
     * 获取panel的L5.Updater对象，该对象可以通过ajax更新panel内容
     * @return {L5.Updater} 返回L5.Updater对象
     */
    getUpdater : function(){
        return this.body.getUpdater();
    },

    /**
     * 通过XMLHttpRequest 请求（ajax请求）为panel加载内容
     * @param {Object/String/Function} config 一个配置对象，包含一系列请求ajax的属性例如：
     * panel.load({
	 *	    url: "your-url.php",
	 *	    params: {param1: "foo", param2: "bar"}, // or a URL encoded string
	 *	    callback: yourFunction,
	 *	    scope: yourObject, // optional scope for the callback
	 *	    discardUrl: false,
	 *	    nocache: false,
	 *	    text: "Loading...",
	 *	    timeout: 30,
	 *	    scripts: false
	 *	});
	 * @return {L5.Panel} 返回panel自身
     */
    load : function(){
        var um = this.body.getUpdater();
        um.update.apply(um, arguments);
        return this;
    },

    /**
     * 在销毁panel之前调用，将panel的一些组件销毁
     */
    beforeDestroy : function(){
        if(this.header){
            this.header.removeAllListeners();
            if(this.headerAsText){
                L5.Element.uncache(this.header.child('span'));
            }
        }
        //添加删除iframe的事件。
        if(this.body)
        L5.releaseIframe(this.body.dom);
        L5.Element.uncache(
            this.header,
            this.tbar,
            this.bbar,
            this.footer,
            this.body,
            this.bwrap
        );
        if(this.tools){
            for(var k in this.tools){
                L5.destroy(this.tools[k]);
            }
        }
        if(this.buttons){
            for(var b in this.buttons){
                L5.destroy(this.buttons[b]);
            }
        }
        L5.destroy(
            this.topToolbar,
            this.bottomToolbar
        );
        L5.Panel.superclass.beforeDestroy.call(this);
    },

    /**
     * @private
     * 根据panel里面不同的组件为每个组件生成css
     */
    createClasses : function(){
        this.headerCls = this.baseCls + '-header';
        this.headerTextCls = this.baseCls + '-header-text';
        this.bwrapCls = this.baseCls + '-bwrap';
        this.tbarCls = this.baseCls + '-tbar';
        this.bodyCls = this.baseCls + '-body';
        this.bbarCls = this.baseCls + '-bbar';
        this.footerCls = this.baseCls + '-footer';
    },

    /**
     * @private
     * 当panel被拖动的时候在原地创建一个临时的边框,当panel被拖动的时候实际上推动的是新创建的边框
     */
    createGhost : function(cls, useShim, appendTo){
        var el = document.createElement('div');
        el.className = 'l-panel-ghost ' + (cls ? cls : '');
        if(this.header){
            el.appendChild(this.el.dom.firstChild.cloneNode(true));
        }
        L5.fly(el.appendChild(document.createElement('ul'))).setHeight(this.bwrap.getHeight());
        el.style.width = this.el.dom.offsetWidth + 'px';;
        if(!appendTo){
            this.container.dom.appendChild(el);
        }else{
            L5.getDom(appendTo).appendChild(el);
        }
        if(useShim !== false && this.el.useShim !== false){
            var layer = new L5.Layer({shadow:false, useDisplay:true, constrain:false}, el);
            layer.show();
            return layer;
        }else{
            return new L5.Element(el);
        }
    },

    /**
     * @private
     * 加载数据
     */
    doAutoLoad : function(){
        this.body.load(
            typeof this.autoLoad == 'object' ?
                this.autoLoad : {url: this.autoLoad});
    },
    
    /**
     * @private
     * 通过工具的id检索工具
     * @param {String} id
     * @return {Object} 返回检索到的工具
     */
    getTool: function(id) {
        return this.tools[id];
    }

/**
 * @cfg {String} autoEl @hide
 */
});
L5.reg('panel', L5.Panel);
