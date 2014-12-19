function init() {
	
};

function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function jtxxQuery() {
 	var ds = L5.DatasetMgr.lookup("ds");
    var hzxm = document.getElementById("hzxmquery").value;
    var sfzh = document.getElementById("sfzhquery").value;
    if(hzxm==""&&sfzh==""){
			L5.Msg.alert("提示","请至少输入姓名或身份证号！");
			return;
		}
    var shbz = document.getElementById("shbzquery").value;
    var jzlxdm = document.getElementById("jzlxquery").value;
    var queryFlag = document.getElementById("queryFlag").value;//判断查询列表
    //ds.setParameter("BASEINFO_FAMILY.JTDZ@!=", '1');//是否计算过救助指数标志
    ds.setParameter("FAMILY_NAME", hzxm);
    ds.setParameter("FAMILY_CARD_NO", sfzh);
    ds.setParameter("CHECK_FLAG", shbz);
    if(jzlxdm!=""){
    	dataset.setParameter("ASSISTANCE_TYPE",jzlxdm);
    }
	ds.setParameter("QUERYFLAG",queryFlag);
    ds.load();
}
/**
 *  事件处理：点击登记按钮
 *  困难家庭登记列表--登记
 *  licb
 */
 var win_check;
function insert() {
 /*   var data = new L5.Map();
    data.put("method", "INSERT");

    var url = 'jsp/sdmz/jtxx/ygjzjtxx_insert.jsp';
    var text = '增加阳光救助_家庭信息';
    L5.forward(url, text, data);
*/
	if(win_check==undefined){
		win_check=L5.getCmp("check_win");
	}
	win_check.show(this);
}
/**
 *  事件处理：点击变更按钮
 *  困难家庭登记列表--变更
 *  licb
 */
function update() {
    var editGrid = L5.getCmp('editGridPanel');
    var selected = editGrid.getSelectionModel().getSelections();
    if (selected.length != 1) {
        L5.Msg.alert('提示', "请选择一条记录修改!");
        return false;
    }
    var data = new L5.Map();
    data.put("method", "UPDATE");
    data.put("dataBean", selected[0].get('FAMILY_ID'));
    data.put("photoId", selected[0].get('PHOTO_ID'));
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_update.jsp';
    var text = '修改阳光救助_家庭信息';
    L5.forward(url, text, data);
}
/**
 *  事件处理：点击移交到审核按钮
 *  困难家庭登记列表--移交到审核
 *  licb
 */
function toExam() {
	var ds = L5.DatasetMgr.lookup("ds");
    var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要移交的记录!");
		return false;
	}
	var jtids=[];
	for(var i=0;i<selected.length;i++){
		jtids[i]=selected[i].get("FAMILY_ID");
	}

	L5.MessageBox.confirm('确定', '确定要移交选中的' + jtids.length + '条记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
			command.setParameter("jtids", jtids);
			command.execute("toExam");
			if (!command.error) {
		        ds.setParameter("QUERYFLAG", "ACCEPT");
		        ds.setParameter("organCode",organArea);
				ds.load();
				jtxxNumDs.setParameter("QUERYFLAG", "ACCEPT");
				jtxxNumDs.setParameter("organCode", organArea);
				jtxxNumDs.load();
			}else{
				L5.Msg.alert('提示',"提交时出现错误！"+command.error);
				return false;
			}
		}else{
			return false;
		}
	});
}
/**
 *  事件处理：点击注销按钮
 *  困难家庭登记列表--移交到审核
 *  licb
 */
function del() {
	var ds = L5.DatasetMgr.lookup("ds");
	var jtxxNumDs = L5.DatasetMgr.lookup("jtxxNumDs");
    var editGrid = L5.getCmp('editGridPanel');
    var selected = editGrid.getSelectionModel().getSelections();
    if (selected.length < 1) {
        L5.Msg.alert('提示', "请选择要删除的记录!");
        return false;
    }
    L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',
    function(state) {
        if (state == "yes") {
            var delIds = [];
            for (var i = 0; i < selected.length; i++) {
                delIds[i] = selected[i].get("FAMILY_ID");
            }
            var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
            command.setParameter("delIds", delIds);
            command.execute("delete");
            if (!command.error) {
                for (var i = 0; i < selected.length; i++) {
                    ds.remove(selected[i]);
                }
                ds.commitChanges();
               
    			var queryFlag = document.getElementById("queryFlag").value;
     			ds.setParameter("QUERYFLAG",queryFlag);
     			ds.setParameter("organCode",organArea);
    			 jtxxNumDs.setParameter("QUERYFLAG",queryFlag);
    			 jtxxNumDs.setParameter("organCode",organArea);
   				 ds.load();
   				 jtxxNumDs.load();
            } else {
                L5.Msg.alert('提示', "保存时出现错误！" + command.error);
            }
        } else {
            return false;
        }
    });
}
//更新外网救助指数
function updateJzzs() {
	var ds = L5.DatasetMgr.lookup("ds");
    var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要移交的记录!");
		return false;
	}
	var jtids=[];
	for(var i=0;i<selected.length;i++){
		jtids[i]=selected[i].get("FAMILY_ID");
	}
	L5.MessageBox.confirm('确定', '确定要移交选中的' + jtids.length + '条记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
			command.setParameter("jtids", jtids);
			command.execute("updateJzzs");
			if (!command.error) {
		        ds.setParameter("QUERYFLAG", "ACCEPT");
				ds.load();
			}else{
				L5.Msg.alert('提示',"提交时出现错误！"+command.error);
				return false;
			}
		}else{
			return false;
		}
	});
}

function jtxxCorrectHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:jtxxCorrectDetail(\'' + record.data["FAMILY_ID"] + '\')">' + value + '</a>';
}
function jtxxCorrectDetail( jtid ) {
    var data = new L5.Map();
    data.put("method", "UPDATE");
    data.put("dataBean", jtid);
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_update.jsp';
    var text = '审核阳光救助_家庭信息';
    L5.forward(url, text, data);
}
function jtxxCorrect() {
    var editGrid = L5.getCmp('editGridPanel');
    var selected = editGrid.getSelectionModel().getSelections();
    if (selected.length != 1) {
        L5.Msg.alert('提示', "请选择一条记录审核!");
        return false;
    }
    jtxxCorrectDetail(selected[0].get('FAMILY_ID'));
}
function jtxxExamHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:jtxxExamDetail(\'' + record.data["FAMILY_ID"] + '\',\''+record.data["PHOTO_ID"]+'\')">' + value + '</a>';
}
function jtxxDetailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:jtxxDetail(\'' + record.data["FAMILY_ID"] + '\',\''+record.data["PHOTO_ID"]+'\')">' + value + '</a>';
}
function jtxxQueryHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:jtxxStateDetail(\'' + record.data["FAMILY_ID"] +  '\',\''+record.data["PHOTO_ID"]+'\')">' + value + '</a>';
}
function jtxxDetail( jtid,photoid) {
    var data = new L5.Map();
    data.put("method", "EXAM");
    data.put("dataBean", jtid);
    data.put("photoId", photoid);
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_forDetail.jsp';
    var text = '审核阳光救助_家庭信息';
    L5.forward(url, text, data);
}
function jtxxExamDetail( jtid ,photoid) {
    var data = new L5.Map();
    data.put("method", "EXAM");
    data.put("dataBean", jtid);
    data.put("photoId", photoid);
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_exam.jsp';
    var text = '审核阳光救助_家庭信息';
    L5.forward(url, text, data);
}
function jtxxStateDetail( jtid ,photoid) {
    var data = new L5.Map();
    data.put("method", "EXAM");
    data.put("dataBean", jtid);
    data.put("photoId", photoid);
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_forDetail.jsp';
    var text = '审核阳光救助_家庭信息';
    L5.forward(url, text, data);
}

function jtxxExam() {
    var editGrid = L5.getCmp('editGridPanel');
    var selected = editGrid.getSelectionModel().getSelections();
    if (selected.length != 1) {
        L5.Msg.alert('提示', "请选择一条记录审核!");
        return false;
    }
    jtxxExamDetail(selected[0].get('FAMILY_ID'),selected[0].get('PHOTO_ID'));
}

/**
 *  事件处理：点击重置按钮
 *  困难家庭登记列表
 *  licb
 */
function reset(){
	var form=L5.getDom("queryForm");
	form.reset();
}
/*
 * 通用帮助
 */
function forHelp(){
	var revalue=window.showModalDialog("../../bsp/organization/getselect.jsp?rootId="+struId+"&showOrganType=0&organType=12,13,14,15&isExact=1&isCheckBox=1&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		//list[0] == organId,list[1]==organName,list[2]==struId
//		var userDataset = L5.DatasetMgr.lookup("userDataset");
//		var userRecord = userDataset.getCurrent();
		document.getElementById("lrdwId").value = list[0];
		document.getElementById("lrdwmc").value = list[1];

	}
}
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&radioType=checkbox&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("lrdwId").value = list[0];
		document.getElementById("lrdwmc").value = list[1];
	}
}
/**
 * 困难家庭登记查询、
 */
function query(){
	var dataset = L5.DatasetMgr.lookup("ds");
	var jtxxNumDs = L5.DatasetMgr.lookup("jtxxNumDs");
	var lrrqQ=document.getElementById("lrrqQ").value;//录入时间
	var lrrqZ=document.getElementById("lrrqZ").value;//录入时间
    var hzxm = document.getElementById("hzxmquery").value;//户主姓名
    var sfzh = document.getElementById("sfzhquery").value;//身份证号码
    var shbz = document.getElementById("shbzquery").value;//审核标志
    var lrdwId = document.getElementById("lrdwIdquery").value;//录入单位ID
    var jzlxdm = document.getElementById("jzlxquery").value;//救助类型
    var queryFlag = document.getElementById("queryFlag").value;//判断查询列表
    var lrrqQ = document.getElementById("lrrqQ").value;//录入日起S
    var lrrqZ = document.getElementById("lrrqZ").value;//录入日起T
	//dataset.setParameter("YGJZ_JTXX.JTDZ@!=","1");//是否计算过救助指数标志

	if(hzxm=="") hzxm=undefined;
	dataset.setParameter("FAMILY_NAME",hzxm);
	jtxxNumDs.setParameter("FAMILY_NAME",hzxm);

	//@Q
	if(lrrqQ=="") lrrqQ=undefined;
	dataset.setParameter("REG_TIMEQ", lrrqQ);
	jtxxNumDs.setParameter("REG_TIMEQ", lrrqQ);

	if(lrrqZ=="") lrrqZ=undefined;
    dataset.setParameter("REG_TIMEZ", lrrqZ);
    jtxxNumDs.setParameter("REG_TIMEZ", lrrqZ);

	if(sfzh=="") sfzh=undefined;
	dataset.setParameter("FAMILY_CARD_NO",sfzh);
	jtxxNumDs.setParameter("FAMILY_CARD_NO",sfzh);

	if(shbz=="") shbz=undefined;
	dataset.setParameter("CHECK_FLAG",shbz);
	jtxxNumDs.setParameter("CHECK_FLAG",shbz);

	if(lrdwId=="") lrdwId=undefined;
	dataset.setParameter("REG_ORG",lrdwId);
	jtxxNumDs.setParameter("REG_ORG",lrdwId);

	if(jzlxdm=="") jzlxdm=undefined;
	dataset.setParameter("ASSISTANCE_TYPE",jzlxdm);
	jtxxNumDs.setParameter("ASSISTANCE_TYPE",jzlxdm);

	 if(queryFlag=="") queryFlag=undefined;
	dataset.setParameter("QUERYFLAG",queryFlag);
	jtxxNumDs.setParameter("QUERYFLAG",queryFlag);
	
	dataset.setParameter("organCode",organArea);
	jtxxNumDs.setParameter("organCode",organArea);
	
	dataset.load();
	jtxxNumDs.load();
}
//help帮助
 function mutiHelp() {
	var itemWin = L5.getCmp("multiItem_help");
	if(itemWin) {
		itemWin.show();
		return;
	} else {
		var itemDs = L5.DatasetMgr.lookup("DmJzlxDataSet");
		var item_config={};
		item_config.id="multiItem_help";
		item_config.dataset = itemDs;
		item_config.gridColumns=[{header:"编号",sortable:true,field:"value"},{header:"名称",sortable:true,field:"text"}];
		var multiItem_search=new L5.SearchAreaM();
		multiItem_search.addTextField("code","编号","DIC_ASSITANCE_TYPE_EXT.CODE");
		multiItem_search.addTextField("name","名称","DIC_ASSITANCE_TYPE_EXT.NAME");
		itemWin = new L5.MultiGridHelpWindow1(item_config,multiItem_search);
		itemWin.show();
	}
	//进行调用
	itemWin.afterExecute=function(){
		var result=this.getReturn();
    	if(result!=null&&!itemWin.isClear){
    		setValue(result);
    	}
	}
}
//设置帮主栏值
function setValue(result) {
	var jzlx = document.getElementById("jzlx");
	var jzlxquery = document.getElementById("jzlxquery");
	jzlx.value="";
	jzlxquery.value="";
	var reValue = "";
	if(result.length) {
		for(var i=0;i<result.length;i++) {
			var record = result[i];
			if(jzlx.value=="") {
				jzlx.value += (record.get("text"));
				jzlxquery.value += (record.get("value"));
			} else {
				jzlx.value += (","+record.get("text"));
				jzlxquery.value += (","+record.get("value"));
			}
		}
	} else {
		jzlx.value = result.get("text");
		jzlxquery.value = result.get("value");
	}
}


function calamityTypeRef(values) {
if(values.length==0){
       return "";
    }
var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	var records = DmXzqhDataSetStreet.getAllRecords();
	var record=DmXzqhDataSetStreet.find();
	if(records) {
		for(var r=0;r<records.length;r++) {
			if(values.indexOf(records[r].get("value"))!=-1) {
				texts.push(records[r].get("text"));
			}
		}
	}
	return texts.join(">");
}

function jzlxDbClick() {
	document.getElementById("jzlx").value="";
	document.getElementById("jzlxquery").value="";
}

function tochange(){
	if(organArea.substring(4,12)=="00000000")
	{	
		L5.Msg.alert('提示', "您不是区县用户，没有权限修改!");
	}else if(organArea.substring(6,12)=="000000"){	
		var ds = L5.DatasetMgr.lookup("ds");
		var flag = ds.get("CUR_ACTIVITY");
		if(flag!='FINISHOK'){
			L5.Msg.alert('提示', "请选择当前环节为“审核通过”的进行修改!");
		}else{
		
		var editGrid = L5.getCmp('editGridPanel');
    	var selected = editGrid.getSelectionModel().getSelections();
   
    	var data = new L5.Map();
    	data.put("method", "UPDATE");
    	data.put("dataBean", selected[0].get('FAMILY_ID'));
    	data.put("photoId", selected[0].get('PHOTO_ID'));
    	var url = 'jsp/sdmz/jtxx/ygjzjtxx_change.jsp';
   		var text = '修改阳光救助_家庭信息';
    	L5.forward(url, text, data);
    	}
	}else {
		L5.Msg.alert('提示', "您不是区县用户，没有权限修改!");
	}
}

//----------校验唯一性-----------

function save_win(){
	var checkIdCard=document.getElementById("checkIdCard").value;
	if(checkIdCard==""){
		L5.Msg.alert("提示","身份证号码，不能为空！");
		return;
	}
	var command=new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCyxxCmd");
	command.setParameter('checkIdCard',checkIdCard);
	command.execute('checkByIdCard');
	var ids=command.getReturn("getFamilyPhotoId");
	if(ids=="0"){
		var data = new L5.Map();
	    data.put("method", "INSERT");
		data.put("dataBean",checkIdCard);
	    var url = 'jsp/sdmz/jtxx/ygjzjtxx_insert.jsp';
	    var text = '增加阳光救助_家庭信息';
	    L5.forward(url, text, data);
	}else{
		var arry=ids.split("%");
		if(!is_localPeople(arry[2])){
			L5.Msg.alert('提示','此人员已经在其他地区登记！');
			return;
		}
		if(!is_update(arry[3])){
			L5.Msg.alert('提示','此人员已经在系统中，且不进行修改！');
			return;
		}
		var data = new L5.Map();
	    data.put("method", "UPDATE");
	    data.put("dataBean", arry[0]);
	    data.put("photoId", arry[1]);
	    var url = 'jsp/sdmz/jtxx/ygjzjtxx_update.jsp';
	    var text = '修改阳光救助_家庭信息';
	    L5.forward(url, text, data);
	}	
}
function close_win(){
	win_check.hide();
}
  /**
 *  困难户家庭登记
 *  事件处理：自动获取身份证号码
 *
 */

function getMaxCode(){

   var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
   command.execute("getMaxCode");
   var idCardExtend=command.getReturn('idCardExtend');
   if(idCardExtend==undefined){
     L5.Msg.alert("提示","当前编号已经最大，请联系管理员！");
   }

   document.getElementById("checkIdCard").value=idCardExtend;
}

/**
* 是否本区管理人员
*/
function is_localPeople(localArea){

	if(organArea.substring(4,12)=="00000000")
	{	
		var organArea1=organArea.substring(0,4);
		if(localArea.substring(0,4)==organArea1){
			return true;
		}else{
			return false;
		}
		
	}else if(organArea.substring(6,12)=="000000")
	{
		 var organArea1=organArea.substring(0,6);
		 if(localArea.substring(0,6)==organArea1){
			return true;
		}else{
			return false;
		}
	}
	else if(organArea.substring(9,12)=="000")
	{
		var  organArea1=organArea.substring(0,9);
		if(localArea.substring(0,9)==organArea1){
			return true;
		}else{
			return false;
		}
	}else if(!organArea.substring(9,12)=="000")
	{
		var organArea1=organArea;
		if(localArea==organArea1){
			return true;
		}else{
			return false;
		}
	}
}
/**
*是否可以修改
*/	
function is_update(cur_activity){
	if(cur_activity=='ACCEPT'){
		return true;
	}else{
		return false;
	}
}