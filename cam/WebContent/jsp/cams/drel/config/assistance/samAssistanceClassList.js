function init(){
	//救助项目加载
	samAssistanceItemDataset.setParameter("filterSql", "ITEM_TYPE='01' AND STATUS='1' and area_code in "+" ( "+filterAreaCode+" )");//分类施保
	samAssistanceItemDataset.on('load',loadSamAssistanceClassList);	
	samAssistanceItemDataset.load();
}

function query(){
	var samAssistanceClassList=L5.DatasetMgr.lookup("samAssistanceClassList");
	samAssistanceClassList.setParameter("AREA_CODE@=",currentOrganCode);
	samAssistanceClassList.setParameter("ASSISTANCE_TYPE@=",document.getElementById('queryassistanceType').value);
	samAssistanceClassList.setParameter("IN_USE@=",document.getElementById('queryinUse').value);
	samAssistanceClassList.load();
}
function loadSamAssistanceClassList(){
	var samAssistanceClassList=L5.DatasetMgr.lookup("samAssistanceClassList");
	samAssistanceClassList.setParameter("AREA_CODE@=",currentOrganCode);
	samAssistanceClassList.load();
	assistanceTypeSelect.filterBy(function(record, id){
		if("01".indexOf(record.get('value'))>-1 || "02".indexOf(record.get('value'))>-1 ){
			return record;
		}
	});
}
//新增
function insert(){
	var winAssistanceClassDataSet = L5.DatasetMgr.lookup("winAssistanceClassDataSet");
	winAssistanceClassDataSet.removeAll();
	winAssistanceClassDataSet.newRecord({'areaCode':currentOrganCode,'inUse':1,'beginDate':nowTime,'endDate':'3000-12-12'});
	var win = L5.getCmp("assistanceClassWin");
	win.show();
	$('assistanceType').disabled=false;
	$('assistanceClassCode').disabled=false;
}
//修改
function update(){
	var grid = L5.getCmp("assistanceClassGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	if(record.get('inUse')=='0'){
		L5.Msg.alert("提示","该救助标准已经停用，不能进行修改!");
		return;		
	}
	var assistanceClassId=record.get('assistanceClassId');
	var winAssistanceClassDataSet = L5.DatasetMgr.lookup("winAssistanceClassDataSet");
	winAssistanceClassDataSet.setParameter('ASSISTANCE_CLASS_ID',assistanceClassId);
	winAssistanceClassDataSet.load();
	var win = L5.getCmp("assistanceClassWin");
	win.show();
	$('assistanceType').disabled=true;
	$('assistanceClassCode').disabled=true;
}
//删除
function stop(){
	var grid = L5.getCmp("assistanceClassGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	if(record.get('inUse')=='0'){
		L5.Msg.alert("提示","该分类施保类别已经停用!");
		return;		
	}
	L5.MessageBox.confirm('确定', '你确定要停用此分类施保类别吗？',function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.drel.config.assistance.cmd.SamAssistanceClassCmd");
			command.setParameter("assistanceClassRecord", record);
			command.execute("stop");
			if (!command.error) {
				L5.Msg.alert("提示","停用成功！");
				var samAssistanceClassList=L5.DatasetMgr.lookup("samAssistanceClassList");			
				samAssistanceClassList.setParameter("AREA_CODE@=",currentOrganCode);	
				samAssistanceClassList.load();
			}else{
				L5.Msg.alert('提示',"停用时出现错误！"+command.error);
			}
		}
	});
}
//确定
function confirmWin(){
	var winAssistanceClassDataSet = L5.DatasetMgr.lookup("winAssistanceClassDataSet");
	var winAssistanceClassDataSetIsValidate = winAssistanceClassDataSet.isValidate();
	if(winAssistanceClassDataSetIsValidate != true){
		L5.Msg.alert("提示",winAssistanceClassDataSetIsValidate);
		return false;
	}	
	winAssistanceClassDataSet.set('assistanceClassName',$('assistanceClassCode').options[$('assistanceClassCode').selectedIndex].text);
	var command = new L5.Command("com.inspur.cams.drel.config.assistance.cmd.SamAssistanceClassCmd");
	command.setParameter("assistanceClassRecord", winAssistanceClassDataSet.getCurrent());
	command.execute("save");	
	var win = L5.getCmp("assistanceClassWin");
	win.setVisible(false);
	if (!command.error) {
		samAssistanceClassList.commitChanges();
		L5.Msg.alert("提示","保存成功！",function(){
			var samAssistanceClassList=L5.DatasetMgr.lookup("samAssistanceClassList");			
			samAssistanceClassList.setParameter("AREA_CODE@=",currentOrganCode);	
			samAssistanceClassList.load();
		});
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
//窗口关闭
function closeWin(){
	var win = L5.getCmp("assistanceClassWin");
	win.setVisible(false);
}
function getComputeMode(value,cellmeta,record,rowindex,colindex,dataset){
	var computeMode=record.get('computeMode');
	if(computeMode=="01"){
		return '<label >'+'增加固定金额'+'</label>';
	}else if(computeMode=="02"){
		return '<label >'+'低保金上浮'+'</label>';
	}else{
		return "";
	} 
}
function formateComPuteValue(value,cellmeta,record,rowindex,colindex,dataset){
	var computeMode=record.get('computeMode');
	var computeValue=record.get('computeValue');
	if(computeMode=="01"){
		return computeValue+"元";
	}else if(computeMode=="02"){
		return computeValue+"%";
	}else{
		return "";
	} 
}
function formateEndDate(value,cellmeta,record,rowindex,colindex,dataset){
	var inUse=record.get('inUse');
	var endDate=record.get('endDate');
	if(inUse=="1"){
		return "";
	}else{
		return endDate;
	} 
}
function getInUse(value,cellmeta,record,rowindex,colindex,dataset){
	var inUse=record.get('inUse');
	if(inUse=="1"){
		return '<label style="color:green">'+'启用'+'</label>';
	}else if(inUse=="0"){
		return '<label style="color:red">'+'停用'+'</label>';
	}else{
		return "";
	} 
}
function setValueUnit(){
	if("01"==_$("computeMode")){
		$("valueLabel").innerText="增加金额（元）";
	}
	if("02"==_$("computeMode")){
		$("valueLabel").innerText="上浮比例（%）";
	}
}
//字典表解析
function getDicText(dicDataSet,value){
	for (var i=0;i<dicDataSet.getTotalCount();i++){
		var record = dicDataSet.getAt(i);
		if(dicDataSet.getAt(i).get('value')==value){
			return record.get('text');
		}
	}
	return "";
}		
function checkAssistanceClassCode(){
	if(_$('assistanceType')==''||_$('assistanceClassCode')==''){
		return;
	}
	//新增时 校验分类施保类别代码
	var samAssistanceClassQueryDataset = L5.DatasetMgr.lookup("samAssistanceClassQueryDataset");
	samAssistanceClassQueryDataset.setParameter("AREA_CODE@=",currentOrganCode);	
	samAssistanceClassQueryDataset.setParameter("ASSISTANCE_TYPE@=",_$('assistanceType'));	
	samAssistanceClassQueryDataset.setParameter("ASSISTANCE_CLASS_CODE@=",_$('assistanceClassCode'));	
	samAssistanceClassQueryDataset.on('load',function(ds){
		if(ds.getCount()>0){
			L5.Msg.alert("提示","分类施保类别已存在，请在原类别基础上修改!");
			winAssistanceClassDataSet.setParameter('ASSISTANCE_CLASS_ID',ds.get('assistanceClassId') );
			winAssistanceClassDataSet.load();
			$('assistanceType').disabled=true;
			$('assistanceClassCode').disabled=true;
			return false;
		}
	});
	samAssistanceClassQueryDataset.load();
}	
