/**
 * @class L5.FloatToolBar
 * @extends L5.Panel
 * FloatToolBar是一个基本的容器组件，它可以放置按钮
 * 实现浮动按钮功能，随滚动条滚动位置浮动。
 */
L5.ux.FloatPanel = L5.extend(L5.Panel, {
	//TODO
	//是否需要初始大小
	width : 300,
	height : 200,
    /**
     * 是否高度（或宽度）达到一定程度，自动出现滚动条，默认为false
     */
    autoScroll : false,
    /**
     * @private
     * 浮动按钮框显示位置,默认为top。
     *  right表示浏览器右边界（或右上、右下）；top 表示浏览器上边界。
     *  left表示浏览器右边界；bottom 表示浏览器上边界。
     */
    location : "top",
    /**
     * 浮动图片显示样式
     */
    floatDivCls : "l-floatpanel-imgdiv",
    allowDomMove : false,

    /**
     * @private
     */ 
    initComponent : function(){
        L5.ux.FloatPanel.superclass.initComponent.call(this);
    },
    /**
     * @private
     * 当组件渲染的时候调用，主要是初始化组件内部的小组件以及增加样式等
     */
    onRender : function(ct, position){
    	//this.renderDom = ct ? L5.getDom(ct) : document.body;
    	this.renderDom =  document.body;
    	//滚动图片和高度初始化设置
        if (this.location=="right") {
        	this.floatDivCls = this.floatDivCls + "-right";
        	this.topPos = this.renderDom.clientHeight/3;
        	this.rightPos = 0;
        } else if(this.location=="top") {
        	this.floatDivCls = this.floatDivCls+ "-top";
        	this.topPos = 0;
        	this.rightPos = this.renderDom.clientWidth/20;
        } 
        if(!this.el){
        	//创建显示图片div和按钮框div
        	var floatParentDiv = ct.createChild({
                id: this.id+'_floatParentDiv',
                style : 'position:absolute;right:'+this.rightPos+';top:'+this.topPos+';',
                cls : this.float_parent_div
            }, position);
        	var floatMeumDiv = floatParentDiv.createChild({
                id: this.id+'_floatMeumDiv',
                style : 'position:relative;overflow:hidden;z-index:50px;',
                cls : this.floatDivCls
            });
        	floatMeumDiv = floatMeumDiv.dom;
        	//进行水平显示还是垂直显示的判断设置相应大小信息
        	if (this.location=="right") {
         		floatMeumDiv.style.width="15"+"px";
         		floatMeumDiv.style.height="200"+"px";
         	} else if(this.location=="top") {
        		floatMeumDiv.style.width="125"+"px";
        		floatMeumDiv.style.height="15"+"px";
        	}        		
            this.el = floatParentDiv.createChild({
                id: this.id,
                cls: this.baseCls
            });
        	this.floatMeumDiv = floatMeumDiv;
            this.floatPanelDom = this.el.dom;
        }
        L5.ux.FloatPanel.superclass.onRender.call(this, L5.get(this.renderDom), position);
    },
    /**
     * @private
     * render最后调用，主要是更新容器的内容，进行数据绑定等
     */
    afterRender : function(){
        L5.ux.FloatPanel.superclass.afterRender.call(this);
        this.initEvents();
        //给firefox定义contains()方法，ie下不起作用
    	if(typeof(HTMLElement)!="undefined") {
    		HTMLElement.prototype.contains=function (obj) {
    	     	while(obj!=null&&typeof(obj.tagName)!="undefind"){// 通过循环对比来判断是不是obj的父元素
    	     		if(obj==this) return true;
    	     		obj=obj.parentNode;
    	     	}
    	     	return false;
    		};
    	}
		//隐藏按钮框
	 	this.floatPanelDom.style.display="none";
    },
    /**
     * @private
     */
    initEvents : function(){
    	L5.ux.FloatPanel.superclass.initEvents.call(this);
    	//绑定滚动条事件
    	//可能document.body不支持onscroll事件，换为window
    	var renderDom = this.renderDom;
    	if(L5.get(renderDom) == L5.get(document.body)){
    		renderDom = window;
    	}
    	L5.EventManager.on(renderDom, 'scroll', this.syncScroll, this);
    	//绑定鼠标划过事件，隐藏浮动图标显示浮动按钮窗
    	L5.get(this.floatMeumDiv).on('mouseover', this.show, this);
        //鼠标移出隐藏窗体
    	this.el.on('mouseout', this.hide, this);
    },
    /**
     * 在销毁容器之前调用，将容器的一些组件销毁
     */
    beforeDestroy : function(){
        L5.destroy(
            this.floatMeumDiv,
            this.floatPanelDom
        );
        L5.ux.FloatPanel.superclass.beforeDestroy.call(this);
    },
    /**
     * 隐藏窗口.
     * @param {Function} callback (可选) 当隐藏的时候，会回调这个函数。
     * @param {Object} scope (可选) 回调函数的作用域。
     */
    hide : function(theEvent){
    	if(this.fireEvent("beforehide", this) !== false){
            this.hidden = true;
            if(this.rendered){
            	this.hideFloatButton(theEvent);
            }
            this.fireEvent("hide", this);
        }
        return this;
    },

    /**
     * 隐藏浮动按钮窗
     * @param theEvent
     */
    hideFloatButton : function(theEvent){
    	if (theEvent){
    		var browser=navigator.userAgent;
    		if (browser.indexOf("Firefox")>0){//如果是Firefox
    			if (this.floatPanelDom.contains(theEvent.relatedTarget)) {//如果是子元素
    				return;
    			}
      		}
      		if (browser.indexOf("MSIE")>0 || browser.indexOf("Presto")>=0){//如果是IE
             	if (this.floatPanelDom.contains(event.toElement)) {//如果是子元素
           			return;//结束函式
          		}
      		}
       	}
    	this.floatMeumDiv.style.display = "block";
    	this.floatPanelDom.style.display="none";
    },
    show : function (){
    	if(this.fireEvent("beforeshow", this) !== false){
            this.hidden = false;
            if(this.autoRender){
                this.render(typeof this.autoRender == 'boolean' ? L5.getBody() : this.autoRender);
            }
            if(this.rendered){
                this.showFloatButton();
            }
            this.fireEvent("show", this);
        }
        return this;
    },
    setSize : function (w,h){
    	this.width = w?w:this.width;
    	this.height = h?h:this.height;
    	L5.ux.FloatPanel.superclass.setSize.call(this,w,h);
    },
    /**
     * 显示浮动按钮窗
     * @param theEvent
     */
    showFloatButton : function () {
    	this.floatMeumDiv.style.display="none";
    	//使按钮框显示并设置显示位置
    	this.floatPanelDom.style.left = "";
    	this.floatPanelDom.style.display="block";
    	//记录初始滚动值，用来解决先滑动横向滚动条后弹窗浮动按钮框再滑动滚动条时的位置问题
    	var initScrollLeft = this.renderDom.scrollLeft || document.body.scrollLeft || window.pageXOffset || document.documentElement.scrollLeft || 0;
    	if (this.location=="right") {
    		this.floatPanelDom.style.top = this.floatMeumDiv.style.posTop + 20+ "px";
        	//必须减去初始滚动值
        	this.floatPanelDom.style.right = (this.rightPos - initScrollLeft) + "px";
        } else if(this.location=="top") {
    		this.floatPanelDom.style.top = this.floatMeumDiv.style.posTop + "px";
    		//必须减去初始滚动值
        	this.floatPanelDom.style.right = (this.rightPos - initScrollLeft) + "px";
        }  
    	this.floatPanelDom.style.position="relative";
    },
    /**
     * 浮动窗随滚动条浮动
     */
    syncScroll : function () {
    	if(this.floatMeumDiv != null) {
			//改变上边界值
			var scrollY = this.renderDom.scrollTop || document.body.scrollTop || window.pageYOffset || document.documentElement.scrollTop || 0;
			var scrollX = this.renderDom.scrollLeft || document.body.scrollLeft || window.pageXOffset || document.documentElement.scrollLeft || 0;
			if(this.floatMeumDiv.style.top == "")
				this.floatMeumDiv.style.top = 0 + "px";
			this.floatMeumDiv.style.top = scrollY + "px";
			//按钮
			if(this.floatPanelDom.style.top == "")
				this.floatPanelDom.style.top = 0 + "px";
			this.floatPanelDom.style.top = scrollY + "px";
			
			//改变左边界值
			if(this.floatMeumDiv.style.left == "")
				this.floatMeumDiv.style.left = 0 + "px";
			this.floatMeumDiv.style.left = scrollX + "px";
			//按钮
			if(this.floatPanelDom.style.left == "")
				this.floatPanelDom.style.left = 0 + "px";
			this.floatPanelDom.style.left = scrollX + "px";
		}
	}
});
L5.reg('floatpanel', L5.ux.FloatPanel);