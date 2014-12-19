/**
 * @class L5.grid.GridPanel
 * @extends L5.Panel
 * 这个类是网格组件的基础类，虽然这个类从父类继承了很多的配置属性，但是有一些没有被使用比如（autoScroll, layout, items, etc），
 * grid需要设置宽度和高度。
 * 注意：grid没有布局
 * @constructor
 * @param {Object} config The config object
 * grid示例：
 * var grid = new L5.grid.GridPanel({
 *    dataset: new L5.model.Dataset({
 *        reader: reader,
 *        data: xg.dummyData
 *    }),
 *    columns: [
 *        {id:'company', header: "Company", width: 200, sortable: true, field: 'company'},
 *        {header: "Price", width: 120, sortable: true, renderer: L5.util.Format.usMoney, field: 'price'},
 *        {header: "Change", width: 120, sortable: true, field: 'change'},
 *        {header: "% Change", width: 120, sortable: true, field: 'pctChange'},
 *        {header: "Last Updated", width: 135, sortable: true, renderer: L5.util.Format.dateRenderer('m/d/Y'), field: 'lastChange'}
 *    ],
 *    viewConfig: {
 *        forceFit: true,
 *
 *       //Return CSS class to apply to rows depending upon data values
 *        getRowClass: function(record, index) {
 *            var c = record.get('change');
 *            if (c < 0) {
 *                return 'price-fall';
 *            } else if (c > 0) {
 *                return 'price-rise';
 *            }
 *        }
 *    },
 *    sm: new L5.grid.RowSelectionModel({singleSelect:true}),
 *    width:600,
 *    height:300,
 *    frame:true,
 *    title:'Framed with Checkbox Selection and Horizontal Scrolling',
 *    iconCls:'icon-grid'
 *	});
 */
L5.grid.GridPanel = L5.extend(L5.Panel, {
    /**
     * @cfg {L5.model.Dataset} dataset 数据来源{@link L5.model.Dataset}(必须).
     */
    /**
     * @ignore
     * @cfg {Object} cm colModel的简写.@hide
     */
    /**
     * @ignore
     * @cfg {Object} colModel 当渲染grid的时候需要使用grid.ColumnModel (必须).
     */
    /**
     * @ignore
     * @cfg {Object} sm selModel的简写.@hide
     */
    /**
     * @ignore
     * @cfg {Object} selModel selModel是L5.grid.AbstractSelectionModel的任意子类，它会给grid提供选择模型，默认的选择模型是
     * （L5.grid.RowSelectionModel）
     */
    /**
     * @ignore
     * @cfg {Array} columns 一个自动创建ColumnModel的数组
     */
    /**
     * @private
    * @cfg {Number} maxHeight 如果autoHeight是true设置grid的最大高度
    */
    /**
     * @cfg {Boolean} disableSelection 如果设置为true禁止grid选择行(默认是false).
     */
    /**
     * @cfg {Boolean} enableColumnMove 是否启用列拖动效果.
     */
    /**
     * @cfg {Boolean} enableColumnResize 是否允许调整列宽度.
     */
    /**
     * @private
     * @cfg {Object} viewConfig 一个用来创建表格视图的配置对象，该配置对象里面的属性都应该是可以被L5.grid.GridView解析的
     */
    /**
     * @cfg {Boolean} hideHeaders 设置true隐藏grid的头.
     */

    /**
     * @ignore
     * Configures the text in the drag proxy (defaults to "{0} selected row(s)").
     * {0} is replaced with the number of selected rows.
     * @type String 
     */
    ddText : "{0} selected row{1}",
    /** 
     *@ignore
     * @cfg {Number} minColumnWidth 当列改变大小的时候最小的列宽度，默认是25
     */
    minColumnWidth : 25,
    /**
     * @cfg {Boolean} trackMouseOver 是否高亮鼠标所在行.默认是true.
     */
    trackMouseOver : false,
	/** 
	 * @cfg {Boolean} enableScollGridView 是否使用支持大数据量展示的grid
	*/
    enableScollGridView : false,
    /**
     * @cfg {Boolean} notSelectFirstRow 是否默认选中第一行
     */
    notSelectFirstRow : false,//默认选中第一行
	isGrid:true,
    /** 
     * @ignore
     * @cfg {Boolean} 
     * 如果是true，可以拖动选中的行。如果设置为true就会让GridView创建一个L5.grid.GridDragZone的实例。
     * 当渲染完整后就可以使用拖拽功能。（默认是false）
     */
    enableDragDrop : false,
    /** 
     * 
     * @cfg {Boolean} enableColumnMove 是否允许列移动.
     */
    enableColumnMove : false,
    /** 
     * @cfg {Boolean} enableColumnHide 是否允许列动态隐藏.
     */
    enableColumnHide : false,
    /** 
     * @cfg {Boolean} enableHdMenu 是否允许头部出现列菜单.
     */
    enableHdMenu : false,
    /** 
     * @cfg {Boolean} stripeRows 是否区分奇偶行，默认是false.
     */
    stripeRows : false,
    /** 
     * @cfg {String} autoExpandColumn 自动充满grid列剩余空间的列ID.
     */
    autoExpandColumn : false,
    /** 
     * @private
     * @cfg {Number} autoExpandMin 
     * The minimum width the autoExpandColumn can have (if enabled).
     * defaults to 50.
     */
    autoExpandMin : 50,
    /** 
	* @private
    * @cfg {Number} autoExpandMax The maximum width the autoExpandColumn can have (if enabled). Defaults to 1000.
    */
    autoExpandMax : 1000,
    /** 
     * @ignore 
     * @cfg {Object} view grid用的视图
     */
    view : null,
    /** 
     * @ignore
     * @cfg {Object} loadMask An {@link L5.LoadMask} config or true to mask the grid while loading (defaults to false).
     */
    loadMask : true,

    /** 
     * @ignore
     * @cfg {Boolean} deferRowRender 如果是true允许延迟渲染行，默认是false
     */
    deferRowRender : false,

    /**
     * @private
     */
    rendered : false,
    /**
     * @private
     */
    viewReady: false,
    /**
     * @ignore
     * @cfg {Array} stateEvents
     * 一个时间数组，当这些时间触发的时候需要保存组件的状态（默认事件有["columnmove", "columnresize", "sortchange"]），这些事件可以是
     * 任何被组件支持的事件，包括自定义事件和浏览器事件
     */
    stateEvents: ["columnmove", "columnresize", "sortchange"],
    
    /**
     * @cfg {Boolean} editWidthWin
     * 用辅助编辑框
     */
    assistWin : false,
    /**
     * @cfg {Number} clicksToAssistWin
     * <p>点击几下可以弹出辅助窗口(默认是2).</p>
     */
    clicksToAssistWin : 2,
    /**
     * 是否禁止选中grid中文本
     */
    unselect: true,

    /**
     * @private
     */
    initComponent : function(){
        L5.grid.GridPanel.superclass.initComponent.call(this);

        // override any provided value since it isn't valid
        this.autoScroll = false;
        this.autoWidth = false;

        if(L5.isArray(this.columns)){
            this.colModel = new L5.grid.ColumnModel(this.columns,this);
            delete this.columns;
        }

        // check and correct shorthanded configs
        if(this.ds){
            this.dataset = this.ds;
            delete this.ds;
        }
        if(this.cm){
            this.colModel = this.cm;
            delete this.cm;
        }
        if(this.sm){
            this.selModel = this.sm;
            delete this.sm;
        }
        this.dataset = L5.DatasetMgr.lookup(this.dataset);
        this.addEvents(
            // 浏览器事件
            /**
             * @ignore
             * @event click
             * 当单击grid的任意点的时候都会触发click事件
             * @param {L5.EventObject} e
             */
            "click",
            /**
             * @ignore
             * @event dblclick
             * 当双击grid的任意一点的时候都会触发
             * @param {L5.EventObject} e
             */
            "dblclick",
            /**
             * @event contextmenu
             * 整个grid的右键菜单事件.
             * @param {L5.EventObject} e
             */
            "contextmenu",
            /**
             * @ignore
             * @event mousedown
             * 当鼠标左键按下的时候都会触发
             * @param {L5.EventObject} e
             */
            "mousedown",
            /**
             * @ignore
             * @event mouseup
             * 当鼠标左键弹起的时候触发
             * @param {L5.EventObject} e
             */
            "mouseup",
            /**
             * @ignore
             * @event mouseover
             * 鼠标悬浮在grid的时候触发
             * @param {L5.EventObject} e
             */
            "mouseover",
            /**
             * @ignore
             * @event mouseout
             * 鼠标移除grid区域的时候触发
             * @param {L5.EventObject} e
             */
            "mouseout",
            /**
             * @ignore
             * @event keypress
             * 当按按键的时候触发
             * @param {L5.EventObject} e
             */
            "keypress",
            /**
             * @ignore
             * @event keydown
             * 当按下按键的时候触发
             * @param {L5.EventObject} e
             */
            "keydown",

            // 自定义事件
            /**
             * @ignore
             * @event cellmousedown
             * 单元格被click的时候触发事件
             * @param {Grid} this
             * @param {Number} rowIndex
             * @param {Number} columnIndex
             * @param {L5.EventObject} e
             */
            "cellmousedown",
            /**
             * @ignore
             * @event rowmousedown
             * 行被click的时候触发事件
             * @param {Grid} this
             * @param {Number} rowIndex
             * @param {L5.EventObject} e
             */
            "rowmousedown",
            /**
             * @ignore
             * @event headermousedown
             * grid表头被点击的时候触发事件
             * @param {Grid} this
             * @param {Number} columnIndex
             * @param {L5.EventObject} e
             */
            "headermousedown",

            /**
             * @event cellclick
             * 当单元格被点击的时候触发事件.
             * 应该像如下这样使用:
             * <pre><code>
    function(grid, rowIndex, columnIndex, e) {
        var record = grid.getDataset().getAt(rowIndex);  // Get the Record
        var fieldName = grid.getColumnModel().getDataIndex(columnIndex); // Get field name
        var data = record.get(fieldName);
    }
</code></pre>
             * @param {Grid} this
             * @param {Number} rowIndex
             * @param {Number} columnIndex
             * @param {L5.EventObject} e
             */
            "cellclick",
            /**
             * @event celldblclick
             * 当单元格被双击的时候触发事件
             * @param {Grid} this
             * @param {Number} rowIndex
             * @param {Number} columnIndex
             * @param {L5.EventObject} e
             */
            "celldblclick",
            /**
             * @event rowclick
             * 当行被点击的时候触发事件
             * @param {Grid} this
             * @param {Number} rowIndex
             * @param {L5.EventObject} e
             */
            "rowclick",
            /**
             * @event rowdblclick
             * 当行被双击的时候触发事件
             * @param {Grid} this
             * @param {Number} rowIndex
             * @param {L5.EventObject} e
             */
            "rowdblclick",
            /**
             * @ignore
             * @event headerclick
             * 当header部分被单击的时候触发
             * @param {Grid} this
             * @param {Number} columnIndex
             * @param {L5.EventObject} e
             */
            "headerclick",
            /**
             * @ignore
             * @event headerdblclick
             * 当header被双击的时候触发
             * @param {Grid} this
             * @param {Number} columnIndex
             * @param {L5.EventObject} e
             */
            "headerdblclick",
            /**
             * @ignore
             * @event rowcontextmenu
             * 当行发生鼠标右击事件触发
             * @param {Grid} this
             * @param {Number} rowIndex
             * @param {L5.EventObject} e
             */
            "rowcontextmenu",
            /**
             * @ignore
             * @event cellcontextmenu
             * 单元格发生鼠标右击触发
             * @param {Grid} this
             * @param {Number} rowIndex
             * @param {Number} cellIndex
             * @param {L5.EventObject} e
             */
            "cellcontextmenu",
            /**
             * @ignore
             * @event headercontextmenu
             * 当header部分右击是触发
             * @param {Grid} this
             * @param {Number} columnIndex
             * @param {L5.EventObject} e
             */
            "headercontextmenu",
            /**
             * @ignore
             * @event bodyscroll
             * 当body发生滚动条滚动事件触发
             * @param {Number} scrollLeft
             * @param {Number} scrollTop
             */
            "bodyscroll",
            /**
             * @ignore
             * @event columnresize
             * 当列宽发生变化时候触发
             * @param {Number} columnIndex
             * @param {Number} newSize
             */
            "columnresize",
            /**
             * @ignore
             * @event columnmove
             * 当列移动的时候触发
             * @param {Number} oldIndex
             * @param {Number} newIndex
             */
            "columnmove",
            /**
             * @ignore
             * @event sortchange
             * 当数据模型排序发生变化的时候触发
             * @param {Grid} this
             * @param {Object} sortInfo 一个对象包含两个属性：dir（排序方向）sort（排序字段）
             */
            "sortchange"
        );
    },

    /**
     * @private
     */
    onRender : function(ct, position){
        L5.grid.GridPanel.superclass.onRender.apply(this, arguments);

        var c = this.body;
        if(this.loadMask){
        	this.loadMask=new L5.LoadMask(this.bwrap, {msg:"数据加载中...",dataset:this.dataset});
        }
        this.el.addClass('l-grid-panel');
        c.setWidth("100%");//修复所有列宽和很大，超出边界。
        var view = this.getView();
        view.init(this);

        c.on("mousedown", this.onMouseDown, this);
        c.on("click", this.onClick, this);
        c.on("dblclick", this.onDblClick, this);
        c.on("contextmenu", this.onContextMenu, this);
        c.on("keydown", this.onKeyDown, this);

        this.relayEvents(c, ["mousedown","mouseup","mouseover","mouseout","keypress"]);

        this.getSelectionModel().init(this);
        this.view.render();
        //为了解决gridpanel高度设置成100%时，bottomToolbar不会显示在body高度之外的问题而添加
        if(this.bbar && this.bottomToolbar){
        	this.bottomToolbar.render(this.bbar);
            this.bottomToolbar.ownerCt = this;
        }
        this.dataset.on('load',this.refreshBody,this);
    },
    /**
     * @private
     */
    refreshBody : function(){
    	this.view.refresh(true);
    },
    /**
     * @private
     */
    initEvents : function(){
        L5.grid.GridPanel.superclass.initEvents.call(this);
        
        if(this.assistWin){
        	this.initShowWin();
        	if(this.clicksToAssistWin == 2){
        		this.on("rowdblclick",this.ShowWin,this);
        	} else {
        		this.on("rowclick",this.ShowWin,this);
        	}
        }
        
        if(this.loadMask){
            this.loadMask = new L5.LoadMask(this.bwrap,
                    L5.apply({dataset:this.dataset}, this.loadMask));
        }
    },
    /**
     * @private
     * 初始化辅助窗口
     */
    initShowWin : function (){
    	var title = this.title ? this.title : "";
    	var renderEl = this.el.dom;
    	if(!L5.Window)
    		return;
    	var g = this;
    	this.assistWindow = new L5.Window({
        	title : title,
        	resizable : true,
        	autoScroll : true,
        	width : 400,
        	plain : true,
        	shim : true,
        	renderTo : renderEl,
        	//animateTarget : L5.getBody(),
        	closeAction : 'hide',
        	closable : false,
        	layout : 'fit',
        	tools : [
        	         {id : 'hidewin',handler : function(event, toolEl, win){
        	        	 g.stopEditing();
        	        	 win.hide();
        	         }}
        	         ]
        });
    },
    /**
     * @private
     * 显示辅助窗口
     */
    ShowWin : function(grid,rowIndex,e){
    	var win = this.assistWindow;
    	if(win){
    		var rowstr = "";
        	var height = 0;
        	var l=this.colModel.config.length;
    		for(var col=0;col<l;col++){
    			if(!this.colModel.isHidden(col)){
    				var cfg = this.colModel.config[col];
    				if(cfg.field && cfg.hidden != true){
    					height++;
    					rowstr += this.createTrFormCm(cfg,rowIndex,col);
    				}
    			}
    		}
    		height>9 ? win.setHeight(305) : win.setHeight(height*30+35);
    		var dsid = this.dataset.id;
        	var htmlStr = '<form class="L5Form" dataset="'+dsid+'">'+
        								'<table border="0" cellspacing="0" cellpadding="0" width="100%"><tbody>'+
        									rowstr+
        								'</tbody></table>'+
        						 '</form>';
    		win.show();
    		win.body.update(htmlStr);
    	}
    },
    /**
     * @private
     * 通过colMode创建TR
     */
    createTrFormCm : function(cfg,row,col) {
		var str = "";
		str = '<tr><td  style="width:50%;" class="FieldLabel"><label>'
			+ cfg.header
			+ ':</label></td><td  style="width:50%;" class="FieldInput">'
			+ this.createEl4Win(cfg,row,col);
			+'</td></tr>';
		return str;
	},
	/**
	 * @private
	 * 创建每个单元格中的具体元素
	 */
	createEl4Win : function (cfg,row,col) {
		var value = this.getView().getCell(row,col).childNodes[0].innerHTML;
		var str = '<label>'+value+'</label>';
		return str;
	},
	
    /**
     * @private
     */
    initStateEvents : function(){
        L5.grid.GridPanel.superclass.initStateEvents.call(this);
        this.colModel.on('hiddenchange', this.saveState, this, {delay: 100});
    },
    /**
     * @private
     */
    applyState : function(state){
        var cm = this.colModel;
        var cs = state.columns;
        if(cs){
            for(var i = 0, len = cs.length; i < len; i++){
                var s = cs[i];
                var c = cm.getColumnById(s.id);
                if(c){
                    c.hidden = s.hidden;
                    c.width = s.width;
                    var oldIndex = cm.getIndexById(s.id);
                    if(oldIndex != i){
                        cm.moveColumn(oldIndex, i);
                    }
                }
            }
        }
        if(state.sort){
            this.dataset[this.dataset.remoteSort ? 'setDefaultSort' : 'sort'](state.sort.field, state.sort.direction);
        }
    },
    /**
     * @private
     */
    getState : function(){
        var o = {columns: []};
        for(var i = 0, c; c = this.colModel.config[i]; i++){
            o.columns[i] = {
                id: c.id,
                width: c.width
            };
            if(c.hidden){
                o.columns[i].hidden = true;
            }
        }
        var ss = this.dataset.getSortState();
        if(ss){
            o.sort = ss;
        }
        return o;
    },

    /**
     * @private
     */
    afterRender : function(){
        L5.grid.GridPanel.superclass.afterRender.call(this);
        this.view.layout();
        if(this.deferRowRender){
            this.view.afterRender.defer(10, this.view);
        }else{
            this.view.afterRender();
        }
        if(this.bbar && this.bottomToolbar){
        	this.bottomToolbar.render(this.bbar);
            this.bottomToolbar.ownerCt = this;
        }
        this.viewReady = true;
    },

    /** 
     * @ignore
     * <p>Reconfigures the grid to use a different Dataset and Column Model.
     * The View will be bound to the new objects and refreshed.</p>
     * <p>Be aware that upon reconfiguring a GridPanel, certain existing settings <i>may</i> become
     * invalidated. For example the configured {@link #autoExpandColumn} may no longer exist in the
     * new ColumnModel. Also, an existing {@link L5.PagingToolbar PagingToolbar} will still be bound
     * to the old Dataset, and will need rebinding. Any {@link #plugins} might also need reconfiguring
     * with the new data.</p>
     * @param {L5.model.Dataset} dataset The new {@link L5.model.Dataset} object
     * @param {L5.grid.ColumnModel} colModel The new {@link L5.grid.ColumnModel} object
     */
    reconfigure : function(dataset, colModel){
        if(this.loadMask){
            this.loadMask.destroy();
            this.loadMask = new L5.LoadMask(this.bwrap,
                    L5.apply({dataset:dataset}, this.initialConfig.loadMask));
        }
        this.view.bind(dataset, colModel);
        this.dataset = dataset;
        this.colModel = colModel;
        if(this.rendered){
            this.view.refresh(true);
        }
    },

    /**
     * @private
     */  
    onKeyDown : function(e){
        this.fireEvent("keydown", e);
    },

    /**
     * @private
     */
    onDestroy : function(){
        if(this.rendered){
            if(this.loadMask){
                this.loadMask.destroy();
            }
            var c = this.body;
            c.removeAllListeners();
            this.view.destroy();
            c.update("");
        }
        this.colModel.purgeListeners();
        L5.grid.GridPanel.superclass.onDestroy.call(this);
    },

    /**
     * @private
     * 触发cellclick，headerclcik等事件都在这里触发
     */ 
    processEvent : function(name, e){
        this.fireEvent(name, e);
        var t = e.getTarget();
        var v = this.view;
        var header = v.findHeaderIndex(t);
        if(header !== false){
            this.fireEvent("header" + name, this, header, e);
        }else{
            var row = v.findRowIndex(t);
            var cell = v.findCellIndex(t);
            if(row !== false){
                this.fireEvent("row" + name, this, row, e);
                if(cell !== false){
                    this.fireEvent("cell" + name, this, row, cell, e);
                }
            }
        }
    },

    /**
     * @private
     */
    onClick : function(e){
        this.processEvent("click", e);
    },

    /**
     * @private
     */
    onMouseDown : function(e){
        this.processEvent("mousedown", e);
    },

    /**
     * @private
     */
    onContextMenu : function(e, t){
        this.processEvent("contextmenu", e);
    },

    /**
     * @private
     */
    onDblClick : function(e){
        this.processEvent("dblclick", e);
    },

    /**
     * @private
     */  
    walkCells : function(row, col, step, fn, scope){
        var cm = this.colModel, clen = cm.getColumnCount();
        var ds = this.dataset, rlen = ds.getCount(), first = true;
        if(step < 0){
            if(col < 0){
                row--;
                first = false;
            }
            while(row >= 0){
                if(!first){
                    col = clen-1;
                }
                first = false;
                while(col >= 0){
                    if(fn.call(scope || this, row, col, cm) === true){
                        return [row, col];
                    }
                    col--;
                }
                row--;
            }
        } else {
            if(col >= clen){
                row++;
                first = false;
            }
            while(row < rlen){
                if(!first){
                    col = 0;
                }
                first = false;
                while(col < clen){
                    if(fn.call(scope || this, row, col, cm) === true){
                        return [row, col];
                    }
                    col++;
                }
                row++;
            }
        }
        return null;
    },

    /**
     * @private
     * 返回选择的行对应的records,如果是单元格选择模型就会出错
     * @return {Array} 选择的行对应的record数组
     */
    getSelections : function(){
        return this.selModel.getSelections();
    },

    /**
     * @private
     */
    onResize : function(){
        L5.grid.GridPanel.superclass.onResize.apply(this, arguments);
        if(this.viewReady){
            this.view.layout();
        }
    },

    /**
     * @ignore
     * 返回grid的主体Element
     * @return {Element} The element
     */
    getGridEl : function(){
        return this.body;
    },

    /**
     * @private
     * 被可编辑grid重写
     */
    stopEditing : L5.emptyFn,

    /**
     * 返回grid的选择模型.
     * @return {L5.grid.AbstractSelectionModel SelectionModel} 一个 {L5.grid.AbstractSelectionModel}
     * 的子类，如果是GridPanel则是行选择模式，如果是EditGrid则是cell列选择模式.
     */
    getSelectionModel : function(){
        if(!this.selModel){
            this.selModel = new L5.grid.RowSelectionModel(
                    this.disableSelection ? {selectRow: L5.emptyFn} : (this.rowselect?{listeners:{'rowselect':this.rowselect}}:null) );
        }else{
        	if(this.rowselect)
        		this.selModel.addListener('rowselect',this.rowselect);
        }
        return this.selModel;
    },

    /**
     * 返回Dataset.
     * @return {L5.model.Dataset} 返回grid的数据模型
     */
    getDataset : function(){
        return this.dataset;
    },

    /**
     * @private
     * @return {L5.grid.ColumnModel} 返回列模型
     */
    getColumnModel : function(){
        return this.colModel;
    },

    /**
     * @ignore
     * @return {L5.grid.GridView} 获取gridWiew有一个大数据量的gridView（ScollGridView）貌似不可用
     */
    getView : function(){
        if(!this.view){
		    if(this.enableScollGridView)
			   this.view = new L5.grid.ScollGridView(this.viewConfig);
			else
               this.view = new L5.grid.GridView(this.viewConfig);
        }
        return this.view;
    },
    /**
     * @ignore
     * Called to get grid's drag proxy text, by default returns this.ddText.
     * @return {String} The text
     */
    getDragDropText : function(){
        var count = this.selModel.getCount();
        return String.format(this.ddText, count, count == 1 ? '' : 's');
    }

    /** 
     * @cfg {String/Number} activeItem 
     * @hide 
     */
    /** 
     * @cfg {Boolean} autoDestroy 
     * @hide 
     */
    /** 
     * @cfg {Object/String/Function} autoLoad 
     * @hide 
     */
    /** 
     * @cfg {Boolean} autoWidth 
     * @hide 
     */
    /** 
     * @cfg {Boolean/Number} bufferResize 
     * @hide 
     */
    /** 
     * @cfg {String} defaultType 
     * @hide 
     */
    /** 
     * @cfg {Object} defaults 
     * @hide 
     */
    /** 
     * @cfg {Boolean} hideBorders 
     * @hide 
     */
    /** 
     * @cfg {Mixed} items 
     * @hide 
     */
    /** 
     * @cfg {String} layout 
     * @hide 
     */
    /** 
     * @cfg {Object} layoutConfig 
     * @hide 
     */
    /** 
     * @cfg {Boolean} monitorResize 
     * @hide 
     */
    /** 
     * @property items 
     * @hide 
     */
    /** 
     * @method add 
     * @hide 
     */
    /** 
     * @method cascade 
     * @hide 
     */
    /** 
     * @method doLayout 
     * @hide 
     */
    /** 
     * @method find 
     * @hide 
     */
    /** 
     * @method findBy 
     * @hide 
     */
    /** 
     * @method findById 
     * @hide 
     */
    /** 
     * @method findByType 
     * @hide 
     */
    /** 
     * @method getComponent 
     * @hide 
     */
    /** 
     * @method getLayout 
     * @hide 
     */
    /** 
     * @method getUpdater 
     * @hide 
     */
    /** 
     * @method insert 
     * @hide 
     */
    /** 
     * @method load 
     * @hide 
     */
    /** 
     * @method remove 
     * @hide 
     */
    /** 
     * @event add 
     * @hide 
     */
    /** 
     * @event afterLayout 
     * @hide 
     */
    /** 
     * @event beforeadd 
     * @hide 
     */
    /** 
     * @event beforeremove 
     * @hide 
     */
    /** 
     * @event remove 
     * @hide 
     */



    /**
     * @cfg {String} allowDomMove  @hide
     */
    /**
     * @cfg {String} autoEl @hide
     */
    /**
     * @cfg {String} applyTo  @hide
     */
    /**
     * @cfg {String} autoScroll  @hide
     */
    /**
     * @cfg {String} bodyBorder  @hide
     */
    /**
     * @cfg {String} bodyStyle  @hide
     */
    /**
     * @cfg {String} contentEl  @hide
     */
    /**
     * @cfg {String} disabledClass  @hide
     */
    /**
     * @cfg {String} elements  @hide
     */
    /**
     * @cfg {String} html  @hide
     */
    /**
     * @property disabled
     * @hide
     */
    /**
     * @method applyToMarkup
     * @hide
     */
    /**
     * @method enable
     * @hide
     */
    /**
     * @method disable
     * @hide
     */
    /**
     * @method setDisabled
     * @hide
     */
});
L5.reg('grid', L5.grid.GridPanel);