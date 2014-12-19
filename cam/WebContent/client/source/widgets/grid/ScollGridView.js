/**
 * 大数据量Grid使用的View视图，采用的方式是滚动条分页，当滚动条滚动的时候将主体清空，然后按照高度重新计算，需要渲染的条数。
 * 最后重新渲染一屏幕的数据。
 */
L5.grid.ScollGridView=L5.extend(L5.grid.GridView, {
	/**
	 * @private
	* 每行像素大小，会动态的创建一行然后计算高度。
	*/
	rangPX: 0,
	/**
	 * @private
	* 一屏幕可以渲染多少条数据，通过动态计算获取
	*/
	rowSize: 0,
	/**
	 * @prvate
	 * 当前最小序号
	 */
	lastScrollPos:0,
    /* -------------------------------- UI Specific ----------------------------- */

    /**
     * @prvate
     * 初始化模板
     */
    initTemplates : function(){
        var ts = this.templates || {};
        if(!ts.master){
            ts.master = new L5.Template(
                    '<div class="l-grid3" hidefocus="true">',
                        '<div class="l-grid3-viewport">',
                            '<div class="l-grid3-header"><div class="l-grid3-header-inner"><div class="l-grid3-header-offset">{header}</div></div><div class="l-clear"></div></div>',
                            '<div class="l-grid3-scroller" style="auto:scroll;position:absolute;"><div></div><a href="#" class="l-grid3-focus" tabIndex="-1"></a></div>',
                            '<div style="overflow:hidden;position:absolute;" class="l-grid3-body" >{body}</div>',
                            this.renderSum ? '{sum}' : '',
                        '</div>',
                        '<div class="l-grid3-resize-marker">&#160;</div>',
                        '<div class="l-grid3-resize-proxy">&#160;</div>',
                    "</div>"
                    );
        }//只保留应该保留的一部分模板。
        if(!ts.body){
        	ts.body = new L5.Template('<div class="l-grid3-header-offset">{rows}</div>');
        }
        this.templates=ts;
        //初始化完自己重载的，调用父类的，因为已经存在模板，故父类只会初始化未定义的。
        L5.grid.ScollGridView.superclass.initTemplates.apply(this, arguments);
    },
    /**
     * @private
     * 初始化Element对象
     */
    initElements : function(){
    	//先调用父类的，然后重新赋值。
    	L5.grid.ScollGridView.superclass.initElements.apply(this, arguments);
    	var E = L5.Element;
        if(this.renderSum){
			this.mainSum=new E(this.mainWrap.dom.childNodes[3]);//TODO 
			this.sumBody=new E(this.mainSum.dom.firstChild.firstChild.rows[0]);//TODO 
		}
        this.mainBody =new E(this.mainWrap.dom.childNodes[2]);
        this.focusEl = new E(this.scroller.dom.childNodes[0]);
        this.focusEl.swallowEvent("click", true);
    },

    /**
     * @private
     * 获取所有的行DOM数组
     * @return {Array} 返回所有行TR的DOM数组
     */
    getRows : function(){//重载
        return this.hasRows() ? this.mainBody.child('div:first-child').dom.childNodes : [];
    },
    /**
     * @private
     * 移除指定区间的行
     * @param {Number} firstRow 区间的起始索引
     * @param {Number} lastRow 区间的结束索引
     */
    removeRows : function(firstRow, lastRow){
        var bd = this.mainBody.child('div:first-child').dom;
        for(var rowIndex = firstRow; rowIndex <= lastRow; rowIndex++){
            L5.removeNode(bd.childNodes[firstRow]);
        }
        this.syncFocusEl(firstRow);
    },

    /**
     * @private
     * 滚动滚动条的时候同步移动表头，并且同步渲染一屏幕的数据
     */
    syncScroll : function(e){
	      this.syncHeaderScroll();//移动表头
		  this.syncRowsScroll();//重新渲染一屏幕的数据
	      var mb = this.scroller.dom;
	      this.grid.fireEvent("bodyscroll", mb.scrollLeft, mb.scrollTop);
    },
    /**
     * @private
     * 计算滚动条的位置，然后重新渲染一屏幕的数据
     * 滚动条和渲染数据的容器不是同一个div，这样保证滚动条移动但是渲染这数据的屏幕永远不会变动
     */
	syncRowsScroll : function(){
		 var scrtop=this.scroller.dom.scrollTop;
		 var startpos=Math.ceil(scrtop/this.rangPX);
		 if(startpos+this.rowSize==this.ds.getCount())
		     startpos+=1;
		 this.mainBody.child('div:first-child').dom.innerHTML = this.renderRows(startpos,startpos+this.rowSize-1);
		 this.lastScrollPos = startpos;//this.scroller.dom.scrollTop;
		 this.processRows(startpos, true);
	},
	/**
	 * @private
	 * 渲染行后，处理行的css样式，序序号列等等
	 */
	processRows : function(startRow, skipStripe){
        if(this.ds.getCount() < 1){
            return;
        }
        skipStripe = skipStripe || !this.grid.stripeRows;
        startRow = startRow || 0;
        var rows = this.getRows();
        var cls = ' l-grid3-row-alt ';
        if(this.grid.isEditor||this.grid.notSelectFirstRow){
        	rows[0].className += ' l-grid3-row-first ';
        }else{
        	this.grid.getSelectionModel().selectFirstRow();
        	rows[0].className += ' l-grid3-row-first l-grid3-row-selected';
        }
        rows[rows.length - 1].className += ' l-grid3-row-last';
        for(var i = 0; i <  rows.length; i++){
            var row = rows[i];
            row.rowIndex = startRow+i;
            var numbererCell=L5.fly(row).query("div.l-grid3-col-numberer",row);
            if(numbererCell[0]){//if we have rowNumbererCell is a DIV[0]
            	numbererCell[0].innerHTML=startRow+i+1;//reset the rowNumber
            }
            if(!skipStripe){
                var isAlt = ((startRow+i+1) % 2 == 0);
                var hasAlt = (' '+row.className + ' ').indexOf(cls) != -1;
                if(isAlt == hasAlt){
                    continue;
                }
                if(isAlt){
                    row.className += " l-grid3-row-alt";
                }else{
                    row.className = row.className.replace("l-grid3-row-alt", "");
                }
            }
        }
    },
    /**
     * @private
     * 当滚动条移动后同步表头的移动
     */
    syncHeaderScroll : function(){
        var mb = this.scroller.dom;
		this.mainBody.dom.scrollLeft = mb.scrollLeft;
		this.mainBody.dom.scrollLeft = mb.scrollLeft;
        this.innerHd.scrollLeft = mb.scrollLeft;
        this.innerHd.scrollLeft = mb.scrollLeft; // second time for IE (1/2 time first fails, other browsers ignore)
    },
    /**
     * @private
     * 在数据加载之前，先渲染一行的空白，然后计算高度赋值给rangPX，作为该屏幕渲染数据的时候默认一行的高度。
     */
	doRenderOneRow: function(){
	    var colCount=this.cm.getColumnCount();
		var ts = this.templates, ct = ts.cell, rt = ts.row, last = colCount-1;
		var tstyle = 'width:'+this.getTotalWidth()+';';
		var buf = [], c, p = {}, rp = {tstyle: tstyle},cb = [];
            var cs=this.getColumnData();
            for(var i = 0; i < colCount; i++){
                c = cs[i];
                p.id = c.id;
                p.css = i == 0 ? 'l-grid3-cell-first ' : (i == last ? 'l-grid3-cell-last ' : '');
                p.attr = p.cellAttr = "";
                p.value = "";
                p.style = c.style;
                if(p.value == undefined || p.value === "") p.value = "&#160;";
                cb[cb.length] = ct.apply(p);
            }
            var alt = [];
            rp.cols = colCount;
            rp.alt = alt.join(" ");
            rp.cells = cb.join("");
            buf[buf.length] =  rt.apply(rp);
		return buf.join("");
	},
    /**
     * @private
     * 计算一屏幕数据条数，设置主体部分的高度，滚动条部分的高度。等
     */
    afterRender: function(){
	    //alert('start-afterRender');
		
		this.mainBody.child('div:first-child').dom.innerHTML= this.doRenderOneRow();
		
		this.rangPX=this.mainBody.child('div:first-child').child('div:first-child').getHeight();
		//alert(this.rangPX+'px');
		this.rowSize=Math.ceil(this.mainBody.getHeight()/this.rangPX);
		this.scroller.child('div:first-child').setHeight(this.grid.dataset.getCount()*this.rangPX);
		//增加宽度计算
		var rangPY=this.mainBody.child('div:first-child').child('div:first-child').getWidth();
		this.scroller.child('div:first-child').setWidth(rangPY);
		
        this.mainBody.child('div:first-child').dom.innerHTML = this.renderRows(0,this.rowSize-1);
		this.lastScrollPos = 0;
		//this.mainBody.
        this.processRows(0, true);

        if(this.deferEmptyText !== true){
            this.applyEmptyText();
        }
		
		//alert('end-afterRender');
    },
    /**
     * 为各个小组件增加必要的响应事件
     */
    renderUI : function(){
        //alert('start-renderUI');
        var header = this.renderHeaders();
        var body = this.templates.body.apply({rows:''});


        var html = this.templates.master.apply({
            body: body,
            header: header
        });

        var g = this.grid;
        //alert(html);
        g.getGridEl().dom.innerHTML = html;

        this.initElements();

        // get mousedowns early
        L5.fly(this.innerHd).on("click", this.handleHdDown, this);
        this.mainHd.on("mouseover", this.handleHdOver, this);
        this.mainHd.on("mouseout", this.handleHdOut, this);
        this.mainHd.on("mousemove", this.handleHdMove, this);

        this.scroller.on('scroll', this.syncScroll,  this);
		this.mainBody.on('mousewheel', this.handleWheel,  this);
		
        if(g.enableColumnResize !== false){
            this.splitZone = new L5.grid.GridView.SplitDragZone(g, this.mainHd.dom);
        }
       
        if(g.enableColumnMove){
            this.columnDrag = new L5.grid.GridView.ColumnDragZone(g, this.innerHd);
            this.columnDrop = new L5.grid.HeaderDropZone(g, this.mainHd.dom);
        }
         

        if(g.trackMouseOver){
            this.mainBody.on("mouseover", this.onRowOver, this);
            this.mainBody.on("mouseout", this.onRowOut, this);
        }
		
        if(g.enableDragDrop || g.enableDrag){
            this.dragZone = new L5.grid.GridDragZone(g, {
                ddGroup : g.ddGroup || 'GridDD'
            });
        }
        this.updateHeaderSortState();
        //alert('end-renderUI');
    },
    // template functions for subclasses and plugins
    // these functions include precalculated values
    /**
     * @private
     * 设置主体部分的高度宽度等
     * 调用afterRender是后台加上去的，目的是确保主题高度设置对后，才计算rowSize，保证rowSize的正确，以及滚动条的正确
     */
    onLayout : function(vw, vh){
        // do nothing
		//alert(this.scroller.getLeft()+":"+this.scroller.getTop());
		//this.mainBody.setTop(this.scroller.getTop());
		this.mainBody.setHeight(this.scroller.getHeight()-this.scrollOffset+5); 
		this.mainBody.setWidth(this.scroller.getWidth()-this.scrollOffset);	
		this.afterRender()
		//this.mainBody.setTop(this.scroller.getTop());
		//alert(this.mainBody.getLeft()+":"+this.mainBody.getTop());
    },
    /* ----------------------------------- Core Specific -------------------------------------------*/
    /**
     * Focuses the specified row.
     * @param {Number} row The row index
     */
//    focusRow : function(row){
//        this.focusCell(row, 0, false); //now do nothing
//    },
//	syncFocusEl : function(row, col, hscroll){
//		var xy = row;
//		if(!L5.isArray(xy)){
//			row = Math.min(row, Math.max(0, this.getRows().length-1));
//        	xy = this.getResolvedXY(this.resolveCell(row, col, hscroll));
//		}
//        //this.focusEl.setXY(xy||this.scroller.getXY());
//    },
    /**
     * @private
     * 渲染主体
     */
    renderBody : function(){
        var markup = this.renderRows(0,this.rowSize-1);
        return this.templates.body.apply({rows: markup});
    },
    /**
     * @private
     * 当主体部分没数据的时候，emptyText配置信息显示到mainBody
     */
    applyEmptyText : function(){
        if(this.emptyText && !this.hasRows()){
            this.mainBody.child('div:first-child').update('<div class="l-grid-empty">' + this.emptyText + '</div>');
        }
    },
    /* --------------------------------- Model Events and Handlers --------------------------------*/
    /**
     * @private
     * 当列移动的时候触发。
     */
    onColumnMove : function(cm, oldIndex, newIndex){
        this.indexMap = null;
        var s = this.getScrollState();
        this.refresh(true);
        this.restoreScroll(s);
        this.afterMove(newIndex);
    },
    /* -------------------- UI Events and Handlers ------------------------------ */
    /**
     * @private
     * 当滚轮滚动的时候触发
     */
    handleWheel : function(e){
	   var delta=e.getWheelDelta()*this.rangPX;
	   if ( this.scrollTimeout )
			clearTimeout( this.scrollTimeout );
	   var scrtop=this.scroller.dom.scrollTop;
	   scrtop-=delta;
	   this.scroller.dom.scrollTop=scrtop;
       e.stopPropagation();
    },
    /**
     * @private
     * 获取指定行，只能是当前屏幕显示的
     */
    getRow : function(row){
        return this.getRows()[row-this.lastScrollPos];
    },
    /**
     * @private
     */
    hasRows : function(){
        var fc = this.mainBody.child('div:first-child').dom.firstChild;
        return fc && fc.className != 'l-grid-empty';
    },
    /**
     * @private
     * 让某单元格可见
     * @param {Number} row 行号
     * @param {Number} col 列号
     * @param {Boolean} hscroll 是否计算隐藏列
     */
    ensureVisible : function(row, col, hscroll){
        var resolved = this.resolveCell(row, col, hscroll);
		if(!resolved || !resolved.row){
			return;
		}

		var rowEl = resolved.row, cellEl = resolved.cell;

		var c = this.scroller.dom;

        var ctop = 0;
        var p = rowEl, stop = this.el.dom;
        while(p && p != stop){
            ctop += p.offsetTop;
            p = p.offsetParent;
        }
        ctop -= this.mainHd.dom.offsetHeight;

        var stop = parseInt(c.scrollTop, 10);
        var now = stop+ctop;
        var should=this.rangPX*row;
        /**
         * 暂时不支持selectrow跨页定位scrolltop
         * 也不支持checkbox多选，需要记住状态。
         */
//		if(ctop < stop){
//          c.scrollTop = ctop;
//        }else if(cbot > sbot){
//            c.scrollTop = cbot-ch;
//        }

        if(hscroll !== false){
            var cleft = parseInt(cellEl.offsetLeft, 10);
            var cright = cleft + cellEl.offsetWidth;

            var sleft = parseInt(c.scrollLeft, 10);
            var sright = sleft + c.clientWidth;
            if(cleft < sleft){
                c.scrollLeft = cleft;
            }else if(cright > sright){
                c.scrollLeft = cright-c.clientWidth;
            }
        }
        return this.getResolvedXY(resolved);
    }
});