var page;
if(!page) {
	page = {
		cmd:'org.loushang.bsp.ext.location.cmd.WorkplaceCmd'};
};

//修改之前的检查记录的合法性
page.checker = {
	remove : function(ids) {
		
		var referenced;
		
		if(ids === null) {
			return null;
		}
		
		var cmd = new L5.Command(page.cmd);
		cmd.setParameter('ids',ids);
		cmd.execute('checkReferenced');
		
		referenced = cmd.getReturn('errI');
		if(referenced === undefined) {
			return null;
		} 
		
		referenced = page.str2array(referenced);
			
		return page.id2name(referenced);
		
	},
	
	save : function(rcds) {
		var msg;
		
		if(rcds === null) {
			return res.nochange;
		}
		msg = wp_ds.isValidate();
		
		if(msg === true) {
			msg = null;
		}
		
		return msg;
	}
};
// panel：页面panel id
	// withNew:是否包含新增尚未保存的记录id
	//返回页面上被选择的记录id
page.selectedRecordId = function(panel,withNew) {
		
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
	 		ids[i] = selected[i].get('workplaceId');
	 		page.nameMap[ids[i]] = selected[i].get('workplaceName');
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
	
	if(str === '[]'){
		return null;
	}
	
	var sub_str = str.substring(1,str.length-1);
	return sub_str.split(",");
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


function init() {
	var layout = L5.getCmp("cards").getLayout();
	layout.setActiveItem(0);
	//wp_ds.setParameter('@workplace_code=','(select workplace_code from pub_workplace )');
	wp_ds.load();
	
	
}

/**
 * 增加国家信息
 */
function add_wp_info(){
	var layout = L5.getCmp("cards").getLayout();
	layout.setActiveItem(1);
	wp_ds.newRecord();
}
/**
 * 删除国家信息
 */
function remove_wp_info() {
	var selected = page.selectedRecordId('wp_panel',false);
	if(selected === null){
		L5.MessageBox.alert(res.prompts,res.noselected);
		return ;		
	}
		
	L5.MessageBox.confirm(res.prompts, res.askRemove,
		function(sta){
			if(sta ==='yes'){
			var msg = page.checker.remove(selected.ids);
			var leng;
	
			if(msg !== null) {
				L5.MessageBox.alert(res.prompts,msg);
				return ;		
			}	
			
			if(selected.ids !== null) {
				var cmd = new L5.Command(page.cmd);
				cmd.setParameter('ids',selected.ids);
				cmd.execute('removeWorkplace');
				if(cmd.error) {
					L5.MessageBox.alert(res.prompts,cmd.error);
					return ;
				}
			}
									
			leng  = selected.allRcd.length;
			for(var i=0; i<leng; i++) {
				wp_ds.remove(selected.allRcd[i]);
			}
			
			var rcds = wp_ds.getAllChangedRecords();
			//除了删除的的可能还有其它记录，所以不能都保存
			if(rcds.length === leng) {
				wp_ds.commitChanges();	
			}
			
			L5.MessageBox.alert(res.prompts,res.removeOk);
	}});
}
function reset_wp_info() {
	wp_ds.rejectChanges();
}
function save_wp_info(){
	var rcds = page.changedRecord(wp_ds);
	var msg = page.checker.save(rcds);
	
	if(msg !== null){
		L5.MessageBox.alert(res.prompts,msg);
		return ;
	}
	
	var cmd = new L5.Command(page.cmd);
	cmd.setParameter('rcds',rcds);
	cmd.execute('saveWorkplace');
	if(cmd.error){
		L5.MessageBox.alert(res.prompts,cmd.error);
		return;
	}
	L5.MessageBox.alert(res.prompts,res.saveOK);
	wp_ds.commitChanges();
}
//根据名称 查询指定的工作地点
function query_name() {
	var name_ = document.getElementById('wp_name').value;
	wp_ds.setParameter('workplace_name@like',name_);
	wp_ds.load();
}

function reset(){
	document.getElementById('wp_name').value="";
}

//从“编辑页面“返回“查询列表页面“
function back2list() {
	var layout = L5.getCmp("cards").getLayout();
	layout.setActiveItem(0);
}
//选择一条记录，并且转到编辑页面进行编辑。
function edit_wp_info() {
	var selected = page.selectedRecordId('wp_panel');
	
	if(selected === null || selected.allRcd.length !== 1 ){
		L5.MessageBox.alert(res.prompts,res.selectOne);
		return ;		
	}
	var layout = L5.getCmp("cards").getLayout();
	layout.setActiveItem(1);	
}
//在“编辑页面”保存当前的单条工作地点信息。
function save_wp_info_single() {
	var cmd = new L5.Command(page.cmd);
	var rcd = wp_ds.getCurrent();
	var msg = page.checker.save([rcd]);
	
	if(msg !== null){
		if(msg.indexOf('cantCode')!=-1){
			L5.MessageBox.alert(res.prompts,"行政区划名称不能为空");
			return ;
		}else{
			L5.MessageBox.alert(res.prompts,msg.substring(3));
			return ;
		}
	}
	cmd.setParameter('rcds',[rcd]);
	cmd.execute('saveWorkplace');
	if(cmd.error){
		L5.MessageBox.alert(res.prompts,cmd.error);
		return;
	}
	L5.MessageBox.alert(res.prompts,res.saveOK);
	rcd.state = 0;
	wp_ds.commitChanges();
}
function pop_cant() {
	//L5.getCmp('cant_win').show();
	var cant_code_name = showModalDialog('poped_cant.jsp',"",
			"dialogHeight:500px;dialogWidth:650px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
	if(cant_code_name === undefined) {
		return;
	}
	
	var code_name = cant_code_name.split("=");
	var record  = wp_ds.getCurrent();
	record.set('cantCode',code_name[0]);
	record.set('cantName',code_name[1]);
}