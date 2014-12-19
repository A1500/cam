(function(){
	//先照着日期绑定做，以后再考虑将日期时间绑定与日期绑定处理成继承形式
	//不支持秒
	/**
	 * 在制定的输入域上显示日期时间控件
	 */
	var showDatetimeMenu = function(target){
		if((typeof target)=='string'){
			target = document.getElementById(target);
		}
		var datetimemenu = getDatetimeMenu(target);
		if(!datetimemenu){
			datetimemenu = createDatetimeMenu(target);
			cacheDatetimeMenu(target,datetimemenu);
		}
		/**
		 * 缓存触发对象并注册事件
		 */
		datetimemenu.triggerTarget = target;
		datetimemenu.on(L5.apply({}, datetimemenuListeners));
		/**
		 * 显示日期时间菜单,需要处理日期时间值
		 */
		var datetime = false;
		if(target.value&&target.value!=""){
			var datetimevalue = target.value;
			var format = target.format;
			datetime = parseDatetime(datetimevalue,format);
		}
		datetimemenu.picker.setValue(datetime||new Date());
		datetimemenu.show(target, "tl-bl?");//在目标对象的左下角处显示日期菜单
	};
	/**
	 * 触发日期时间控件的显示
	 */
	var triggerShowDatetimeMenu = function(evt){
		var target = evt.srcElement||evt.target;
		showDatetimeMenu(target);
	};
	/**
	 * 触发清除添加的日期
	 */
	var clearElValue=function (clearEvt){
		var target = clearEvt.srcElement||clearEvt.target;
		if((typeof target)=='string'){
			target = document.getElementById(target);
		}
		var datetimemenu = getDatetimeMenu(target);
		if(datetimemenu)
			datetimemenu.hide();
		target.value="";
	};
	/**
	 * 创建日期时间控件
	 * @param {Object} target
	 */
	var createDatetimeMenu = function(renderEl){
		var datetimeId = renderEl.datetimeId || renderEl.getAttribute("datetimeId");
		if(datetimeId==null){
			renderEl.setAttribute("datetimeId",L5.id());
			datetimeId=renderEl.datetimeId=(datetimeId==null?L5.id():datetimeId)
		}
		var menu = new L5.menu.DatetimeMenu({id : datetimeId});
		
		var prop = {};
		prop.format = renderEl.format || renderEl.getAttribute("format") || "Ymd";
		prop.value = renderEl.showToday || renderEl.getAttribute("showToday") || true;
		L5.apply(menu.picker,prop);
		
		return menu;
	};
	/**
	 * 缓存日期时间控件
	 * @param {Object} target
	 * @param {Object} datetimemenu
	 */
	var cacheDatetimeMenu = function(target,datetimemenu){
		target.dateId = datetimemenu.id;
		target.format = datetimemenu.picker.format;
		target.showToday = datetimemenu.picker.showToday;
	};
	var getDatetimeMenu = function(renderEl){
		var menu = false;
		if(renderEl.datetimeId){//读取缓存中的日期时间id信息
			menu = L5.menu.MenuMgr.get(renderEl.datetimeId);
		}
		return menu;
	};
	/**
	 * ie下dom直接用dom.focus.defer(10,dom)存在问题,所谓改为targetfocus中转
	 */
	var targetfocus = function(){
		try{
			this.dom.focus();
		}catch(e){
		}
	};
	/**
	 * 监听datetimemenu.picker的日期时间选中和日期时间隐藏事件,用来处理日期时间值
	 */
	var datetimemenuListeners = {
		/**
		 * 日期时间选中事件,有datetimemenu.picker触发
		 * @param {Object} m
		 * @param {Object} d
		 */
	    select: function(m,d){
			var target = m.parentMenu.triggerTarget;
			var format = target.format;
			//触发用户的日期选择事件
			var datesellis = target.datetimeselect;
			if(!datesellis){
				var datesel = target.getAttribute("ondatetimeselect");
				if(!datesel){
					datesellis = target.datetimeselect = L5.emptyFn;
				} else {
					if(typeof(datesel) =='string'){
						datesellis = target.datetimeselect = window[datesel];
					}
				}
			}
			if(datesellis(target,d,format)!==false){
				var datevalue = d.dateFormat(format);
				target.value = datevalue;
				L5.fireEvent(target,"blur");
			};
	    },
		/**
		 * 隐藏日期时间菜单事件
		 * @param {Object} datetimemenu
		 */
	    hide : function(datetimemenu){
			var target = datetimemenu.triggerTarget;
			datetimemenu.triggerTarget = false;
		    targetfocus.defer(10,target);
	        datetimemenu.un("select", datetimemenuListeners.select);
	        datetimemenu.un("hide", datetimemenuListeners.hide);
	    }
	};
	/**
	 * 支持的日期格式
	 */
	var altFormatsArray = [
		"m/d/Y","m/d/Y h","m/d/Y h:i","m/d/Y h:i:s",
		"n/j/Y","n/j/Y h","n/j/Y h:i","n/j/Y h:i:s",
		"n/j/y","n/j/y h","n/j/y h:i","n/j/y h:i:s",
		"m/j/y","m/j/y h","m/j/y h:i","m/j/y h:i:s",
		"n/d/y","n/d/y h","n/d/y h:i","n/d/y h:i:s",
		"m/j/Y","m/j/Y h","m/j/Y h:i","m/j/Y h:i:s",
		"n/d/Y","n/d/Y h","n/d/Y h:i","n/d/Y h:i:s",
		"m-d-y","m-d-y h","m-d-y h:i","m-d-y h:i:s",
		"m-d-Y","m-d-Y h","m-d-Y h:i","m-d-Y h:i:s",
		"m/d","m/d h","m/d h:i","m/d h:i:s",
		"m-d","m-d h","m-d h:i","m-d h:i:s",
		"md","md h","md h:i","md h:i:s",
		"mdy","mdy h","mdy h:i","mdy h:i:s",
		"mdY","mdY h","mdY h:i","mdY h:i:s",
		"d","d h","d h:i","d h:i:s",
		"Y-m-d","Y-m-d h","Y-m-d h:i","Y-m-d h:i:s"
	];
	/**
	 * 解析日期
	 * @param {Object} value
	 * @param {Object} format
	 */
	var parseDatetime = function(value,format){
	    if(!value || L5.isDate(value)){
	        return value;
	    }
	    var v = Date.parseDate(value, format);
	    if(!v ){
	        for(var i = 0, len = altFormatsArray.length; i < len && !v; i++){
	            v = Date.parseDate(value,altFormatsArray[i]);
	        }
	    }
	    return v;
	};
	/**
	 * 注册监听事件
	 * @param {Object} evt
	 * @param {Object} target
	 * @param {Object} func
	 */
	var addEventListener = function(evt,target,func){
		if (window.addEventListener) {
			target.addEventListener(evt,func,false);
		} else if (window.attachEvent) {
			target.attachEvent("on"+evt,func);
		} else {
			alert("Not support this explorer");
			return ;
		}
	};
	
	/**
	 * ctrl+字符 实现快捷键
	 * 例如
	 * crtl+/
	 * crtl+'left'
	 * @param {Object} hotkeys
	 * @param {Object} target
	 */
	var addHotKey = function(hotKey,target){
		target.hotKey = hotKey;
		addEventListener("keydown",target,hotKeyListener);
	};
	/**
	 * 快捷键监听器,快捷键形式为,比如:ctrl+/
	 * 第一个键必须是ctrl,第二个键从目标对象的hotKey中获取
	 * @param {Object} evt
	 */
	var hotKeyListener = function(evt){
		evt = evt || window.event;
		if(evt.ctrlKey){
			var keycode =evt.keyCode || evt.which;
			var ch = _keycodeMap[keycode];
			var target = evt.srcElement||evt.target;
			if(ch==target.hotKey){
				showDatetimeMenu(target);
				preventDefault(evt);//阻止默认事件处理,防止,比如a是快捷键,输入ctrl+a触发快捷键,此时a输入到input中
			}
		}
	};
	/**
	 * 阻止浏览器默认的事件处理
	 * @param {Object} evt
	 */
	var preventDefault = function(evt){
		if(window.event){
			window.event.returnValue = false;
			return;
		}else if(evt.preventDefault){
			evt.preventDefault();
		}
	};
	var k = 'Loush'+'angD'+'ate'+'ti'+'mebi'+'nd';
	var kImg = 'Loush'+'angD'+'ate'+'ti'+'mebi'+'nd'+"Img";
	/**
	 * 将日期时间组件绑定到某一个输入域上
	 * @param {Object} renderel
	 * @param {Object} evt
	 */
	window[k] = function(renderEl,evt,clearEvt){
		if((typeof renderEl) == 'string'){
			renderEl = document.getElementById(renderEl);
		}
		if(evt){
			addEventListener(evt,renderEl,triggerShowDatetimeMenu);
		}
		if(clearEvt){
			if(clearEvt!='false'&&clearEvt!=false){
				if(clearEvt=='true'||clearEvt==true)
					clearEvt='dblclick';
				addEventListener(clearEvt,renderEl,clearElValue);
			}
		}else if(clearEvt==false||clearEvt=='false'){
		}else{
			clearEvt='dblclick';
			addEventListener(clearEvt,renderEl,clearElValue);
		}
		var hotKey = renderEl.getAttribute('hotKey');
		if(hotKey){
			addHotKey(hotKey,renderEl);
		}
	}
	/**
	 * 暴露给控件使用,形如<input onclick="t(this)">
	 */
	var t = "Lous"+"han"+"gDa"+"te"+'ti'+'me';
	window[t]=function (renderEl,clearEvt){
		if((typeof renderEl) == 'string'){
			renderEl = document.getElementById(renderEl);
		}
		showDatetimeMenu(renderEl);
		if(clearEvt){
			if(clearEvt!='false'&&clearEvt!=false){
				if(clearEvt=='true'||clearEvt==true)
					clearEvt='dblclick';
				addEventListener(clearEvt,renderEl,clearElValue);
			}
		}else if(clearEvt==false||clearEvt=='false'){
		}else{
			clearEvt='dblclick';
			addEventListener(clearEvt,renderEl,clearElValue);
		}
	}
	/**
	 * 暴露给控件使用,该绑定方式将在input后面新增一个图片，然后将弹出控件事件绑定给图片，回填value给input
	 */
	window[kImg] = function(renderEl,evt,clearEvt){
		if((typeof renderEl) == 'string'){
			renderEl = document.getElementById(renderEl);
		}
		//增加一个图片按钮
		var img = document.createElement("img");
		img.src = L5.webPath+"/skins/images/default/button/btn-date.gif";
		img.style.cursor="pointer";
		img.style.backgroundAttachment="fixed";
		renderEl.parentNode.insertBefore(img,renderEl.nextSibling);
	
		if(evt){
			//将弹出的事件绑定给img，但是将显示绑定给renderEl
			addEventListener(evt,img,function(){
					showDatetimeMenu(renderEl);
				}
			);
		}
		if(clearEvt){
			if(clearEvt!='false'&&clearEvt!=false){
				if(clearEvt=='true'||clearEvt==true)
					clearEvt='dblclick';
				addEventListener(clearEvt,renderEl,clearElValue);
			}
		}else if(clearEvt==false||clearEvt=='false'){
		}else{
			clearEvt='dblclick';
			addEventListener(clearEvt,renderEl,clearElValue);
		}
		var hotKey = renderEl.getAttribute('hotKey');
		if(hotKey){
			addHotKey(hotKey,renderEl);
		}
	}
})()
