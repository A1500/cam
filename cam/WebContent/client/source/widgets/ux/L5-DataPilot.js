/**
 * 按钮导航条，已封装成标签使用
 * @class L5.DataPilot
 * @extends L5.BoxComponent
 * @constructor
 * @private
 */
L5.DataPilot = function(config) {
	config = config || {};
	this.path = L5.webPath + "/skins/images/";
	L5.apply(this, config);
	this.dataset = L5.DatasetMgr.lookup(config.dataset);
	this.id = config.id;
	this.addEvents(
		"turnFirst",
		"prevPage",
		"movePrev",
		"moveNext",
		"nextPage",
		"turnLast"
	);
	L5.DataPilot.superclass.constructor.call(this);
};
L5.extend(L5.DataPilot, L5.BoxComponent, {

	autoCreate : {
		// cls:'DataPilot',
		html : '<table class="DataPilot" cellspacing="1" cellpadding="0"><tr></tr></table>'
	},

	// 利用Template构建导航条
	onRender : function(ct, position) {
		L5.DataPilot.superclass.onRender.call(this, ct, position);
		this.el = ct.createChild(L5.apply({
							id : this.id
						}, this.autoCreate), position);
		this.tr = this.el.child("tr", true);
		if (!this.imgTemplate) {
			if (!L5.DataPilot.imgButtonTemplate) {
				L5.DataPilot.imgButtonTemplate = new L5.Template('<td><button class="Button" title="{0}" style="padding-left: 2px; padding-right: 2px;"><table><tbody><tr><td><img src="{1}"/></td></tr></tbody></table></button></td>');
			}
			this.imgTemplate = L5.DataPilot.imgButtonTemplate;
		}
		var targs = ["第一条记录", this.path + "move_first.gif"];// &#57;
		this.turnFirstEl = this.imgTemplate.append(this.tr, targs, true);
		targs = ["上一页", this.path + "prev_page.gif"];// &#55;
		this.prevPageEl = this.imgTemplate.append(this.tr, targs, true);
		targs = ["上一条记录", this.path + "move_prev.gif"];// &#51;
		this.movePrevEl = this.imgTemplate.append(this.tr, targs, true);
		targs = ["下一条记录", this.path + "move_next.gif"];// &#52;
		this.moveNextEl = this.imgTemplate.append(this.tr, targs, true);
		targs = ["下一页", this.path + "next_page.gif"];// &#56;
		this.nextPageEl = this.imgTemplate.append(this.tr, targs, true);
		targs = ["最后一条记录", this.path + "move_last.gif"];// &#58;
		this.turnLastEl = this.imgTemplate.append(this.tr, targs, true);

	},

	// 注册事件
	afterRender : function() {
		this.add.apply(this, this.items);
		this.turnFirstEl.first().on("click",this.turnFirst, this);
		this.prevPageEl.first().on("click",this.prevPage, this);
		this.movePrevEl.first().on("click",this.movePrev, this);
		this.moveNextEl.first().on("click",this.moveNext, this);
		this.nextPageEl.first().on("click",this.nextPage, this);
		this.turnLastEl.first().on("click",this.turnLast, this);
	},
	
	add : function(){
        var a = arguments, l = a.length;
        for(var i = 0; i < l; i++){
            var el = a[i];
            this.addButton(el);
			
        }
    },
    addButton: function(config){
    	if (!this.butTemplate) {
			if (!L5.DataPilot.buttonTemplate) {
				L5.DataPilot.buttonTemplate = new L5.Template('<td><button class="Button" title="{0}" style="padding-left: 3px; padding-right: 3px;">{0}</button></td>');
			}
			this.butTemplate = L5.DataPilot.buttonTemplate;
		}
		var button = this.butTemplate.append(this.tr, [config.text], true);
		if(config.handler!=null)
		button.first().on("click",config.handler, this);   	
    },

	nextBlock : function() {
		var td = document.createElement("td");
		this.tr.appendChild(td);
		return td;
	},
	// 第一条记录
	turnFirst : function() {
		this.dataset.turnFirst();
		this.fireEvent("turnFirst", this, this.dataset);
	},

	// 最后一条记录
	turnLast : function() {
		this.dataset.turnLast();
		this.fireEvent("turnLast", this, this.dataset);
	},

	// 下一条记录
	moveNext : function() {
		this.dataset.moveNext();
		this.fireEvent("moveNext", this, this.dataset);
	},

	// 上一条记录
	movePrev : function() {
		this.dataset.movePrev();
		this.fireEvent("movePrev", this, this.dataset);
	},

	// 翻到下一页
	nextPage : function() {
		this.dataset.turnNext();
		this.fireEvent("nextPage", this, this.dataset);
	},

	// 翻到前一页
	prevPage : function() {
		this.dataset.turnPrev();
		this.fireEvent("prevPage", this, this.dataset);
	}
});
L5.reg('DataPilot', L5.DataPilot);