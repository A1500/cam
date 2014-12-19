/**
 *  this.onClear='';
    this.onConfirm='';
    selectFirst 是否默认选择第一行
    showReload 每次弹出，都重新加载数据
 */
/**
 * 单选帮助组件
 * @param {} config
 * @param {} searchCfg
 */ 
L5.GridHelpWindow=function(config,searchCfg){
	
	this.id=config.id;
    this.width=500;
    this.height=300;
    this.closeAction='hide';  
    this.plain=true;
    this.autoScroll=true;
    this.title='帮助信息';
    /**
     * grid面板的高度
     * @cfg
     */
    this.gridPanelHeight;
    this.searchCfg=searchCfg;
    /**
     * 是否默认选中第一行
     */
    this.selectFirst=true;
    /**
     * 是否每次展示都重新加载数据
     */
    this.showReload=false;
    /**
     * @private
     * 通过该标识位决定数据是否已脏，必须重新load数据
     */
    this._dirty=false;
    L5.apply(this, config);
    /**
     * 数据集合
     */
    this.dataset=config.dataset;
    /**
     * 点击"确定"，"清除"按钮后要返回的数据
     * @private
     */
    this.returns=null;
    /**
     * 各个字段值为空的初始Record对象
     * @private
     */
    this.initRecord=new this.dataset.recordType({});
    /**
     * 标识是否点击了"清除"按钮
     * @public
     */
    this.isClear=false;
    //为查询对象赋值
    this.searchCfg.help=this;
    this.searchCfg.dataset=this.dataset;

   var searchPanelCfg={
    		html:	this.searchCfg.getHtmls(),
    		keys:[{ 
    	        key:L5.EventObject.ENTER,   
    	        fn:this._innerquery,   
    	        scope:this
    	    }], 

    		tbar:[
    		    '->',
    			{text :'查询',
    				iconCls : "query",
    				handler : this._innerquery,scope:this},
    				'-',
    			{text : '确定',
    				iconCls : "yes",
    			  	handler : this._confirm,scope:this},
    			  	'-',
    			{text : '关闭',
    			    iconCls : "undo",
    				handler : this._giveUp,scope:this},  
    				'-',
    			{text : '清除',
    				iconCls : "no",	
    				handler : this._clear,scope:this} 		      
    		]

    	};
    L5.apply(searchPanelCfg, this.searchCfg);
	this.searchPanel=new L5.Panel(searchPanelCfg);
	
	if(!this.sm){
		this.sm=new L5.grid.RowSelectionModel();
		this.sm.singleSelect=true;
	}
	
	if(!this.gridColumns){
		this.gridColumns=L5.getGridColumns(this.dataset.fields.items)
	}
	
	var gridPanelCfg={
			dataset: this.dataset,
			sm   : this.sm,
			columns: this.gridColumns,
			stripeRows: true,
			autoScroll: true,
			height      : this.gridPanelHeight?this.gridPanelHeight:this.height,
			viewConfig  :{forceFit: L5.getGridColumnsTotalWidth(this.gridColumns)<=this.width?true:false},
			listeners   :{rowdblclick : this._confirm,scope:this},
			keys:[{ 
		        key:L5.EventObject.ENTER,   
		        fn:this._confirm,   
		        scope:this
		    }]

		};
	L5.apply(gridPanelCfg, this.gridCfg);
	this.gridPanel=new L5.grid.GridPanel(gridPanelCfg);

	this.bbar =new L5.PagingToolbar({		
		dataset    : this.dataset,
		displayInfo:true,
		displayMsg:"从第{0}条到{1}条，一共{2}条",
		emptyMsg  :"没有记录"
	});
	//整个帮助窗口布局
	this.items= [this.searchPanel, this.gridPanel];
	//添加子类的items
	this.items=this.items.concat(this.appendToItems());

	L5.GridHelpWindow.superclass.constructor.call(this);
	
	if(this.selectFirst){
		this.on('beforeshow',this.selectFirstRow,this);
		this.dataset.on('load',this.selectFirstRow,this);
	}
	
};


L5.extend(L5.GridHelpWindow, L5.Window,{
	
	_giveUp:function(e){
		this.hide();
	},
	
	_confirm:function(){
		var record=this.sm.getSelected();
		if(!record){
			L5.Msg.alert("提示","请选择记录");
			return;
		}
		this.returns=record;
		this.isClear=false;
		this.hide();
		/**
		 * (开发人员需要重写该函数，为某个域赋值)
		 */
		if(this.afterExecute){
			this.afterExecute();
		}
	},
	
	_clear:function(e){
		this.returns=this.initRecord;
		this.isClear=true;
		this.hide();
		/**
		 * (开发人员需要重写该函数，为某个域赋值)
		 */
		if(this.afterExecute){
			this.afterExecute();
		}
	},
	/**
	 * @private
	 * 弹出窗口后，执行的查询操作  (内部调用)
	 */
	_innerquery:function(){
		this.searchCfg.search();
	},
	/**
	 * @public
	 * 未弹出窗口时可调用的查询操作 (供开发人员调用)
	 */
	query : function(condition){
		this.searchCfg.bgSearch(condition);
	},
	/**
	 * noload不重新加载数据
	 * 使用通用帮助的快捷特性时，如果查询结果不符合要求弹出帮助窗口情况时，不需要再重新load数据
	 */
	show  :function(animateTarget, cb, scope,noload){
		L5.GridHelpWindow.superclass.show.call(this,animateTarget, cb, scope);
		if(noload){
			return;
		}
		if(this._dirty||this.showReload){
			this.clearSearchAndLoad();
		}
	},
	/**
	 * @public
	 * 清除查询条件
	 */
	clearSearchValue : function(){
		this.searchCfg.clearSearchValue();
	},
	/**
	 * @public
	 * 清除查询条件，重新加载数据
	 */
	clearSearchAndLoad : function(){
		this.clearSearchValue();
		this.dataset.load();
	},
	/**
	 * @private
	 * 选中第一行
	 */
	selectFirstRow : function(){
		var sm=this.gridPanel.getSelectionModel();
		var gridPanel=this.gridPanel;
		//因为该处理函数同时注册为dataset的load处理函数，防止出现window未show前调用
		if(sm.grid){
			(function(){
				//数据选择
				sm.selectFirstRow();
				//视图选择
				var row=gridPanel.getView().getRow(0);
				//如果数据未加载完毕，row为undefined
				var ele=L5.fly(row);
				if((typeof ele)!='undefined'&&ele!=null){
					ele.focus();
				}
			
			}).defer(50);
		}
	},
	/**
	 * 获取返回值
	 * @return {}
	 */
	getReturn :function (){
		return this.returns;
	},
	/**
	 * 附加面板
	 * @return {}
	 */
	appendToItems : function(){
		return [];
	}
});
L5.reg('gridHelp', L5.GridHelpWindow);
/**
 * 依据recordType生成GridPanel中的columns
 */
L5.getGridColumns=function(recordcfg){
	var columns=new Array();
	for(var i=0;i<recordcfg.length;i++){
		var obj=new Object();
		obj.header=recordcfg[i].name;
		obj.width=75;
		obj.field=recordcfg[i].name;
		obj.sortable=true;
		if(recordcfg[i].type=="date"){
			obj.renderer=L5.util.Format.dateRenderer('Y-m-d')
		}
		columns.push(obj);
	}
	return columns;
};
/**
 * 返回所有展示列的总宽度
 * @param {} columns
 * @return {}
 */
L5.getGridColumnsTotalWidth=function (columns){
	var total=0, width=100;
	for(var i=0;i<columns.length;i++){
		if(columns[i].width){
			width=columns[i].width;
		}
		total+=width;
	}
	return total;
}
/********************************************************************************************************/
/*                                多选通用帮助                                                                                                                                                             */
/********************************************************************************************************/
/**
 * 
 * 1:传入通用帮助说展现数据的唯一标志字段名称如ID，和在已选择区域中展示数据的列名称(如果未传入，这使用唯一标志字段名称通常为ID)
 * 
 */


L5.MultiGridHelpWindow=function(config,searchCfg){
	
	config.layout='border';
	config.selectFirst=false;
	config.gridCfg={region:'center'};
	searchCfg.region='north';
    /**
     * 标识是否点击了"清除"按钮
     * @public
     */
    this.isClear=false;	
	
	//已选择区
	this.selectedPanel=new L5.Panel({
			title:'已选记录',
			split:true,
			autoScroll: true,
			region:'east',
			collapsible : true,
			collapsed : true,
			html:"<div id='selectedDiv'><select id='selOpts' size='10'  multiple='multiple'></select></div>",
			width:100,
			minSize:0,
			maxSize:500
	});
    this.rightClick = new L5.menu.Menu( {
        id : 'rightClickCont',
        items : [ {
            id:'delete',
            text : '删除',
            handler : this.deleteFn,
            scope : this
        },{
            id:'deleteAll',
            text : '全部删除',
            handler : this.deleteAllFn,
            scope : this
        }]
    });
	
	this.sm=new L5.grid.CheckboxSelectionModel();

	this.dataset=config.dataset;
	this.dataset.on('datachanged',this.selectValues,this);
	config.sm=this.sm;
	
	if(!config.gridColumns){
		config.gridColumns=L5.getGridColumns(config.dataset.fields.items)
	}
	//增加checkbox列
	var allColumns=new Array();
	allColumns.push(config.sm);
	config.gridColumns=allColumns.concat(config.gridColumns);
	
	//记录唯一标志字段名称
	this.idField=config.idField;
	if(this.idField==null||typeof this.idField=='undefined'){
		//因 增加了checkbox框，所以从gridColumns[1]开始
		this.idField=config.gridColumns[1].field;
	}
	//已选记录显示名称
	this.displayField=config.displayField;
	if(this.displayField==null||typeof this.displayField=='undefined'){
		this.displayField=config.gridColumns[2].field;
	}
	//用于存储已选择的记录
	this.selectedData=new L5.util.MixedCollection();
	//是否已初始化，窗口show前进行初始化
	this.initedFlag=false;
	//show之后，为其赋值为“已选记录”面板显示内容的dom对象
	this.selectOptions=null;
	
	//调用父类构造函数
	L5.MultiGridHelpWindow.superclass.constructor.call(this,config,searchCfg);
	this.sm.on('rowselect',this.selectRow,this);
	this.sm.on('rowdeselect',this.deselectRow,this);
	//因为“beforeshow”是窗口具有的事件，所以等调用完父类构造函数后才可监听事件
	this.on('beforeshow',this.helpObjInit,this);
};


L5.extend(L5.MultiGridHelpWindow,L5.GridHelpWindow,{
	
	appendToItems : function(){
		return [this.selectedPanel];
	},
	selectRow : function(sm, rowIndex, record){
		this.addItem(record);
		this.buildOptions(record.get(this.idField),record.get(this.displayField));
	},
	deselectRow : function(sm, rowIndex, record){
		this.removeItem(record);
		this.buildOptions(record.get(this.idField),record.get(this.displayField),true);
	},
	addItem : function(record){
		this.selectedData.add(record.get(this.idField),record);		
	},
	removeItem : function(record){
		this.selectedData.removeKey(record.get(this.idField));
	},
	/**
	 * 
	 * 因执行查询、翻页(远程分页)、排序(远程排序)操作后，导致dataset重新load所有已选中的记录都变为非选中状态，
	 * 所以需要重新选中已选的记录。
	 */
	selectValues : function(){
		var records=this.selectedData.items;
		var selectedIndex=this.getRowIndex(this.gridPanel.dataset,records,this.idField);
		for(var n=0;n<selectedIndex.length;n++){
			if(selectedIndex[n]!=-1){
				this.sm.selectRow(selectedIndex[n],true);
			}
		}
	},
	/**
	 * 获取已选记录在当前dataset中的行序列号
	 */
	getRowIndex : function(dataset,records,fieldName){
		var allIndex=new Array();
		//被比较的对象
		var src;
		//要比较的对象
		var target;
		//被比较对象的集合
		var items;
		//判断是否为LocalPageDataset类型的dataset
		if(dataset.localPage){
			var start=dataset.pageInfo.startCursor;
			var end=start+dataset.getCount();
			items=dataset.data.items.slice(start,end);
		}else{
			items=dataset.data.items;
		}
		for(var i=0;i<records.length;i++){
			var index=-1;
			target=records[i];
			for(var j=0;j<items.length;j++){
				src=items[j];
				if(target.get(fieldName)==src.get(fieldName)){
					index=j;
					break;
				}
			}
			allIndex.push(index);
		}
		return allIndex;
	},
	/**
	 * 构建"已选记录"面板展示的数据
	 */
	buildOptions : function(valuePara,namePara,remove){
	 	//如果已选项中已经存在，则忽略
	 	var exist=0;
	 	for(var j=this.selectOptions.options.length-1;j>=0;j--)
	 	{
	 		var val=this.selectOptions.options[j].value;
	 		if(val==valuePara){
	 			exist=1;
	 			if(remove){
	 				L5.removeNode(this.selectOptions.options[j]);
	 				//this.selectOptions.remove(j);
	 			}
	 		}
	 	}
	 	//如果是删除操作直接返回即可
	 	if(remove){
	 		return;
	 	}
	 	//添加选项
	 	if(exist==0){
	 		L5.DomHelper.append(this.selectOptions,{tag:"option",value:valuePara,html:namePara});
	 	}
	},
	/**
	 * 右键处理函数
	 */
	rightClickFn : function(e){
        e.preventDefault();
        this.rightClick.showAt(e.getXY());
	},
	/**
	 * show之前数据初始化及添加右键事件
	 */
	helpObjInit : function(){
		if(!this.initedFlag){
			L5.get('selectedDiv').on('contextmenu',this.rightClickFn,this);
			this.selectOptions=L5.get('selOpts').dom;
			//解决IE下L5.DomHelper 添加 option 问题
			L5.DomHelper.useDom=true;
			this.initedFlag=true;
		}
	},
	/**
	 * 右键“删除”处理函数
	 */
	deleteFn : function(){
		var removedRecords=new Array();
		var key=null;
		var len=this.selectOptions.length;
		for(var i=len-1;i>=0;i--){
			 if(this.selectOptions.options[i].selected){
				 key=this.selectOptions.options[i].value;
				 removedRecords.push(this.selectedData.get(key));
				 this.selectedData.removeKey(key);
				 L5.removeNode(this.selectOptions.options[i]);
				 //this.selectOptions.options.remove(i);
			 }
		}
		//取消选中  因注册了rowdeselect事件，数据的删除和界面显示内容的删除都交给事件处理函数解决
		var deselectIndex=this.getRowIndex(this.gridPanel.dataset,removedRecords,this.idField);
		for(var n=0;n<deselectIndex.length;n++){
			if(deselectIndex[n]!=-1){
				this.sm.deselectRow(deselectIndex[n]);
			}
		}
	},
	/**
	 * 右键“删除全部”处理函数
	 */
	deleteAllFn : function(){
		//删除“已选记录”面板展示的内容
		this.selectOptions.options.length=0;
		//获取已选记录在当前dataset中的行序列号
		var deselectIndex=this.getRowIndex(this.gridPanel.dataset,this.selectedData.items,this.idField);
		//删除数据
		this.selectedData.clear();
		//取消选中  
		for(var n=0;n<deselectIndex.length;n++){
			if(deselectIndex[n]!=-1){
				this.sm.deselectRow(deselectIndex[n]);
			}
		}
	},
	_confirm:function(){
		var records=this.selectedData.items;
		if(records.length==0){
			L5.Msg.alert("提示","请选择记录");
			return;
		}
		this.returns=records;
		this.isClear=false;
		this.hide();
		/**
		 * (开发人员需要重写该函数，为某个域赋值)
		 */
		if(this.afterExecute){
			this.afterExecute();
		}	
	},
	_clear:function(e){
		this.returns=[this.initRecord];
		this.isClear=true;
		this.hide();
		/**
		 * (开发人员需要重写该函数，为某个域赋值)
		 */
		if(this.afterExecute){
			this.afterExecute();
		}
	}	
	
});
