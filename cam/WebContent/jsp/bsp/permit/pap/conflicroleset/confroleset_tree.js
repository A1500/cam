//初始化函数
//initionalize page,data and regist some function
function init(){
	page.avaiableRoleGrid = L5.getCmp('avaiableRoleGrid');
	page.avaiableRoleGrid.on('rowdblclick',function(){
		var rcd = role_dataset.getCurrent();
		var id = rcd.get('roleId');
		if(page.sameRoleList[id]!=null){
			return;
		}
		confrole_dataset.newRecord({roleId:id,setId:page.currentSetId,roleName:rcd.get('roleName')});
		rcd.set('relationId',rcd.get('relationId')+'#');
		page.sameRoleList[id] = rcd;
	});
	page.selectedRoleGrid = L5.getCmp('selectedConfRole');
	page.selectedRoleGrid.on('rowdblclick',function(){
		var rcd = confrole_dataset.getCurrent();
		var id = rcd.get('roleId');
		confrole_dataset.remove(rcd);
		var role  = page.sameRoleList[id];
		page.sameRoleList[id] = id;
		if(!role){
			return ;
		}
 		//触发renderer
 		role.set('relationId',
 				 role.get('relationId'+"#"));
 	});
	//role_dataset.on('load',page.disabledRedundancy);
	confrole_dataset.on('load',function(){
			role_dataset.load();
		
	});
	L5.QuickTips.init();
	page.refreshTree();
}
//树展开
//expand all nodes
function expanall(){
	var tree = L5.getCmp("rolesetTree");
	tree.expandAll();
}
//根节点触发
function endLoader(rec){
	if(rec.get("corporationId")!= 'rootnull') return false;
	return true;
}
//判断当前是不是叶子节点
//is leaf node or not
function isLeaf(rec){
	if(rec.get("corporationId")!= 'rootnull') return true;
	return false;
}
//添加不相容角色集
//add new conflict roleset
function addset(menuitem){
	page.currentNode =menuitem.parentMenu.record;
	page.state = 'add';
	page.currentSetId  = '0';
	document.getElementById('setName').value='';
	document.getElementById('cardinality').value='';
	confrole_dataset.removeAll();
	confroleset_dataset.removeAll();
	role_dataset.load();
	L5.getCmp('rightPan').show();
}
//删除不相容角色集
//remove conflict roleset
function removeset(menuitem){
	var rcd = menuitem.parentMenu.record;
	L5.Msg.confirm(res.PROMPT_WORD,res.REMOVE_WORD,
		      		function(isOk){
			      		if(isOk == 'yes'){
							var cmd = new L5.Command('org.loushang.bsp.permit.pap.confrole.cmd.ConfRoleSetCommand');
							cmd.setParameter('ids',[rcd.get('setId')]);
							cmd.execute('delete');
							if(!cmd.error){
								L5.Msg.alert(res.PROMPT_WORD,res.REMOVE_OK);
								page.refreshTree();
								L5.getCmp('rightPan').hide();
							}else{
								L5.Msg.alert(res.PROMPT_WORD,cmd.error);
							}
		      		     }
		     	 	});
}
//在右面pan中显示不相容角色集信息
//show information of selected conflict roleset in right panel
function showDetail(rec){
	
	page.selectedRecord = rec;
	page.sameRoleList=[]
	if(rec.get('corporationId') == 'rootnull'){
		return;
	}
	document.getElementById('setName').value=rec.get('setName');
	document.getElementById('cardinality').value=rec.get('cardinality');
//查询可用角色后5秒中内不再查询。防止频繁查询。
	//var date = new Date();
	//if(!page.lastTime ||
	 //  date- page.lastTime >5000){
	//	page.lastTime = date;
		//role_dataset.load();
	//}
	role_dataset.baseParams['setId'] = rec.get('setId');
	confrole_dataset.baseParams['setId'] = rec.get('setId');
	confrole_dataset.load();
	//alert(role_dataset.getPageIndex());

	L5.getCmp('rightPan').show();
	 page.watcher.setName = undefined;
	 page.watcher.cardinality = undefined;
	 page.currentNode = rec;
	 page.state = 'update';
	 page.currentSetId = rec.get('setId');
}
//判断当前节点是否是不相容角色集,
//现在和判断是否是叶子节点有些冲突，但是如果不相容角色集上面加上组织，
//也就是说，根节点下面不一定直接是叶子节点的时候，就有用了。
//current node is roleset or not;
function isRoleset(rec){
	if(rec.get("corporationId")!= 'rootnull') return true;
	return false;
}
//查询角色，会根据不相容角色集的角色进行过滤。
//在不相容角色集里出现的角色在角色列表中不会出现。
//query avilable roles
function queryRole(){
	role_dataset.setParameter('partRoleName@like',document.getElementById('roleNameParameter').value);
	role_dataset.load();
}
//sql like子句 的条件,匹配任意条件
//sql like clause,would query all record in db
function anything(){
	return '%%';
}
//检测dataset相应字段变化，放应到dom上（两个字段不好绑定）
function watcher(dom,domid){
	if(domid == 'setName'){
		page.watcher.setName = dom.value;
		return;
	}
	if(domid == 'cardinality'){
		page.watcher.cardinality =dom.value;
		return;
	}
}
//添加角色到不相容角色集
//add role into conflict roleset
function addConfRole(){
	var rcds = page.avaiableRoleGrid.getSelectionModel().getSelections();
	var leng = rcds.length;
	for(var i=0; i<leng; i++){
	if(page.sameRoleList[rcds[i].get('roleId')]!=null){//已经在不相容角色集中存在
			continue;
	}
		confrole_dataset.newRecord({roleId:rcds[i].get('roleId'),setId:page.currentSetId,roleName:rcds[i].get('roleName')});
		rcds[i].set('relationId',
				rcds[i].get('relationId')+"#");
	}
}
function removeConfRole(){
	var rcds = page.selectedRoleGrid.getSelectionModel().getSelections();
	var leng = rcds.length;
	var role;
	var id;
	for(var i=0; i<leng; i++){
		id = rcds[i].get('roleId');
		confrole_dataset.remove(rcds[i]);
		role  = page.sameRoleList[id];
		page.sameRoleList[id] = id;///not ref to an record now
 		if(!role){
			continue;
 		}
 		//触发renderer 修正 sameRoleList的数据
 		role.set('relationId',
 				 role.get('relationId')+"#");
	}
}
//增加，修改不相容角色集
//add,update conflict roleset
function saveAll(){
	if(!page.cadinality2rolePolicy()){
		return;
	}
	var confRoleChanges = confrole_dataset.getAllChangedRecords();
	if(page.watcher.setName !== undefined || page.watcher.cardinality !== undefined){
		if(page.state=='update'){
			confroleset_dataset.newRecord({
				setId:page.currentNode.get('setId'),
				setName:document.getElementById('setName').value,
				cardinality:document.getElementById('cardinality').value,
				corporationId:page.currentNode.get('corporationId')});
			confroleset_dataset.getAt(0).state= 3;
		}
		if(page.state=='add'){
			confroleset_dataset.newRecord({
				setName:document.getElementById('setName').value,
				cardinality:document.getElementById('cardinality').value
			});
			confroleset_dataset.getAt(0).state= 1;
		}
	}

	var roleSetChange = confroleset_dataset.getAt(0);
	var changedLeng = confRoleChanges.length;
	if(changedLeng<1 && confroleset_dataset.getCount()<1  ){
		L5.Msg.alert(res.PROMPT_WORD,res.NO_CHANGE);
		return;
	}
	page.removeDuplicate(confRoleChanges);
	var cmd = new L5.Command('org.loushang.bsp.permit.pap.confrole.cmd.ConfRoleSetCommand');
	cmd.setParameter('confRoleS',confRoleChanges);
	cmd.setParameter('confRoleSet',roleSetChange);
	cmd.execute('save');
	if(!cmd.error){
		L5.Msg.alert(res.PROMPT_WORD,res.SAVE_OK);
		page.refreshTree();
		showDetail(page.selectedRecord);
	}else{
		L5.Msg.alert(res.PROMPT_WORD,cmd.error);
	}
}
function roleNameRender(value,col,record){
	var id = record.get('roleId');
	var confRoles = confrole_dataset.getRange(0,
							confrole_dataset.getCount());
	var leng = confRoles.length;
	var hasSameRole = false;
	if(page.sameRoleList[id] == id)	{//右边的不相容角色集中已经没有该角色
		 delete page.sameRoleList[id];
	}else{
		for(var i=0; i<leng; i++){
			var confId = confRoles[i].get('roleId')
			if( confId== id){
				page.sameRoleList[id] =record;
				hasSameRole = true;
				break;
			}
		}
	}
	if(hasSameRole){
		return '<font color="green">'+value+'</font>';
	}
		return value;
}
//包含页面逻辑数据的一个对象
//one obj in page
var page;
if(!page) page= {};
//角色集树根节点
//data of root for roleset tree
page.rootdata={
   setId:'-1',
   setName:res.TREE_ROOTDATA_SETNAME,
   cardinality:'-1',
   corporationId:'rootnull',
   recordType:'rootType'
};
page.roledata={
	recordType:'confRoleType'
}
page.watcher = {};
//检查不相容角色集和基数是否匹配
//check if count of roles in set is valid for  cadinality.
page.cadinality2rolePolicy=function(){
	var cardinality  = document.getElementById('cardinality').value;
	var roleCount =confrole_dataset.getCount();
	if (!(/^\d+$/.exec(cardinality))){
		L5.Msg.alert(res.PROMPT_WORD,res.WARN_CARIDNALITY_INVALID);
		return false;
	}
	if(	cardinality <2){
		L5.Msg.alert(res.PROMPT_WORD,res.WARN_CARDINALITY_SMALL);
		return false;
	}
	if(	cardinality > roleCount){
		L5.Msg.alert(res.PROMPT_WORD,res.WARN_CARDINALITY_BAD_ROLE_COUNT);
		return false;
	}
	return true;
}
//去掉角色列表中和不相容角色集中重复的内容
//remove same role between list of role and list of roles in conflict roleset

page.disabledRedundancy=function(){
	var confRoleCount = confrole_dataset.getCount();
	var roleCount = role_dataset.getCount();
	var confRoles = confrole_dataset.getRange(0,confRoleCount-1);
	var roles = role_dataset.getRange(0,roleCount-1);
	var rmList = [];
	var k =0;
	for(var i=0; i<confRoleCount; i++){
		for(var j = 0;j < roleCount; j++){
			if(confRoles[i].get('roleId') ==
			   roles[j].get('roleId')){
				rmList[k++] = role_dataset.getAt(j);
				j=roleCount;
			}
		}
	}
	for(var i=0; i<k;i++){
		role_dataset.remove(rmList[i]);
	}
}
//刷新角色集树
//refresh roleSet tree
page.refreshTree=function(){
		var tree = L5.getCmp('rolesetTree');
		var node = tree.getNodeByRecordId(page.rootdata.setId,'rootType');
		var record = node.record;
		record.reload({callback:function(){node.expand();}});
}
//page.sameRoleList是个map，键是roleId，值是roleId或者role的record
//表示的含义不同，值是roleId的时候，说明这个角色被删除了。
page.sameRoleList = [];
//存放当前被选择的树的记录
page.selectedRecord;
//删除重复的记录
//先删除再增加会导致结果集中一个主键的reord既在增加中，又删除中。
page.removeDuplicate=function(rcds){
	var addRcd;
	var removeRcd;
	var leng = rcds.length;
	var removingSameIds=[];
	
	//找到既在增加状态又在删除状态的record的roleid
	for(var i=0; i<leng; i++){
		if(rcds[i].state != '1') continue;
		addRcd = rcds[i];
		for(var j=0; j<leng;j++){
			if(rcds[j] != '2') continue;
			removeRcd = rcds[j];
			if(addRcd.get('roleId') == removeRcd.get('roleId')){
				removingSameIds.push(removeRcd.get('roleId'));
			}
		}
	}
	var removingleng = removingSameIds.length;
	for(var i=0; i<removingleng; i++){
		for(var j = 0; j<rcds.length; j++){
			if(rcds[j].get('roleId') == removingSameIds[i] ){
				rcds.splice(j,1);
			}
		}
		
	}
}
	
//在查询角色的时候角色来源的查询条，把下面两行放到jsp角色名称的查询条件后面
//{text: '<%=res.get("ROLE_SOURCE")%>'},
//{xtype: 'combo',id: 'roleFrom',triggerAction:'all',displayField:'setName',valueField:'setName',store:confroleset_dataset,width:100},
