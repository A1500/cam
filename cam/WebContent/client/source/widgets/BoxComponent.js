/**
 * @class L5.BoxComponent
 * @extends L5.Component
 * 盒子模型组件的父类，盒状模型提供了控制组件尺寸大小，位置等一系列操作。所有的盒状模型的容器组件子类都需要有一个布局（layout）。
 * 我们可以用一个基本的HTML元素定义一个盒子模型组件，例如：
 * var pageHeader = new L5.BoxComponent({
 * 		el: 'my-header-div'
 * });
 */

L5.BoxComponent = L5.extend(L5.Component, {
    /**
     * @private
     * @cfg {Number} x
     * 组件在父容器内的x坐标
     */
    /**
     * @private
     * @cfg {Number} y
     * 组件在父容器内的y坐标
     */
    /**
     * @private
     * @cfg {Number} pageX
     * 组件在页面内的x坐标
     */
    /**
     * @private
     * @cfg {Number} pageY
     * 组件在页面内的y坐标
     */
    /**
     * @cfg {Number} height
     * 组件的高度(默认是auto).
     */
    /**
     * @cfg {Number} width
     * 组件的宽度(默认是auto).
     */
    /**
     * @cfg {Boolean} autoHeight
     * True相当于设置height:'auto',否则使用像素(默认是false).
     */
    /**
     * @cfg {Boolean} autoWidth
     * True相当于设置width:'auto',否则使用像素(默认是false).
     */

	/**
	 * 主要是增加了两个属性以及两个事件，主要的逻辑操作都在父类L5.Component的initComponent里面完成
	 */
    initComponent : function(){	  
        L5.BoxComponent.superclass.initComponent.call(this);
        this.oldHeight=this.height;
        this.oldWidth=this.width;
        this.addEvents(
            /**
             * @ignore
             * @event resize
             * 当组件大小改变时候触发
             * @param {L5.Component} this
             * @param {Number} adjWidth 新的宽度
             * @param {Number} adjHeight 新的高度
             * @param {Number} rawWidth 改变之前的宽度
             * @param {Number} rawHeight 改变之前的高度
             */
            'resize',
            /**
             * @ignore
             * @event move
             * 当组件被移动的时候触发
             * @param {L5.Component} this
             * @param {Number} x 新的x坐标
             * @param {Number} y 新的y坐标
             */
            'move'
        );
    },

    /**
     * @private
     * 当组件执行afterRender后被设置成true，标志着这件渲染完成
     */
    boxReady : false,
    /**
     * @private
     * 是否延迟设置组件的高度
     */
    deferHeight: false,

    /**
     * 设置组件的宽度和高度，该方法将触发“resize”事件
     * @param {Number/Object} width 新的宽度，或者一个json对象，对象内包含属性width和height
     * @param {Number} height 新的高度，如果第一个对象是object将不会起作用
     * @return {L5.BoxComponent} 返回组件本身
     */
    setSize : function(w, h){
        // support for standard size objects
        if(typeof w == 'object' && w!=null){
            h = w.height;
            w = w.width;
        }
        // not rendered
        if(!this.boxReady){
            this.width = w;
            this.height = h;
            return this;
        }

        // prevent recalcs when not needed
        if(this.lastSize && this.lastSize.width == w && this.lastSize.height == h){
            return this;
        }
        this.lastSize = {width: w, height: h};
        var adj = this.adjustSize(w, h);
        var aw = adj.width, ah = adj.height;
        if(aw !== undefined || ah !== undefined){ // this code is nasty but performs better with floaters
            var rz = this.getResizeEl();
            if(!this.deferHeight && aw !== undefined && ah !== undefined){
                rz.setSize(aw, ah);
            }else if(!this.deferHeight && ah !== undefined){
                rz.setHeight(ah);
            }else if(aw !== undefined){
                rz.setWidth(aw);
            }
            this.onResize(aw, ah, w, h);
            this.fireEvent('resize', this, aw, ah, w, h);
        }
        return this;
    },

    /**
     * 设置组件的宽度，将会触发resize事件。
     * @param {Number} width 要设置的新的宽度
     * @return {L5.BoxComponent} 返回组件本身
     */
    setWidth : function(width){
    	if(typeof width=="string" && width.indexOf("%")>0){//如果是百分比
    		this.oldWidth = width;
    		this.onWinResize();
    		return this;
    	} else{
    		//其实最终还是调用setSize方法
    		return this.setSize(width);
    	}
    },

    /**
     * 设置组件的高度，将会触发resize事件。
     * @param {Number} height 要设置的新的高度
     * @return {L5.BoxComponent} 返回组件本身
     */
    setHeight : function(height){
    	if(typeof height =="string" && height.indexOf("%")>0){//如果是百分比
    		this.oldHeight = height;
    		this.onWinResize();
    		return this;
    	} else{
    		return this.setSize(undefined, height);
    	}
    },

    /**
     * 获取组件当前的尺寸大小
     * @return {Object} 返回一个包含宽度和高度的对象 {width: (element width), height: (element height)}
     */
    getSize : function(){
        return this.el.getSize();
    },

    /**
     * 获取组件当前所在的XY坐标
     * @param {Boolean} local (可选) 如果是true返回元素相对坐标，否则返回元素在页面的绝对坐标，默认false
     * @return {Array} 返回元素的坐标
     */
    getPosition : function(local){
        if(local === true){
            return [this.el.getLeft(true), this.el.getTop(true)];
        }
        return this.xy || this.el.getXY();
    },

    /**
     * 获取组件DOM的基本盒装信息，包括尺寸和XY坐标
     * @param {Boolean} local (可选) 如果是true返回元素相对坐标，否则返回元素在页面的绝对坐标，默认false
     * @return {Object} 返回一个对象，包含了组件width，height，x，y
     */
    getBox : function(local){
        var s = this.el.getSize();
        if(local === true){
            s.x = this.el.getLeft(true);
            s.y = this.el.getTop(true);
        }else{
            var xy = this.xy || this.el.getXY();
            s.x = xy[0];
            s.y = xy[1];
        }
        return s;
    },

    /**
     * 设置组件的大小和位置（盒子信息）
     * @param {Object} 一个对象，包含了组件width，height，x，y
     * @return {L5.BoxComponent} 返回组件本身
     */
    updateBox : function(box){
        this.setSize(box.width, box.height);
        this.setPagePosition(box.x, box.y);
        return this;
    },

    /**
     * @ignore
     * @protected
     */
    getResizeEl : function(){
        return this.resizeEl || this.el;
    },

    /**
     * @ignore
     * @protected
     */
    getPositionEl : function(){
        return this.positionEl || this.el;
    },

    /**
     * 设置组件的位置，是相对位置，如果想要设置组件在页面上的绝对位置请使用{@link #setPagePosition}.
     * 该方法触发move事件
     * @param {Number} left 组件新的left
     * @param {Number} top 组件的top
     * @return {L5.BoxComponent} 返回组件本身
     */
    setPosition : function(x, y){
        if(x && typeof x[1] == 'number'){
            y = x[1];
            x = x[0];
        }
        this.x = x;
        this.y = y;
        if(!this.boxReady){
            return this;
        }
        var adj = this.adjustPosition(x, y);
        var ax = adj.x, ay = adj.y;

        var el = this.getPositionEl();
        if(ax !== undefined || ay !== undefined){
            if(ax !== undefined && ay !== undefined){
                el.setLeftTop(ax, ay);
            }else if(ax !== undefined){
                el.setLeft(ax);
            }else if(ay !== undefined){
                el.setTop(ay);
            }
            this.onPosition(ax, ay);
            this.fireEvent('move', this, ax, ay);
        }
        return this;
    },

    /**
     * 设置组件的位置，是在页面的位置，如果想要设置组件相对的left和top请使用{@link #setPosition}.
     * 该方法触发move事件
     * @param {Number} x 组件在页面上的x坐标
     * @param {Number} y 组件在页面上的y坐标
     * @return {L5.BoxComponent} 返回组件本身
     */
    setPagePosition : function(x, y){
        if(x && typeof x[1] == 'number'){
            y = x[1];
            x = x[0];
        }
        this.pageX = x;
        this.pageY = y;
        if(!this.boxReady){
            return;
        }
        if(x === undefined || y === undefined){ // cannot translate undefined points
            return;
        }
        var p = this.el.translatePoints(x, y);
        this.setPosition(p.left, p.top);
        return this;
    },

    /**
     * @ignore
     * @private
     * 主要是为属性resizeEl和positionEl赋值
     * @param {L5.Component} ct 父组件
     * @param {Object} position 组件渲染的位置
     */
    onRender : function(ct, position){
        L5.BoxComponent.superclass.onRender.call(this, ct, position);
        if(this.resizeEl){
            this.resizeEl = L5.get(this.resizeEl);
        }
        if(this.positionEl){
            this.positionEl = L5.get(this.positionEl);
        }
    },
    /**
     * @private
     * 当组件监听到窗口大小改变的时候触发，也可以手动调用，然后重新根据父组件大小设置自身大小
     */
    onWinResize:function(w,h){
    	if(!this.el)return;
    	 //重新计算组件高度
    	var height;
    	var width;
		 if((L5.type(this.oldHeight)=="string")&&(this.oldHeight.indexOf("%")>0)){
			if(this.ownerCt&&this.ownerCt.oldHeight&&this.oldHeight != "100%"){
				height=this.ownerCt.getSize().height;
			}else{
				height=L5.getBody().getHeight()-this.el.getOffsetsTo(L5.getBody())[1];//
			}
	     	var tempHeight=this.oldHeight.substring(0,(this.oldHeight.indexOf("%")))/100;
	     	height=height*tempHeight-2;
	     }
	     //重新计算组件宽度         
	     if((L5.type(this.oldWidth)=="string")&&(this.oldWidth.indexOf("%")>0)){
			if(this.ownerCt&&this.ownerCt.oldWidth){
				width=this.ownerCt.getSize().width;
			}else{
				width=L5.getBody().getWidth()-this.el.getOffsetsTo(L5.getBody())[0];
			}
	      	var tempWidth=this.oldWidth.substring(0,(this.oldWidth.indexOf("%")))/100;          	
	      	width=width*tempWidth-2;
	     }
	     this.setSize(width?width:this.width,height?height:this.height);
    },
    /**
     * @private
     * 设置组件的大小位置，以及为组件增加监听器（当窗口大小改变调用onWinResize），窗口大小改变的事件只由最外层的父容器组件监听，
     * 当父容器组件监听后改变自身大小的时候，会通过布局（调用子组件的onWinResize）改变子组件的大小。
     */
    afterRender : function(){
        L5.BoxComponent.superclass.afterRender.call(this);
        this.boxReady = true;
        var height;
    	var width;
    	if(!this.ownerCt){
    		this.onWinResize();        
    	}
        if(this.x || this.y){
            this.setPosition(this.x, this.y);
        }else if(this.pageX || this.pageY){
            this.setPagePosition(this.pageX, this.pageY);
        }
        L5.EventManager.removeResizeListener(this.onWinResize, this);//清除事件
        if(!this.ownerCt)
        	L5.EventManager.onWindowResize(this.onWinResize, this);//页面扩大缩小时处理高度自适应
    },

    /**
     * @private
     * 强制组件根据DOM的高度和宽度重新设置自身的大小
     * @return {L5.BoxComponent} 返回组件自身
     */
    syncSize : function(){
        delete this.lastSize;
        this.setSize(this.autoWidth ? undefined : this.el.getWidth(), this.autoHeight ? undefined : this.el.getHeight());
        return this;
    },

    /**
     * @ignore
     * @protected
     * 当组件的大小改变的时候调用该空方法，子类需要重写该方法，将子类自身的逻辑增加进去
     * @param {L5.Component} this
     * @param {Number} adjWidth 新的宽度
     * @param {Number} adjHeight 新的高度
     * @param {Number} rawWidth 改变之前的宽度
     * @param {Number} rawHeight 改变之前的高度
     */
    onResize : function(adjWidth, adjHeight, rawWidth, rawHeight){
    	 	
    },

    /**
     * @ignore
     * @protected
     * 当组件被移动的时候调用该空方法，子类需要重写该方法，将子类自身的逻辑增加进去
     * @param {L5.Component} this
     * @param {Number} x 新的x坐标
     * @param {Number} y 新的y坐标
     */
    onPosition : function(x, y){

    },

    /**
     * @private
     * 将参数宽度和高度合成一个object对象，同时也考虑到宽度或高度是auto的情况处理
     * @return {Object} 返回的object包含width和height属性，分别记录了组件的宽度和高度
     */
    adjustSize : function(w, h){
        if(this.autoWidth){
            w = 'auto';
        }
        if(this.autoHeight){
            h = 'auto';
        }
        return {width : w, height: h};
    },

    /**
     * @private
     * 将参数x坐标和y坐标合成一个object对象
     * @return {Object} 返回的object包含x和y属性，分别记录了组件的x坐标和y坐标
     */
    adjustPosition : function(x, y){
        return {x : x, y: y};
    }
});
L5.reg('box', L5.BoxComponent);