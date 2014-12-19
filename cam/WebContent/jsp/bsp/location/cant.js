var page;
if(!page) {
	page = {
		cantCmd:'org.loushang.bsp.ext.location.cmd.CantCmd',
		wpCmd:	'org.loushang.bsp.ext.location.cmd.WorkplaceCmd'};
};
//map:{cantTypecode:cantTypeName}
page.cantype={};
//修改之前的检查记录的合法性
page.checker = {
	remove1 : function(ids) {

		var referenced;

		if(ids === null) {
			return null;
		}

		var cmd = new L5.Command(page.wpCmd);
		cmd.setParameter('ids',ids);
		cmd.execute('referencedCant');

		referenced = cmd.getReturn('errI');
		if(referenced === undefined)  return null;
		referenced = page.str2array(referenced);
		return page.id2name(referenced);

	},
	remove2 : function( ids) {
		var referenced;
		if( ids === null) return null;
		cmd = new L5.Command(page.cantCmd);
		cmd.setParameter('ids',ids);
		cmd.execute('referencedSuperCode');
		referenced = cmd.getReturn('errI');

		if(referenced === undefined)  return null;
		referenced = page.str2array(referenced);
		return page.id2name(referenced);
	},
	save : function(rcds) {
		var msg;
		if(rcds==null) {
			return res.nochange;
		}
		msg = cant_ds.isValidate();
		if(msg === true) {
			msg = null;
		}

		return msg;
	}
};
// panel：页面panel id
	// withNew:是否包含新增尚未保存的记录id
	//返回页面上被选择的记录id
page.selectedRecordId = function(panel,withNew){

		var selected=L5.getCmp(panel).getSelectionModel()
					.getSelections();
		var buck ;//存储返回值

		var leng = selected.length;
		if(leng < 1){
	 		return null;
	 	}
	 	buck = {allRcd:selected};

	 	//默认是带新增加的记录的
	 	if(withNew === undefined) {
			withNew = true;
		}

	 	var ids = [];
	 	for(var i=0; i<leng; i++){
	 		if( !withNew ){
	 			if(selected[i].state === 1) {
	 				continue;
	 			}
	 		}
	 		ids[i] = selected[i].get('cantCode');
	 		page.nameMap[ids[i]] = selected[i].get('cantName');
	 	}

	 	if(ids.length < 1){
	 		buck.ids = null;
	 	} else{
	 		buck.ids = ids;
	 	}

	 	return buck;
};
page.changedRecord = function(dst) {
		var rcds = dst.getAllChangedRecords();
		if(rcds.length < 1){
			return null;
		}
		var rcds_without_removed = [];
		var leng = rcds.length;
		for(var i=0, j=0; i<leng; i++){
			if(rcds[i].state !== 2){
				rcds_without_removed[j++] = rcds[i];
			}
		}
		return rcds_without_removed;
};
//把一个 xx,yy,zz 形状的字符串翻译成为数组
page.str2array=function(str){
	return str.split(",");
};
page.nameMap={};
//根据id找到对应的name
page.id2name = function(ids) {
	var leng = ids.length;
	var names = [ ];

	for(var i=0; i<leng; i++){
		names[i] = page.nameMap[ ids[i] ];
	}

	return names;
};

page.position =  function() {
	var code = [];
	var name_  = [] ;

	return {
		//当前行政区划代码
		currentCode : function() {
			if(code.length < 1) {
				return null;
			}
			return code[code.length - 1];
		},
		//当前行政区划名称
		currentName : function() {
			if(name_.length < 1) {
				return null;
			}
			return name_[name_.length - 1];
		},
		currentCountry : function() {
			if (code.length < 1) {
				return null;
			}
			return {code:code[0], name_:name_[0]};
		},

		//进入指定的下一级
		enter : function(thiscode,thisname) {
			code.push(thiscode);
			name_.push(thisname);

		},
		shrink : function(index) {
			code.length = index;
			name_.length = index;
		},
		clear : function() {
			code.length = 0;
			name_.length = 0;
		},
		levels : function() {
			return code.length ;
		},
		printLink : function() {
			var link =res.position ;
			var a0 = '<a href="javascript:page.gotoCant(\'';
			var a1 ='\',\'';
			var a2 = '\')">';
			var a3 = '</a>';
			var __ = '>>';

			var leng = code.length;
			if(leng < 1) {
			    return ;
			}
			for(var i=0; i<leng-1; i++) {
			//<a href="javascript:page.gotoCant('$code[i]','$name_[i]','i')">$name_[i]</a>
			    link += a0 + code[i] + a1 + name_[i] +
			    	a1 + i + a2 +  name_[i] + a3 + __;
			}
			link += name_[leng -1]===undefined?"":name_[leng-1];

			document.getElementById('location_link').innerHTML = link;
		}
	}
};
//根据不同的super_code重新查询
//在重新查询的过程中需要处理：
// [当前查询结果不是省级行政区划时，隐藏国家下拉框;
//  重新写头部的当前位置链接]
page.gotoCant = function(code,name_ ,index) {
	index = index - 0 ;
	var visible = 'none';
	if(index === 0) {
		visible = "";
	}

	//click link on top
	if( !isNaN(index) ) {
		page.position.shrink(index);
	}
	page.position.enter(code,name_);
	page.position.printLink();

	cant_ds.setParameter('super_code@=',code);
	cant_ds.load();

	document.getElementById('country_label').style.display = visible;
	document.getElementById('country').style.display = visible;
};

function init() {

	page.position = page.position();//bad thing~~

		var comb=L5.getCmp('country');
		comb.on("select",function(comb,rcd,index) {
			var oldCountry = page.position.currentCountry();
			var newCountryCode =  rcd.get('countryCode');
			var newCountryName =  rcd.get('countryName');

			if(oldCountry !== null && oldCountry.code === newCountryCode) {
				return;
			}

			page.position.clear();
			page.position.enter(newCountryCode,newCountryName);
			page.position.printLink();

			reloadCant( newCountryCode,newCountryName );
		});
		var leng = country_ds.getCount();
		if(leng < 1){
			L5.MessageBox.confirm(res.prompts, 'no country! goto define one',
				function(sta) {
					if(sta ==='yes') {
						L5.forward('./jsp/7/country.jsp');
					}
					return;
				});
		}
		var countryCode;
		var countryName;
		for(var i=0; i<leng; i++) {
			countryCode = country_ds.getAt(i).get('countryCode');
			if(countryCode === 'china' ||
					countryCode ==='CHINA' ||
						countryCode === 'CN') {
				countryName = country_ds.getAt(i).get('countryName');
				comb.setValue(countryCode);
				break;
			}
		}

		if(countryCode === undefined) {
			return;
		}

		cant_type_ds.on('load',  function() {

			cant_ds.setParameter('super_code@=', countryCode);
			cant_ds.load();
			var leng = cant_type_ds.getCount();
			for(var i=0; i<leng; i++) {
			 	var rcd = cant_type_ds.getAt(i);
			 	page.cantype[rcd.get('cantType')] = rcd.get('typeName');
			}
		});
		cant_type_ds.load();

		page.position.enter(countryCode,countryName);
		page.position.printLink();

	L5.QuickTips.init();
}

/**
 * 增加行政区划信息
 */
function add_cant_info(){
	var country = page.position.currentCountry();
	var superCode = page.position.currentCode();
	var level = page.position.levels();
	//增加时默认行政区划类型
	var defauType = "";
	if(level=== 1){
		defauType = '1';
	} else if(level === 2) {
		defauType = '2';
	} else if(level === 3) {
		defauType ='3';
	}
	cant_ds.newRecord({ inuse:'1',
						countryCode:country.code,
						superCode:superCode,
						cantType:defauType
					  });
}
/**
 * 删除行政区划信息
 */
function remove_cant_info() {
	var selected = page.selectedRecordId('cant_panel',false);
	if(selected === null){
		L5.MessageBox.alert(res.prompts,res.noselected);
		return ;
	}
	L5.MessageBox.confirm(res.prompts, res.askRemove,
		function(sta){
			if(sta ==='yes'){
			var leng;
			var msg = page.checker.remove1(selected.ids);
			if(msg !== null){
				L5.MessageBox.alert(res.prompts,msg+res.onusing);
				return ;
			}
			msg =  page.checker.remove2(selected.ids);
			if( msg != null ) {
				L5.MessageBox.alert(res.prompts,msg+res.hasSubCant);
				return;
			}
			if(selected.ids !== null){
				var cmd = new L5.Command(page.cantCmd);
				cmd.setParameter('ids',selected.ids);
				cmd.execute('removeCant');
				if(cmd.error){
					L5.MessageBox.alert(res.prompts,cmd.error);
					return ;
				}
			}
			leng  = selected.allRcd.length;
			for(var i=0; i<leng; i++) {
				cant_ds.remove(selected.allRcd[i]);
			}
			//var rcds = cant_ds.getAllChangedRecords();
			//除了删除的的可能还有其它记录，所以不能都保存
			//if(rcds.length === leng) {
				//cant_ds.commitChanges();
			//}
			L5.MessageBox.alert(res.prompts,res.removeOk);
	}});
}
function reset_cant_info(){
	cant_ds.rejectChanges();
}
function save_cant_info(){
	var rcds = page.changedRecord(cant_ds);
	var msg = page.checker.save(rcds);

	if(msg !== null){
		L5.MessageBox.alert(res.prompts,msg);
		return ;
	}

	var cmd = new L5.Command(page.cantCmd);
	cmd.setParameter('rcds',rcds);
	cmd.execute('saveCant');
	if(cmd.error){
		L5.MessageBox.alert(res.prompts,cmd.error);
		return;
	}
	L5.MessageBox.alert(res.prompts,res.saveOK);
	cant_ds.commitChanges();
}
// 修改"国家"下拉框的值重新加载行政区划
function reloadCant(code,name_) {

	page.position.clear();
	page.position.enter(code,name_);
	page.position.printLink();

	cant_ds.setParameter('super_code@=',code);
	cant_ds.load();

	document.getElementById('country_label').style.display = "";
	document.getElementById('country').style.display = "";
}
function query_name() {
	var name_ = document.getElementById('cant_name').value;
	var superCode = page.position.currentCode();
	cant_ds.setParameter('cant_name@like',name_);
	cant_ds.setParameter('super_code@=',superCode);
	cant_ds.load();
}

function reset(){
	document.getElementById('cant_name').value="";
	document.getElementById('country').value="";
}

function addLink(name_,id,rcd) {
	var a0 = '<a href="javascript:page.gotoCant(\'';
	var a1 = '\',\'';
	var a2 = '\')">';
	var a3 = '</a>';

	return a0 + rcd.get('cantCode') + a1 + name_ + a2 + name_ + a3;

}
//把行政区划类型[代码]展现为行政区划类型[名称]
function renderName(value) {
	var name = page.cantype[value];
	return (name === undefined)?value:name;
}
function isNew() {
	if( cant_ds.getCurrent().state === 1) 	return true;
	return false;

}