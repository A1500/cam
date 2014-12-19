//doc
/**
 * @class L5.Container
 * @extends L5.BoxComponent
 * L5.Container是可以充当容器的盒状模型（L5.BoxComponent）组件的基类，比较常见的容器组件包括：L5.Panel，L5.Window，
 * L5.TabPanel。我们可以用autoEl封装一个HTML元素，创建一个轻量级的容器。容器类可以管理容器所包含的子组件的增加，删除
 * 容器都需要一个布局组件，如果没加默认是containerLayout。
 * 创建容器的例子：
 * var embeddedColumns = new L5.Container({
 * 	   autoEl: {},
 *    layout: 'column',
 *     defaults: {
 *         xtype: 'container',
 *         autoEl: {},
 *         layout: 'form',
 *         columnWidth: 0.5,
 *         style: {
 *             padding: '10px'
 *         }
 *     },
 *     items: [{
 *         items: {
 *             xtype: 'datefield',
 *             name: 'startDate',
 *             fieldLabel: 'Start date'
 *         }
 *     }, {
 *         items: {
 *             xtype: 'datefield',
 *            name: 'endDate',
 *            fieldLabel: 'End date'
 *         }
 *     }]
 * });
 * 创建一个GridPanel：
 *	myGrid = new L5.grid.GridPanel({
 *    	dataset: myDataset,
 *   	columns: myColumnModel,
 *    	title: 'Results',
 *	});
 *
 *	myTabPanel.add(myGrid);
 *	myTabPanel.setActiveTab(myGrid);
 */

L5.Container = L5.extend(L5.BoxComponent, {
    /** 
     * @private
     * @cfg {Boolean} monitorResize
     * 如果是true自动监控窗口调整（尺寸）事件，这个属性会被组件的布局管理，不需要手动设置
     */
    /**
     * @private
     * @cfg {String} layout
     * 该组件的布局，默认是L5.layout.ContainerLayout，可以通过子类组件提供的配置参数设置改变布局。
     * {@link #layoutConfig}. Valid values are:<ul class="mdetail-params">
     * <li>absolute</li>
     * <li>accordion</li>
     * <li>anchor</li>
     * <li>border</li>
     * <li>card</li>
     * <li>column</li>
     * <li>fit</li>
     * <li>form</li>
     * <li>table</li></ul>
     */
    /**
     * @private
     * @cfg {Object} layoutConfig
     * This is a config object containing properties specific to the chosen layout (to be used in conjunction with
     * the {@link #layout} config value).  For complete details regarding the valid config options for each layout
     * type, see the layout class corresponding to the type specified:<ul class="mdetail-params">
     * <li>{@link L5.layout.Absolute}</li>
     * <li>{@link L5.layout.Accordion}</li>
     * <li>{@link L5.layout.AnchorLayout}</li>
     * <li>{@link L5.layout.BorderLayout}</li>
     * <li>{@link L5.layout.CardLayout}</li>
     * <li>{@link L5.layout.ColumnLayout}</li>
     * <li>{@link L5.layout.FitLayout}</li>
     * <li>{@link L5.layout.FormLayout}</li>
     * <li>{@link L5.layout.TableLayout}</li></ul>
     */
    /**
     * @private
     * @cfg {Boolean/Number} bufferResize
     * 当设置后会延迟指定的毫秒数再计算尺寸，改变大小
     */
    /**
     * @private
     * @cfg {String/Number} activeItem
     * 设置当前活动的Item项，activeItem只是当布局设定只有一个item有效的时候才能使用，比如：L5.layout.Accordion，L5.layout.CardLayout
     * L5.layout.FitLayout。关联L5.layout.ContainerLayout的activeItem属性
     */
    /**
     * @ignore
     * @cfg {Mixed} items
     * 容器的一组子组件，每一个item都可以是一中类型的L5.Component。子组件的配置属性也可以指定，如果采用延迟渲染的模式，子组件
     * 将不会立刻就渲染，这样可以减少创建对象的开销，提高性能。子组件也将被注册到 L5.ComponentMgr中
     */
    /**
     * @ignore
     * @cfg {Object} defaults
     * 一个配置对象，该对象里面的配置参数将被应用到所有的子组件中
     */

    /** 
     * @ignore
     * @cfg {Boolean} autoDestroy
     * 如果是true，组件移除自身的子组件后会将其销毁，如果是false，子组件被移除后不会被销毁。默认是true
     */
    autoDestroy: true,
    /**
     * @private 
     * @cfg {Boolean} hideBorders
     * 如果是true就隐藏组件的borders。默认是false
     */
    /** 
     * @private
     * @cfg {String} defaultType
     * 子组件默认的xtype，默认是“panel”，可以通过xtype创建正确类型的子组件
     */
    defaultType: 'panel',

    /**
     * @private
     * 为容器组件增加了一些事件，同时将子组件构造出来，并添加到容器，但是没渲染。
     */
    initComponent : function(){
        L5.Container.superclass.initComponent.call(this);

        this.addEvents(
            /**
             * @ignore
             * @event afterlayout
             * 当子组件在父容器内完成布局后触发
             * @param {L5.Container} this
             * @param {ContainerLayout} layout 容器的布局
             */
            'afterlayout',
            /**
             * @ignore
             * @event beforeadd
             * 当子组件被添加到容器之前触发，返回false就会取消添加动作
             * @param {L5.Container} this
             * @param {L5.Component} component 被添加的子组件
             * @param {Number} index 被添加到父容器后的索引号
             */
            'beforeadd',
            /**
             * @ignore
             * @event beforeremove
             * 当子组件被移除之前触发，返回false终止移除子组件
             * @param {L5.Container} this
             * @param {L5.Component} component 将要被移除的子组件
             */
            'beforeremove',
            /**
             * @ignore
             * @event add
             * 当子组件被添加到容器后触发
             * @param {L5.Container} this
             * @param {L5.Component} component 添加到容器的子组件
             * @param {Number} index 子组件在容器中的索引号
             */
            'add',
            /**
             * @ignore
             * @event remove
             * 当子组件被移除后触发
             * @param {L5.Container} this
             * @param {L5.Component} component 被移除的子组件
             */
            'remove'
        );

        /**
         * 管理容器内阻子组件的L5.util.MixedCollection对象
         * @private
         * @type MixedCollection
         * @property items
         */
        var items = this.items;
        if(items){
            delete this.items;
            if(L5.isArray(items) && items.length > 0){
                this.add.apply(this, items);
            }else{
                this.add(items);
            }
        }
    },

    /**
     * @private
     *初始化子组件 
     */
    initItems : function(){
        if(!this.items){
            this.items = new L5.util.MixedCollection(false, this.getComponentId);
            this.getLayout(); // 初始化布局
        }
    },

    /**
     * @private
     * 设置组件的布局，初始化子组件
     * @param {layout} layout 要设置的布局
     */
    setLayout : function(layout){
        if(this.layout && this.layout != layout){
            this.layout.setContainer(null);
        }
        this.initItems();
        this.layout = layout;
        layout.setContainer(this);
    },

    /**
     * @private
     * 渲染容器，设置组件的布局并实施布局
     */
    render : function(){
        L5.Container.superclass.render.apply(this, arguments);
        if(this.layout){
            if(typeof this.layout == 'string'){
                this.layout = new L5.Container.LAYOUTS[this.layout.toLowerCase()](this.layoutConfig);
            }
            this.setLayout(this.layout);

            if(this.activeItem !== undefined){
                var item = this.activeItem;
                delete this.activeItem;
                this.layout.setActiveItem(item);
                return;
            }
        }
        if(!this.ownerCt){
            this.doLayout();
        }
        if(this.monitorResize === true){
            L5.EventManager.onWindowResize(this.doLayout, this, [false]);
        }
    },

    /**
     * @private
     * 获取容器用来容纳子组件的ELement
     * @return {L5.Element} 返回组件被渲染到Element.
     */
    getLayoutTarget : function(){
        return this.el;
    },

    // private - used as the key lookup function for the items collection
    getComponentId : function(comp){
        return comp.itemId || comp.id;
    },

    /**
     * 为容器增加 一个或一组 子组件，会触发beforeadd和add事件，但是不需要我们自己去调用子组件的render方法，当父容器渲染的时候，子组件
     * 被父容器的布局渲染。某些布局允许动态的添加子组件比如：L5.layout.CardLayout ，L5.layout.AnchorLayout ，L5.layout.FormLayout ，L5.layout.TableLayout。
     * 如果动态增加子组件后需要调用dolayout方法重新布局刷新视图。
     * 例子：
     * 	var myNewGrid = new L5.grid.GridPanel({
     *	dataset: myDataset,
     *	colModel: myColModel
     *	});
     *	myTabPanel.add(myNewGrid);
     *	myTabPanel.setActiveTab(myNewGrid);
     * @param {L5.Component/Object} component 要被插入的子组件
     * @return {L5.Component} component 返回被添加的子组件
     */
    add : function(comp){
        if(!this.items){
            this.initItems();
        }
        var a = arguments, len = a.length;
        if(len > 1){
            for(var i = 0; i < len; i++) {
                this.add(a[i]);
            }
            return;
        }
        var c = this.lookupComponent(this.applyDefaults(comp));
        var pos = this.items.length;
        if(this.fireEvent('beforeadd', this, c, pos) !== false && this.onBeforeAdd(c) !== false){
            this.items.add(c);
            c.ownerCt = this;
            
            //this.on("resize",c.onWinResize,c);
            this.fireEvent('add', this, c, pos);
        }
        return c;
    },

    /**
     * 将组件插入到这个容器的指定所引出
     * @param {Number} index 指定要插入的索引号
     * @param {L5.Component} component 被插入的子容器
     * @return {L5.Component} component 返回被添加的子组件
     */
    insert : function(index, comp){
        if(!this.items){
            this.initItems();
        }
        var a = arguments, len = a.length;
        if(len > 2){
            for(var i = len-1; i >= 1; --i) {
                this.insert(index, a[i]);
            }
            return;
        }
        var c = this.lookupComponent(this.applyDefaults(comp));

        if(c.ownerCt == this && this.items.indexOf(c) < index){
            --index;
        }

        if(this.fireEvent('beforeadd', this, c, index) !== false && this.onBeforeAdd(c) !== false){
            this.items.insert(index, c);
            c.ownerCt = this;
            this.fireEvent('add', this, c, index);
        }
        return c;
    },

    /**
     * @private
     * 将默认的配置信息拷贝给传递过来的配置object/L5.Component
     * @return {L5.Component/Object} 返回子组件或者配置参数
     */
    applyDefaults : function(c){
        if(this.defaults){
            if(typeof c == 'string'){
                c = L5.ComponentMgr.get(c);
                L5.apply(c, this.defaults);
            }else if(!c.events){
                L5.applyIf(c, this.defaults);
            }else{
                L5.apply(c, this.defaults);
            }
        }
        return c;
    },

    /**
     * @private
     */
    onBeforeAdd : function(item){
        if(item.ownerCt){
            item.ownerCt.remove(item, false);
        }
        if(this.hideBorders === true){
            item.border = (item.border === true);
        }
    },

    /**
     * 从容器移除子组件，触发beforeremove和remove事件
     * @param {Component/String} component 要被移除的子组件
     * @param {Boolean} autoDestroy (可选) 如果是ture移除子组件后会调用子组件的destroy方法（默认true），前提是配置参数autoDestroy是true 
     * @return {L5.Component} component 被移除的组件
     */
    remove : function(comp, autoDestroy){
        var c = this.getComponent(comp);
        if(c && this.fireEvent('beforeremove', this, c) !== false){
            this.items.remove(c);
            delete c.ownerCt;
            if(autoDestroy === true || (autoDestroy !== false && this.autoDestroy)){
                c.destroy();
            }
            if(this.layout && this.layout.activeItem == c){
                delete this.layout.activeItem;
            }
            this.fireEvent('remove', this, c);
        }
        return c;
    },
    
    /**
     * 移除所有的子组件
     * @param {Boolean} autoDestroy (可选) 如果是ture移除子组件后会调用子组件的destroy方法（默认true），前提是配置参数autoDestroy是true 
     * @return {Array} 返回被移除的子组件的数组
     */
    removeAll: function(autoDestroy){
        var item, items = [];
        while((item = this.items.last())){
            items.unshift(this.remove(item, autoDestroy));
        }
        return items;
    },

    /**
     * 通过子组件的id获取子组件，或者通过子组件的索引获取子组件
     * @param {String/Number} 子组件的id/index.
     * @return {L5.Component} 返回子组件
     */
    getComponent : function(comp){
        if(typeof comp == 'object'){
            return comp;
        }
        return this.items.get(comp);
    },

    /**
     * 获取组件，如果不存在就按照传递的信息创建组件
     * @param {String/config}  comp 组件的id或者配置项
     * @return {L5.Component}  返回要获取的组件
     */
    lookupComponent : function(comp){
        if(typeof comp == 'string'){
            return L5.ComponentMgr.get(comp);
        }else if(!comp.events){
            return this.createComponent(comp);
        }
        return comp;
    },

    /**
     * @private
     * 根据配置信息创建组件
     * @param {config}  comp 组件的配置项
     * @return {L5.Component}  返回要创建的组件
     */
    createComponent : function(config){
        return L5.ComponentMgr.create(config, this.defaultType);
    },

    /**
     * 强制组件的布局重新计算布局，当容器内新增组件或者容器刚渲染完成或者位置大小变动的时候需要被调用
     * @param {Boolean} shallow (可选) 如果是true紧紧计算组件本身的组件，并且让子组件自动计算布局（默认是false，也就是要求子组件递归
     * 调用doLayout）
     */
    doLayout : function(shallow){
        if(this.rendered && this.layout){
            this.layout.layout();
        }
        if(shallow !== false && this.items){
            var cs = this.items.items;
            for(var i = 0, len = cs.length; i < len; i++) {
                var c  = cs[i];
                if(c.doLayout){
                    c.doLayout();
                }
            }
        }
    },

    /**
     * @private
     * 获取当前组件的布局（layout），假如当前组件没有指定布局，就创建并返回默认的布局（L5.layout.ContainerLayout）
     * @return {ContainerLayout} 返回组件的布局
     */
    getLayout : function(){
        if(!this.layout){
            var layout = new L5.layout.ContainerLayout(this.layoutConfig);
            this.setLayout(layout);
        }
        return this.layout;
    },

    /**
     * @private
     */
    beforeDestroy : function(){
        if(this.items){
            L5.destroy.apply(L5, this.items.items);
        }
        if(this.monitorResize){
            L5.EventManager.removeResizeListener(this.doLayout, this);
        }
        if (this.layout && this.layout.destroy) {
            this.layout.destroy();
        }
        L5.Container.superclass.beforeDestroy.call(this);
    },

    /**
     * @private
     * 从当前容器组件逐层递归向上（找组件的父容器，然后父容器又找父容器，依次类推。。。），对每个循环到的父组件调用指定的方法fn。
     * 其中的作用域是scope（默认是this），参数是args（默认是当前组件也就是this），假如方法（fn）返回fasle就会停止递归
     * @param {Function} fn 要被调用的funciton
     * @param {Object} scope ( 可选) 被调用方法的作用域 (默认是递归到的当前组件)
     * @param {Array} args (可选) 被调用方法所使用的参数 (默认是递归到的当前组件)
     */
    bubble : function(fn, scope, args){
        var p = this;
        while(p){
            if(fn.apply(scope || p, args || [p]) === false){
                break;
            }
            p = p.ownerCt;
        }
    },

    /**
     * @private
     * 从当前组件递归向下（当前组件，当前组件的所有子组件，然后子组件的子组件依次类推），对每个循环到的组件调用方法fn
     * 其中的作用域是scope（默认是this），参数是args（默认是当前组件也就是this），假如方法（fn）返回fasle就会停止递归
     * @param {Function} fn 要被调用的funciton
     * @param {Object} scope ( 可选) 被调用方法的作用域 (默认是递归到的当前组件)
     * @param {Array} args (可选) 被调用方法所使用的参数 (默认是递归到的当前组件)
     */
    cascade : function(fn, scope, args){
        if(fn.apply(scope || this, args || [this]) !== false){
            if(this.items){
                var cs = this.items.items;
                for(var i = 0, len = cs.length; i < len; i++){
                    if(cs[i].cascade){
                        cs[i].cascade(fn, scope, args);
                    }else{
                        fn.apply(scope || cs[i], args || [cs[i]]);
                    }
                }
            }
        }
    },

    /**
     * 通过id寻找某容器下的子孙组件
     * @param {String} id 被寻找的组件的id
     * @return {L5.Component} 返回id符合的组件
     */
    findById : function(id){
        var m, ct = this;
        this.cascade(function(c){
            if(ct != c && c.id === id){
                m = c;
                return false;
            }
        });
        return m || null;
    },

    /**
     * 通过xtype或者类名寻找某容器下的子孙组件
     * @param {String/Class} xtype 要寻找的子组件的xtype或者类名
     * @param {Boolean} shallow (可选) 如果是false，就检测是不是xtype或者类名的子孙，如果是子孙也满足条件，默认是False
     * @return {Array} 返回满足条件的组件数组
     */
    findByType : function(xtype, shallow){
        return this.findBy(function(c){
            return c.isXType(xtype, shallow);
        });
    },

    /**
     * 通过属性property寻找某容器下的子孙组件
     * @param {String} prop 要匹配的属性
     * @param {String} value  属性对应的值
     * @return {Array} 返回匹配成功的组件的数组
     */
    find : function(prop, value){
        return this.findBy(function(c){
            return c[prop] === value;
        });
    },

    /**
     * 对子组件递归调用自定义的方法，如果方法验证通过（返回true）就判定该子组件满足条件，被包含到结果集中，方法的参数
     * 是当前容器（this）和当前递归到的子组件
     * @param {Function} fcn 被调用的方法
     * @param {Object} scope (可选) 作用域默认是当前递归到的子组件
     * @return {Array} 返回满足条件的所有子组件组成的数组
     */
    findBy : function(fn, scope){
        var m = [], ct = this;
        this.cascade(function(c){
            if(ct != c && fn.call(scope || c, c, ct) === true){
                m.push(c);
            }
        });
        return m;
    }
});

L5.Container.LAYOUTS = {};
L5.reg('container', L5.Container);