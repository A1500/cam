//version 3.0

L5.ux.Multiselect = L5.extend(L5.form.Field,  {
	dataset:null,
	dataFields:[],
	data:[],
/*	width:100,
	height:100,*/
	displayField:1,
	valueField:0,
	allowBlank:true,
	minLength:0,
	maxLength:Number.MAX_VALUE,
	blankText:L5.form.TextField.prototype.blankText,
	minLengthText:'Minimum {0} item(s) required',
	maxLengthText:'Maximum {0} item(s) allowed',
	copy:false,
	allowDup:false,
	allowTrash:false,
	legend:null,
	focusClass:undefined,
	delimiter:',',
	view:null,
	dragGroup:null,
	dropGroup:null,
	tbar:null,
	appendOnly:false,
	sortField:null,
	sortDir:'ASC',
	defaultAutoCreate : {tag: "div"},
	
    initComponent: function(){
		L5.ux.Multiselect.superclass.initComponent.call(this);
		this.addEvents({
			'dblclick' : true,
			'click' : true,
			'change' : true,
			'drop' : true
		});		
	},
    onRender: function(ct, position){
		var fs, cls, tpl;
		L5.ux.Multiselect.superclass.onRender.call(this, ct, position);

		cls = 'ux-mselect';

		fs = new L5.form.FieldSet({
			renderTo:this.el,
			title:this.legend,
			height:this.height,
			width:this.width,
			style:"padding:1px;",
			tbar:this.tbar
		});
//		if(!this.legend)fs.el.down('.'+fs.headerCls).remove();
		fs.body.addClass(cls);

		tpl = '<tpl for="."><div class="' + cls + '-item';
		if(L5.isIE || L5.isIE7)tpl+='" unselectable=on';
		else tpl+=' l-unselectable"';
		tpl+='>{' + this.displayField + '}</div></tpl>';

		if(!this.dataset){
			this.dataset = new L5.model.SimpleDataset({
				fields: this.dataFields,
				data : this.data
			});
		}

		this.view = new L5.ux.DDView({
			multiSelect: true, dataset: this.dataset, selectedClass: cls+"-selected", tpl:tpl,
			allowDup:this.allowDup, copy: this.copy, allowTrash: this.allowTrash, 
			dragGroup: this.dragGroup, dropGroup: this.dropGroup, itemSelector:"."+cls+"-item",
			isFormField:false, applyTo:fs.body, appendOnly:this.appendOnly,
			sortField:this.sortField, sortDir:this.sortDir
		});

		fs.add(this.view);
		
		this.view.on('click', this.onViewClick, this);
		this.view.on('beforeClick', this.onViewBeforeClick, this);
		this.view.on('dblclick', this.onViewDblClick, this);
		this.view.on('drop', function(ddView, n, dd, e, data){
	    	return this.fireEvent("drop", ddView, n, dd, e, data);
		}, this);
		
		this.hiddenName = this.name;
		var hiddenTag={tag: "input", type: "hidden", value: "", name:this.name};
		if (this.isFormField) { 
			this.hiddenField = this.el.createChild(hiddenTag);
		} else {
			this.hiddenField = L5.get(document.body).createChild(hiddenTag);
		}
		fs.doLayout();
	},
	
	initValue:L5.emptyFn,
	
	onViewClick: function(vw, index, node, e) {
		var arrayIndex = this.preClickSelections.indexOf(index);
		if (arrayIndex  != -1)
		{
			this.preClickSelections.splice(arrayIndex, 1);
			this.view.clearSelections(true);
			this.view.select(this.preClickSelections);
		}
		this.fireEvent('change', this, this.getValue(), this.hiddenField.dom.value);
		this.hiddenField.dom.value = this.getValue();
		this.fireEvent('click', this, e);
		this.validate();		
	},

	onViewBeforeClick: function(vw, index, node, e) {
		this.preClickSelections = this.view.getSelectedIndexes();
		if (this.disabled) {return false;}
	},

	onViewDblClick : function(vw, index, node, e) {
		return this.fireEvent('dblclick', vw, index, node, e);
	},	
	
	getValue: function(valueField){
		var returnArray = [];
		var selectionsArray = this.view.getSelectedIndexes();
		if (selectionsArray.length == 0) {return '';}
		for (var i=0; i<selectionsArray.length; i++) {
			returnArray.push(this.dataset.getAt(selectionsArray[i]).get(((valueField != null)? valueField : this.valueField)));
		}
		return returnArray.join(this.delimiter);
	},

	setValue: function(values) {
		var index;
		var selections = [];
		this.view.clearSelections();
		this.hiddenField.dom.value = '';
		
		if (!values || (values == '')) { return; }
		
		if (!(values instanceof Array)) { values = values.split(this.delimiter); }
		for (var i=0; i<values.length; i++) {
			index = this.view.dataset.indexOf(this.view.dataset.query(this.valueField, 
				new RegExp('^' + values[i] + '$', "i")).itemAt(0));
			selections.push(index);
		}
		this.view.select(selections);
		this.hiddenField.dom.value = this.getValue();
		this.validate();
	},
	
	reset : function() {
		this.setValue('');
	},
	
	getRawValue: function(valueField) {
        var tmp = this.getValue(valueField);
        if (tmp.length) {
            tmp = tmp.split(this.delimiter);
        }
        else{
            tmp = [];
        }
        return tmp;
    },

    setRawValue: function(values){
        setValue(values);
    },

    validateValue : function(value){
        if (value.length < 1) { // if it has no value
             if (this.allowBlank) {
                 this.clearInvalid();
                 return true;
             } else {
                 this.markInvalid(this.blankText);
                 return false;
             }
        }
        if (value.length < this.minLength) {
            this.markInvalid(String.format(this.minLengthText, this.minLength));
            return false;
        }
        if (value.length > this.maxLength) {
            this.markInvalid(String.format(this.maxLengthText, this.maxLength));
            return false;
        }
        return true;
    }
});

L5.reg("multiselect", L5.ux.Multiselect);

L5.ux.ItemSelector = L5.extend(L5.form.Field,  {
    /**
     * id
     * @String 
	 * @requires
     */
	/**
	 * 名称 同Html元素的名称
	 * @String
	 * @requires
	 */
	name:null,
	/**
	 * 指定右栏数据对应Record的哪个Field，用于数据绑定
	 * @type sring
	 * @requires
	 */
	field:null,
	/**
	 * 双栏边框组件宽度（因该组件继承自之L5.form.Field，为避免冲突不采用width作为属性名称）
	 * @type Number
	 */
	msWidth:150,
	/**
	 * 双栏边框组件高度（因该组件继承自之L5.form.Field，为避免冲突不采用height作为属性名称）
	 * @type Number
	 */
	msHeight:200,
	/**
	 * 是否隐藏所有的图标（左右移，上下移等）
	 * @type Boolean
	 */
	hideNavIcons:false,
	iconUp:"multiselect_up2",
	iconDown:"multiselect_down2",
	iconLeft:"multiselect_left2",
	iconRight:"multiselect_right2",
	iconTop:"multiselect_top2",
	iconBottom:"multiselect_bottom2",
	/**
	 *  向上图标是否显示
	 * @type Boolean
	 */
	drawUpIcon:true,
	/**
	 * 向下图标是否显示
	 * @type Boolean
	 */
	drawDownIcon:true,
	/**
	 * 左移图标是否显示
	 * @type Boolean
	 */
	drawLeftIcon:true,
	/**
	 * 右移图标是否显示
	 * @type Boolean
	 */
	drawRightIcon:true,
	/**
	 * 置顶图标是否显示
	 * @type Boolean
	 */
	drawTopIcon:true,
	/**
	 * 置底图标是否显示
	 * @type Boolean
	 */
	drawBotIcon:true,
	/**
	 * 左边栏数据来源
	 * @type 
	 */
	fromDataset:null,
	/**
	 * 右边栏数据来源，通常不需要设置
	 * @type 
	 */
	toDataset:null,
	/**
	 * 可以用数组的形式为fromData属性赋值，代替fromDataset。如：fromData:[[1,'足球'],[2,'篮球'],[3,'网球'],[4,'台球']]
	 * @type 
	 */
	fromData:null, 
	/**
	 * 显示内容对应的Field名称
	 */
	displayField:1,
	/**
	 * 存储内容对应的Field名称
	 * @type Number
	 */
	valueField:0,
	switchToFrom:false,
	allowDup:false,
	focusClass:undefined,
	/**
	 * 多个value之间的间隔符，默认为”,“
	 * @type String
	 */
	delimiter:',',
	/**
	 * 是否只读，默认false
	 * @type Boolean
	 */
	readOnly:false,
	/**
	 * 右边栏Titel
	 * @type String
	 */
	toLegend:"已选内容",
	/**
	 * 左边栏Title
	 * @type String
	 */
	fromLegend:"可选内容",
	toSortField:null,
	fromSortField:null,
	toSortDir:'ASC',
	fromSortDir:'ASC',
	/**
	 * 右栏工具条设置
	 * @type 
	 */
	toTBar:null,
	/**
	 * 左栏工具条设置
	 * @type 
	 */
	fromTBar:null,
	bodyStyle:null,
	border:false,
	defaultAutoCreate:{tag: "div"},
	
    initComponent: function(){
		L5.ux.ItemSelector.superclass.initComponent.call(this);
		this.addEvents({
			'rowdblclick' : true,
			'change' : true
		});			
	},
    onRender: function(ct, position){
		L5.ux.ItemSelector.superclass.onRender.call(this, ct, position);
		
		if(!this.fromDataset && this.fromData){
			this.fromDataset = new L5.model.SimpleDataset({
				fields: this.dataFields,
				id : 0,
				data : this.fromData
			});
		}

		this.fromMultiselect = new L5.ux.Multiselect({
			legend: this.fromLegend,
			delimiter: this.delimiter,
			allowDup: this.allowDup,
			copy: this.allowDup,
			allowTrash: this.allowDup,
			dragGroup: this.readOnly ? null : "drop2-"+this.el.dom.id,
			dropGroup: this.readOnly ? null : "drop2-"+this.el.dom.id+",drop1-"+this.el.dom.id,
			width: this.msWidth,
			height: this.msHeight,
			dataFields: this.dataFields,
			displayField: this.displayField,
			valueField: this.valueField,
			dataset: this.fromDataset,
			isFormField: false,
			tbar: this.fromTBar,
			appendOnly: false,
			sortField: this.fromSortField,
			sortDir: this.fromSortDir
		});
		this.fromMultiselect.on('dblclick', this.onRowDblClick, this);

		if (!this.toDataset) {
			this.toDataset = new L5.model.Dataset({
				fields: this.dataFields
			});
		}
		this.toDataset.on('add', this.valueChanged, this);
		this.toDataset.on('remove', this.valueChanged, this);
		this.toDataset.on('load', this.valueChanged, this);

		this.toMultiselect = new L5.ux.Multiselect({
			legend: this.toLegend,
			delimiter: this.delimiter,
			allowDup: this.allowDup,
			dragGroup: this.readOnly ? null : "drop1-"+this.el.dom.id,
			dropGroup: this.readOnly ? null : "drop2-"+this.el.dom.id+",drop1-"+this.el.dom.id,
			width: this.msWidth,
			height: this.msHeight,
			displayField: this.displayField,
			valueField: this.valueField,
			dataset: this.toDataset,
			isFormField: false,
			tbar: this.toTBar,
			sortField: this.toSortField,
			sortDir: this.toSortDir
		});
		this.toMultiselect.on('dblclick', this.onRowDblClick, this);		
		var p = new L5.Panel({
			bodyStyle:this.bodyStyle,
			border:this.border,
			layout:"table",
			layoutConfig:{columns:3}
		});
		p.add(this.switchToFrom ? this.toMultiselect : this.fromMultiselect);
		var icons = new L5.Panel({header:false});
		p.add(icons);
		p.add(this.switchToFrom ? this.fromMultiselect : this.toMultiselect);
		p.render(this.el);
		icons.el.down('.'+icons.bwrapCls).remove();


		var el=icons.getEl();
		if (!this.toSortField) {
			this.toTopIcon = el.createChild({tag:"button",cls:this.iconTop,style:{margin:'2px',width:'20px'}});
			el.createChild({tag: 'br'});
			this.upIcon = el.createChild({tag:"button",cls:this.iconUp, style:{margin:'2px',width:'20px'}});
			el.createChild({tag: 'br'});
		}
		this.addIcon = el.createChild({tag:"button",cls:this.switchToFrom?this.iconLeft:this.iconRight,style:{margin:'2px',width:'20px'}});
		el.createChild({tag: 'br'});
		this.removeIcon = el.createChild({tag:"button",cls:this.switchToFrom?this.iconRight:this.iconLeft, style:{margin:'2px',width:'20px'}});
		el.createChild({tag: 'br'});
		if (!this.toSortField) {
			this.downIcon = el.createChild({tag:"button",cls:this.iconDown, style:{margin:'2px',width:'20px'}});
			el.createChild({tag: 'br'});
			this.toBottomIcon = el.createChild({tag:"button",cls:this.iconBottom, style:{margin:'2px',width:'20px'}});
		}
		if (!this.readOnly) {
			if (!this.toSortField) {
				this.toTopIcon.on('click', this.toTop, this);
				this.upIcon.on('click', this.up, this);
				this.downIcon.on('click', this.down, this);
				this.toBottomIcon.on('click', this.toBottom, this);
			}
			this.addIcon.on('click', this.fromTo, this);
			this.removeIcon.on('click', this.toFrom, this);
		}
		if (!this.drawUpIcon || this.hideNavIcons) { this.upIcon.dom.style.display='none'; }
		if (!this.drawDownIcon || this.hideNavIcons) { this.downIcon.dom.style.display='none'; }
		if (!this.drawLeftIcon || this.hideNavIcons) { this.addIcon.dom.style.display='none'; }
		if (!this.drawRightIcon || this.hideNavIcons) { this.removeIcon.dom.style.display='none'; }
		if (!this.drawTopIcon || this.hideNavIcons) { this.toTopIcon.dom.style.display='none'; }
		if (!this.drawBotIcon || this.hideNavIcons) { this.toBottomIcon.dom.style.display='none'; }

		var tb = p.body.first();
		if(L5.isIE){
			this.el.setWidth(p.body.first().getWidth());
		}else{
			this.el.setWidth(p.body.first().getWidth()+105);
		}
		p.body.removeClass();
		
		this.hiddenName = this.name;
		var temp = L5.get(this.id);
		if(temp==null){
			var hiddenTag={tag: "input", type: "hidden", value: "", name:this.name,field:this.field,systype:'itemselector'};
			this.hiddenField = this.el.createChild(hiddenTag);
		}else{
			this.hiddenField = temp;
		}
		this.valueChanged(this.toDataset);
	},

	initValue:L5.emptyFn,
	/**
	 * 初始化多选框的值 ，期间必须保证fromMultiselect.dataset不再重新load（如果远程排序将会触发load事件）
	 * @param {} values
	 */
	setSelectedValues:function(values){
		if (!(values instanceof Array)) {
			if(!values||values=="") {
				this.reset();//当values为空时，将双边栏置空
				return;
			}
			values = values.split(this.delimiter);
		}
		//重置双栏边框中的内容
		this.reset(false);
		var formDataset,toDataset;
		var records = [];
		for(var i=0;i<values.length;i++){
			var record=this.fromMultiselect.dataset.getById(values[i]);
			if(record){
				records[records.length]=record;
				this.fromMultiselect.dataset.remove(record);
			}
		}
		if(records){
			this.toMultiselect.dataset.add(records);
		}
	},	
	/**
	 * 置顶
	 */
	toTop : function() {
		var selectionsArray = this.toMultiselect.view.getSelectedIndexes();
		var records = [];
		if (selectionsArray.length > 0) {
			selectionsArray.sort();
			for (var i=0; i<selectionsArray.length; i++) {
				record = this.toMultiselect.view.dataset.getAt(selectionsArray[i]);
				records.push(record);
			}
			selectionsArray = [];
			for (var i=records.length-1; i>-1; i--) {
				record = records[i];
				this.toMultiselect.view.dataset.remove(record);
				this.toMultiselect.view.dataset.insert(0, record);
				selectionsArray.push(((records.length - 1) - i));
			}
		}
		this.toMultiselect.view.refresh();
		this.toMultiselect.view.select(selectionsArray);
	},
	/**
	 * 置底
	 */
	toBottom : function() {
		var selectionsArray = this.toMultiselect.view.getSelectedIndexes();
		var records = [];
		if (selectionsArray.length > 0) {
			selectionsArray.sort();
			for (var i=0; i<selectionsArray.length; i++) {
				record = this.toMultiselect.view.dataset.getAt(selectionsArray[i]);
				records.push(record);
			}
			selectionsArray = [];
			for (var i=0; i<records.length; i++) {
				record = records[i];
				this.toMultiselect.view.dataset.remove(record);
				this.toMultiselect.view.dataset.add(record);
				selectionsArray.push((this.toMultiselect.view.dataset.getCount()) - (records.length - i));
			}
		}
		this.toMultiselect.view.refresh();
		this.toMultiselect.view.select(selectionsArray);
	},
	/**
	 * 上移
	 */
	up : function() {
		var record = null;
		var selectionsArray = this.toMultiselect.view.getSelectedIndexes();
		selectionsArray.sort();
		var newSelectionsArray = [];
		if (selectionsArray.length > 0) {
			for (var i=0; i<selectionsArray.length; i++) {
				record = this.toMultiselect.view.dataset.getAt(selectionsArray[i]);
				if ((selectionsArray[i] - 1) >= 0) {
					this.toMultiselect.view.dataset.remove(record);
					this.toMultiselect.view.dataset.insert(selectionsArray[i] - 1, record);
					newSelectionsArray.push(selectionsArray[i] - 1);
				}
			}
			this.toMultiselect.view.refresh();
			this.toMultiselect.view.select(newSelectionsArray);
		}
	},
	/**
	 * 下移
	 */
	down : function() {
		var record = null;
		var selectionsArray = this.toMultiselect.view.getSelectedIndexes();
		selectionsArray.sort();
		selectionsArray.reverse();
		var newSelectionsArray = [];
		if (selectionsArray.length > 0) {
			for (var i=0; i<selectionsArray.length; i++) {
				record = this.toMultiselect.view.dataset.getAt(selectionsArray[i]);
				if ((selectionsArray[i] + 1) < this.toMultiselect.view.dataset.getCount()) {
					this.toMultiselect.view.dataset.remove(record);
					this.toMultiselect.view.dataset.insert(selectionsArray[i] + 1, record);
					newSelectionsArray.push(selectionsArray[i] + 1);
				}
			}
			this.toMultiselect.view.refresh();
			this.toMultiselect.view.select(newSelectionsArray);
		}
	},
	/**
	 * 左移
	 */
	fromTo : function() {
		var selectionsArray = this.fromMultiselect.view.getSelectedIndexes();
		var records = [];
		if (selectionsArray.length > 0) {
			for (var i=0; i<selectionsArray.length; i++) {
				record = this.fromMultiselect.view.dataset.getAt(selectionsArray[i]);
				records.push(record);
			}
			if(!this.allowDup)selectionsArray = [];
			for (var i=0; i<records.length; i++) {
				record = records[i];
				if(this.allowDup){
					var x=new L5.model.Record();
					record.id=x.id;
					delete x;	
					this.toMultiselect.view.dataset.add(record);
				}else{
					var toDsChangeRecs = this.toMultiselect.view.dataset.getAllChangedRecords();
					var toRecTemp = {};
					L5.applyIf(toRecTemp,record);
					this.fromMultiselect.view.dataset.remove(record);
					for(var k=0;k<toDsChangeRecs.length;k++){
						if(toDsChangeRecs[k].get(this.valueField)===toRecTemp.get(this.valueField)){
							toRecTemp = toDsChangeRecs[k];
							break;
						}
					}
					this.toMultiselect.view.dataset.add(toRecTemp);
					selectionsArray.push((this.toMultiselect.view.dataset.getCount() - 1));
				}
			}
		}
		this.toMultiselect.view.refresh();
		this.fromMultiselect.view.refresh();
		if(this.toSortField)this.toMultiselect.dataset.sort(this.toSortField, this.toSortDir);
		if(this.allowDup)this.fromMultiselect.view.select(selectionsArray);
		else this.toMultiselect.view.select(selectionsArray);
	},
	/**
	 * 右移
	 */
	toFrom : function() {
		var selectionsArray = this.toMultiselect.view.getSelectedIndexes();
		var records = [];
		if (selectionsArray.length > 0) {
			for (var i=0; i<selectionsArray.length; i++) {
				record = this.toMultiselect.view.dataset.getAt(selectionsArray[i]);
				records.push(record);
			}
			selectionsArray = [];
			for (var i=0; i<records.length; i++) {
				record = records[i];
				var formRecTemp = {};
				L5.applyIf(formRecTemp,record);
				this.toMultiselect.view.dataset.remove(record);
				if(!this.allowDup){
					var fromDsChangeRecs = this.fromMultiselect.view.dataset.getAllChangedRecords();
					for(var k=0;k<fromDsChangeRecs.length;k++){
						if(fromDsChangeRecs[k].get(this.valueField)===formRecTemp.get(this.valueField)){
							formRecTemp = fromDsChangeRecs[k];
							break;
						}
					}
					this.fromMultiselect.view.dataset.add(formRecTemp);
					selectionsArray.push((this.fromMultiselect.view.dataset.getCount() - 1));
				}
			}
		}
		this.fromMultiselect.view.refresh();
		this.toMultiselect.view.refresh();
		if(this.fromSortField)this.fromMultiselect.dataset.sort(this.fromSortField, this.fromSortDir);
		this.fromMultiselect.view.select(selectionsArray);
	},
	
	valueChanged: function(ds) {
		var record = null;
		var values = [];
		for (var i=0; i<ds.getCount(); i++) {
			record = ds.getAt(i);
			values.push(record.get(this.valueField));
		}
		this.hiddenField.dom.value = values.join(this.delimiter);
		L5.fireEvent(this.hiddenField.dom,'change');
		this.fireEvent('change', this, this.getValue(), this.hiddenField.dom.value);
	},
	/**
	 * 获取原始值
	 * @return {}
	 */
	getValue : function() {
		return this.hiddenField.dom.value;
	},
	
	onRowDblClick : function(vw, index, node, e) {
		return this.fireEvent('rowdblclick', vw, index, node, e);
	},
	/**
	 * 置空右栏的数据
	 */
	reset: function(trigger){
		range = this.toMultiselect.dataset.getRange();
		if(range.length==0) return;
		this.toMultiselect.dataset.removeAll();
		if (!this.allowDup) {
			this.fromMultiselect.dataset.add(range);
			//暂时只支持前台的排序
			 if(!this.fromMultiselect.dataset.remoteSort){
				this.fromMultiselect.dataset.sort(this.fromSortField,'ASC');
			 }
		}
		if(trigger===false){
			return;
		}
		this.valueChanged(this.toMultiselect.dataset);
	}
});

L5.reg("itemselector", L5.ux.ItemSelector);