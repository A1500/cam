var page;
if(!page){
	page = {
			cantCmd : 'org.loushang.bsp.ext.location.cmd.CantCmd'
	};
};
//修改之前的检查记录的合法性
page.checker={

	remove:function(ids) {
		var referenced;
		if(ids === null) {
			return null;
		}
		var cmd = new L5.Command(page.cantCmd);
		cmd.setParameter('ids',ids);
		cmd.execute('referencedCountry');
		referenced = cmd.getReturn('errI');
		if(referenced === undefined) {
			return null;
		}
		referenced = page.str2array(referenced);
		return page.id2name(referenced);
	},

	save:function(rcds){
		var msg;

		if(rcds === null) {
			return res.nochange;
		}
		msg = country_ds.isValidate();

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
	 		ids[i] = selected[i].get('countryCode');
	 		page.nameMap[ids[i]] = selected[i].get('countryName');
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
//把一个[xx,yy,zz]形状的字符串翻译成为数组
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
function init(){
	country_ds.load();
	L5.QuickTips.init();
}
/**
 * 增加国家信息
 */
function add_country_info(){
	country_ds.newRecord({inuse:'1'});
}
/**
 * 删除国家信息
 */
function remove_country_info() {
	var selected = page.selectedRecordId('country_panel',false);
	if(selected === null){
		L5.MessageBox.alert(res.prompts,res.noselected);
		return ;
	}

	L5.MessageBox.confirm(res.prompts, res.askRemove,
		function(sta){
			if(sta ==='yes'){
			var msg = page.checker.remove(selected.ids);
			var leng;

			if(msg !== null){
				L5.MessageBox.alert(res.prompts,msg+res.onusing);
				return ;
			}

			if(selected.ids !== null){
				var cmd = new L5.Command('org.loushang.bsp.ext.location.cmd.CountryCmd');
				cmd.setParameter('ids',selected.ids);
				cmd.execute('removeCountry');
				if(cmd.error){
					L5.MessageBox.alert(res.prompts,cmd.error);
					return ;
				}
			}

			leng  = selected.allRcd.length;
			for(var i=0; i<leng; i++) {
				country_ds.remove(selected.allRcd[i]);
			}

			//var rcds = country_ds.getAllChangedRecords();
			//除了删除的的可能还有其它记录，所以不能都保存
			//if(rcds.length === leng) {
			//	country_ds.commitChanges();
			//}

			L5.MessageBox.alert(res.prompts,res.removeOk);
	}});
}
function reset_country_info(){
	country_ds.rejectChanges();
}
function save_country_info(){
	var rcds = page.changedRecord(country_ds);
	var msg = page.checker.save(rcds);

	if(msg !== null){
		L5.MessageBox.alert(res.prompts,msg);
		return ;
	}
	var cmd = new L5.Command('org.loushang.bsp.ext.location.cmd.CountryCmd');
	cmd.setParameter('rcds',rcds);
	cmd.execute('saveCountry');
	if(!cmd.error){
		L5.MessageBox.alert(res.prompts,res.saveOK);
		country_ds.commitChanges();
	}else{
		L5.MessageBox.alert(res.prompts,cmd.error);
		return;
	}
}

//设置单元格的可编辑状态
function setEditable(){
	var ds =L5.DatasetMgr.lookup("country_ds");
	//var userId = ds.getCurrent().get("userId");
	//var typeId= ds.getCurrent().get("typeId");
	var state = ds.getCurrent().state;
	if(state==L5.model.Record.STATE_NEW)
	{
			return true;
	}
	else
		    return false;
}