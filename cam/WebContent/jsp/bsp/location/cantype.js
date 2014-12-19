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
		cmd.execute('referencedCantType');
		
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
		msg = cantype_ds.isValidate();
		
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
	 		ids[i] = selected[i].get('cantType');
	 		page.nameMap[ids[i]] = selected[i].get('typeName');
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
	cantype_ds.load();
	L5.QuickTips.init();
}
/**
 * 增加国家信息
 */
function add_cantype_info(){
	cantype_ds.newRecord({inuse:'1'});
}
/**
 * 删除国家信息
 */
function remove_cantype_info() {
	var selected = page.selectedRecordId('cantype_panel',false);
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
				var cmd = new L5.Command('org.loushang.bsp.ext.location.cmd.CantTypeCmd');
				cmd.setParameter('ids',selected.ids);
				cmd.execute('removeCantType');
				if(cmd.error){
					L5.MessageBox.alert(res.prompts,cmd.error);
					return ;
				}
			}
									
			leng  = selected.allRcd.length;
			for(var i=0; i<leng; i++) {
				cantype_ds.remove(selected.allRcd[i]);
			}
			
			var rcds = cantype_ds.getAllChangedRecords();
			//除了删除的的可能还有其它记录，所以不能都保存
			if(rcds.length === leng) {
				cantype_ds.commitChanges();	
			}
			
			L5.MessageBox.alert(res.prompts,res.removeOk);
	}});
}
function reset_cantype_info(){
	cantype_ds.rejectChanges();
}
function save_cantype_info(){
	var rcds = page.changedRecord(cantype_ds);
	var msg = page.checker.save(rcds);
	
	if(msg !== null){
		L5.MessageBox.alert(res.prompts,msg);
		return ;
	}
	
	var cmd = new L5.Command('org.loushang.bsp.ext.location.cmd.CantTypeCmd');
	cmd.setParameter('rcds',rcds);
	cmd.execute('saveCantType');
	if(cmd.error){
		L5.MessageBox.alert(res.prompts,cmd.error);
		return;
	}
	L5.MessageBox.alert(res.prompts,res.saveOK);
	cantype_ds.commitChanges();
}