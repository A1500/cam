(function(){
var createDateMenu = function(renderEl){
	var dateId = renderEl.dateId || renderEl.getAttribute("dateId");
	if(dateId==null){
		renderEl.setAttribute("dateId",L5.id());
		dateId=renderEl.dateId=(dateId==null?L5.id():dateId)
	}
	var menu = new L5.menu.DateMenu({id : dateId});
	
	var prop = {};
	prop.format = renderEl.format || renderEl.getAttribute("format") || "Ymd";
	prop.value = renderEl.showToday || renderEl.getAttribute("showToday") || true;
	L5.apply(menu.picker,prop);
	
	return menu;
};
/**
 * 获取日期菜单,配置项允许从dom域中获取
 * @param {Object} renderEl
 * @param {Object} config
 */
var getDateMenu = function(renderEl){
	var menu = false;
	if(renderEl.dateId){//读取缓存中的日期id信息
		menu = L5.menu.MenuMgr.get(renderEl.dateId);
	}
	return menu;
};
/**
 * 缓存日期菜单
 * @param {Object} target
 * @param {Object} datemenu
 */
var cacheDateMenu = function(target,datemenu){
	target.dateId = datemenu.id;
	target.format = datemenu.picker.format;
	target.showToday = datemenu.picker.showToday;
};
/**
 * 支持的日期格式
 */
var altFormatsArray = [
	"m/d/Y","n/j/Y","n/j/y",
	"m/j/y","n/d/y","m/j/Y",
	"n/d/Y","m-d-y","m-d-Y",
	"m/d","m-d","md","mdy",
	"mdY","d","Y-m-d"
];
/**
 * 解析日期
 * @param {Object} value
 * @param {Object} format
 */
var parseDate = function(value,format){
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
 * ie下dom直接用dom.focus.defer(10,dom)存在问题,所谓改为targetfocus中转
 */
var targetfocus = function(){
	try{
		this.dom.focus();
	}catch(e){
	}
};
/**
 * 监听datemenu.picker的日期选中和日期隐藏事件,用来处理日期值
 */
var datemenuListeners = {
	/**
	 * 日期选中事件,有datemenu.picker触发
	 * @param {Object} m
	 * @param {Object} d
	 */
    select: function(m,d){
		var target = m.parentMenu.triggerTarget;
		var format = target.format;
		//触发用户的日期选择事件
		var datesellis = target.dateselect;
		if(!datesellis){
			var datesel = target.getAttribute("ondateselect");
			if(!datesel){
				datesellis = target.dateselect = L5.emptyFn;
			} else {
				if(typeof(datesel) =='string'){
					datesellis = target.dateselect = window[datesel];
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
	 * 隐藏日期菜单事件
	 * @param {Object} datemenu
	 */
    hide : function(datemenu){
		var target = datemenu.triggerTarget;
		datemenu.triggerTarget = false;
		targetfocus.defer(10,target);
        datemenu.un("select", datemenuListeners.select);
        datemenu.un("hide", datemenuListeners.hide);
    }
};
/**
 * 在指定的目标处显示日期菜单,自动添加滚动条
 * @param {Object} target
 */
var showDateMenu = function(target){
	if((typeof target)=='string'){
		target = document.getElementById(target);
	}
	var datemenu = getDateMenu(target);
	if(!datemenu){
		datemenu = createDateMenu(target);
		cacheDateMenu(target,datemenu);
	}
	
	/**
	 * 缓存触发对象并注册事件
	 */
	datemenu.triggerTarget = target;
	datemenu.on(L5.apply({}, datemenuListeners));
	/**
	 * 显示日期菜单,需要处理日期值
	 */
	var date = false;
	if(target.value&&target.value!=""){
		var datevalue = target.value;
		var format = target.format;
		date = parseDate(datevalue,format);
	}
	datemenu.picker.setValue(date||new Date());
	datemenu.show(target, "tl-bl?");//在目标对象的左下角处显示日期菜单
};

/**
 * 触发日期菜单显示
 * @param {Object} evt
 */
var triggerShowDateMenu = function(evt){
	var target = evt.srcElement||evt.target;
	showDateMenu(target);
};
/**
 * 触发清除添加的日期
 */
var clearElValue=function (clearEvt){
	var target = clearEvt.srcElement||clearEvt.target;
	if((typeof target)=='string'){
		target = document.getElementById(target);
	}
	var datemenu = getDateMenu(target);
	if(datemenu)
		datemenu.hide();
	target.value="";
};

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
 * 组织浏览器默认的事件处理
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
			showDateMenu(target);
			preventDefault(evt);//阻止默认事件处理,防止,比如a是快捷键,输入ctrl+a触发快捷键,此时a输入到input中
		}
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
 * 提供一个临时性的日期解决方案,先用ext的日期,后期再替换成新开发的日期
 */
//var k = 'Loush'+'angD'+'atebi'+'nd';
var k = 'LoushangDatebind';
var kImg = 'LoushangDatebindImg';
/**
 * 将日期绑定到某个组件,会使用L5.form.DateField替换原来的组件
 * 用于手动调用
 * @param {Object} renderEl
 * @param {string} evt
 */
window[k] = function(renderEl,evt,clearEvt){
	if((typeof renderEl) == 'string'){
		renderEl = document.getElementById(renderEl);
	}
	if(evt){
		addEventListener(evt,renderEl,triggerShowDateMenu);
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
};
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
		addEventListener(evt,img,function(){
				showDateMenu(renderEl);
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
};
/**
 * 暴露给空间使用,可以直接写<input onclick="t(this)">
 */
//var t = "Lous"+"han"+"gDa"+"te";
var t = "LoushangDate";
window[t] = function (renderEl,clearEvt){
	if((typeof renderEl) == 'string'){
		renderEl = document.getElementById(renderEl);
	}
	showDateMenu(renderEl);
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


//日期查询选择器：
function showQueryDate(ele,format,img){
	if(format==undefined||format==""){
		format = "Y-m-d";
	}
	var tiem1html ='选择日期：<input type="text" size="10" id="$dateq1" onclick="LoushangDate(this)" format='+format+'>';
	if(img=="true"||img==true){
		tiem1html = '选择日期：<input type="text" size="10" id="$dateq1"  format='+format+'><img onclick=LoushangDate("$dateq1") src='+ L5.webPath+"/skins/images/default/button/btn-date.gif"+' style="cursor:pointer;" >';
	}
	var tiem2html ='从：<input type="text" id="$dateq2" onclick="LoushangDate(this)" format='+format+' size="9">&nbsp;&nbsp;&nbsp;到：<input type="text" id="$dateq3" onclick="LoushangDate(this)" format='+format+' size="9">';
	if(img=="true"||img==true){
		tiem2html = '从：<input type="text" id="$dateq2"  format='+format+' size="9"/><img onclick=LoushangDate("$dateq2") src='+ L5.webPath+"/skins/images/default/button/btn-date.gif"+' style="cursor:pointer;" >'+'&nbsp;&nbsp;&nbsp;到：<input type="text" id="$dateq3"  format='+format+' size="9"/><img onclick=LoushangDate("$dateq3") src='+ L5.webPath+"/skins/images/default/button/btn-date.gif"+' style="cursor:pointer;" >';
	}
	
	var win =L5.getCmp("queryDate~");
	if(win==null){
		win = new L5.Window({id:'queryDate~',title:"日期选择",width:350,height:200,autoScroll:false,closeAction:'close',
			tbar:['->',{iconCls : "yes",text:'确定',handler:queryOk},{iconCls : "delete",text:'关闭',handler:queryClose},{iconCls : "no",text:'清除',handler:queryClear}],
			items:[{
				xtype:'tabpanel',
				autoScroll:false,
				listeners:{'tabchange':tabAct},
				activeTab:0,autoWidth:true,autoHeight:true,id:'tabs',
				items:[
					{title:'具体日期',frame:true,height:200,html:tiem1html},
					{title:'按时间段',frame:true,height:200,html:tiem2html},
					{title:'按月份',frame:true,height:200,html:'请选中月份：<input type="text" id="$dateq4" value="2009" size="2" maxlength="4">年<select id="$dateq5"><option value="01">1月</option><option value="02">2月</option><option value="03">3月</option><option value="04">4月</option><option value="05">5月</option><option value="06">6月</option><option value="07">7月</option><option value="08">8月</option><option value="09">9月</option><option value="10">10月</option><option value="11">11月</option><option value="12">12月</option></select>'},
					{title:'按年份',frame:true,height:200,html:'请选择年份：<input type="text" value="2009" size="2" id="$dateq6" maxlength="4">'}
					]
				}
			]
		});
	}
	var el = L5.fly(ele);
	var xy = el.getXY();
	win.setPosition(xy[0],xy[1]+20);
	win.show(ele);
	
}
window['showQueryDate']=showQueryDate;
function tabAct(tabpanle,item){
	var now = new Date();
	var year = now.getFullYear();
	var month = now.getMonth()+1;
	if(month<10){
		month = '0'+month;
	}else{
		month = ''+month;
	}
	if(item.title=="按月份"){
		L5.getDom("$dateq4").value=year;
		L5.getDom("$dateq5").value=month;
	}else if(item.title=="按年份"){
		L5.getDom("$dateq6").value=year;
	}else if(item.title=="具体日期"){
		var format = document.getElementById("$dateq1").getAttribute("format");
		L5.getDom("$dateq1").value=now.dateFormat(format);
	}
}
function queryOk(){
	var win =L5.getCmp("queryDate~");
	var v = getV(win.getComponent(0));
	if(v!=null&&v!=""){
	win.animateTarget.dom.value=v;
	}else{
		return;
	}
	win.close();
}
function queryClear(){
	var win =L5.getCmp("queryDate~");
	win.animateTarget.dom.value="";
	win.close();
}
function queryClose(){
	var win =L5.getCmp("queryDate~");
	win.close();
}
function getV(cmp){
	var t = cmp.getActiveTab().title;
	if(t=="具体日期"){
		var v = L5.getDom("$dateq1").value;
		var format = document.getElementById("$dateq1").getAttribute("format");
		if(v==null||v==""){
			alert("请选择日期");
			return;
		}
		if(!L5.isDateTime.call(v,format)){
			alert("日期格式不正确,正确格式是:"+format);
			return;
		}
		return v;
	}else if(t=="按时间段"){
		var v1 = L5.getDom("$dateq2").value;
		var v2 = L5.getDom("$dateq3").value;
		if(v1==null||v1==""){
			alert("请输入开始日期");
			return;
		}
		var format2 = document.getElementById("$dateq2").getAttribute("format");
		if(!L5.isDateTime.call(v1,format2)){
			alert("开始日期格式不正确,正确格式是:"+format2);
			return;
		}
		if(v2==null||v2==""){
			alert("请输入结束日期");
			return;
		}
		var format3 = document.getElementById("$dateq3").getAttribute("format");
		if(!L5.isDateTime.call(v2,format3)){
			alert("结束日期格式不正确,正确格式是:"+format3);
			return;
		}
		if(v1>v2){alert("结束日期不能早于开始日期");return;}
		return v1+"~"+v2;
	}else if(t=="按月份"){
		var v1 = L5.getDom("$dateq4").value;
		var v2 = L5.getDom("$dateq5").value;
		if(/^[-\+]?\d+$/.test(v1)==false){
			alert("年份格式不正确")
			return ;
		}
		return v1+"-"+v2
	}else if(t=="按年份"){
		var v1 = L5.getDom("$dateq6").value;
		if(/^[-\+]?\d+$/.test(v1)==false){
			alert("年份格式不正确")
			return ;
		}
		return v1;
	}	
}
})();
