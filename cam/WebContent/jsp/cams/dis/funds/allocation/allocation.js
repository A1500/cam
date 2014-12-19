//全局变量 用来保存发放明细列表中点update是选中的record，用来在弹出窗口确定时，先删除发放列表中的record，然后insert一个新的
var detailListDsUpdateRecord;
function init() {
	ds.baseParams["ID@="]=idField;
	ds.load();
	ds.on("load",function(){
		fillPurpose("upAllocationPurpose");
		fillPurpose("zyAllocationPurpose");
		fillPurpose("stAllocationPurpose");
		fillPurpose("csAllocationPurpose");
		fillPurpose("qxAllocationPurpose");
	});
	if(organType == "11"){
		document.getElementById("ZY").style.display = "";
	}
	if(organType == "12"){
		document.getElementById("ZY").style.display = "";
		document.getElementById("ST").style.display = "";
	}
	if(organType == "13"){
		document.getElementById("ZY").style.display = "";
		document.getElementById("ST").style.display = "";
		document.getElementById("CS").style.display = "";
	}
	if(organType == "14"){
		document.getElementById("ZY").style.display = "";
		document.getElementById("ST").style.display = "";
		document.getElementById("CS").style.display = "";
		document.getElementById("QX").style.display = "";
	}
	detailListDs.baseParams["FROM_SOURCE_ID@="]=idField;
	detailListDs.load();
}
//组装资金类型方法，并给页面字段赋值
function fillPurpose(fieldName){
	var purpose = ds.get(fieldName);
	if(purpose == ""){
		return;
	}
	var nameArr = purpose.split(",");
	var name = "";
	for(var i = 0;i<nameArr.length;i++){
		var records = allocationPurposeSelect.query("value",nameArr[i]);
		if(i == nameArr.length-1){
			name+= records.items[0].get("text");
		}else{
			name+= records.items[0].get("text")+",";
		}
	}
	document.getElementById(fieldName+"Name").innerHTML = name;
}

function save(){
    var detaiRecords = detailListDs.getAllRecords();
    var sourceRecord = ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.dis.allocation.cmd.DisAllocationCommand"); 
	command.setParameter("detaiRecords",detaiRecords);
	command.setParameter("sourceRecord",sourceRecord);
	command.execute("saveAllocation");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		//back();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back()
 {	 	var url='jsp/cams/dis/funds/manage/fundsmanage_list.jsp';
		var text = 'DIS_FUNDS_SOURCE';
		L5.forward(url,text);	 
 }


function pickType(){
	pickTypeInfo("upAllocationPurposeName","upAllocationPurpose");
}

function removeType(){
	removeTypeInfo("upAllocationPurposeName","upAllocationPurpose");
}

function insertDetail() {
	var detailEditWin=L5.getCmp("detailEditWin");
	detailEditWin.show();
	detailDs.newRecord({"disYear":ds.get("disYear"),
	"allocationLevel":ds.get("allocationLevel"),
	"zyAllocationNum":ds.get("zyAllocationNum"),
	"zyAllocationTotal":ds.get("zyAllocationTotal"),
	"zyAllocationType":ds.get("zyAllocationType"),
	"zyAllocationPurpose":ds.get("zyAllocationPurpose"),
	"stAllocationNum":ds.get("stAllocationNum"),
	"stAllocationTotal":ds.get("stAllocationTotal"),
	"stAllocationType":ds.get("stAllocationType"),
	"stAllocationPurpose":ds.get("stAllocationPurpose"),
	"csAllocationNum":ds.get("csAllocationNum"),
	"csAllocationTotal":ds.get("csAllocationTotal"),
	"csAllocationType":ds.get("csAllocationType"),
	"csAllocationPurpose":ds.get("csAllocationPurpose"),
	"qxAllocationNum":ds.get("qxAllocationNum"),
	"qxAllocationTotal":ds.get("qxAllocationTotal"),
	"qxAllocationType":ds.get("qxAllocationType"),
	"cqxAllocationPurpose":ds.get("qxAllocationPurpose"),
	"allocationTotal":ds.get("upAllocationTotalCount"),
	"allocationDate":date,
	"oprStatus":"NEW"
	});
	document.getElementById("allocationTotal").innerHTML=ds.get("upAllocationTotalCount");
}

function updateDetail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	detailListDsUpdateRecord = selected[0];
	detailDs.insert(0,selected[0].copy());
	if(selected[0].get("oprStatus") == "SAVE"||selected[0].get("oprStatus") == "UPDATE"){
		detailDs.set("oprStatus","UPDATE");
	}else{
		detailDs.set("oprStatus","NEWUPDATE");
	}
	var detailEditWin=L5.getCmp("detailEditWin");
	detailEditWin.show();
	document.getElementById("allocationTotal").innerHTML=detailDs.get("allocationTotal");
}

function delDetail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	if(detailListDs.get("oprStatus") != "SAVE" && detailListDs.get("oprStatus") != "UPDATE"){
		detailListDs.remove(selected[0]);
	}
	
}
function fillPurposeName(value,cellmeta,record,rowindex,colindex,dataset){
	var nameArr = value.split(",");
	var name = "";
	for(var i = 0;i<nameArr.length;i++){
		var records = allocationPurposeSelect.query("value",nameArr[i]);
		if(i == nameArr.length-1){
			name+= records.items[0].get("text");
		}else{
			name+= records.items[0].get("text")+",";
		}
	}
	return name;
}

function saveDetal(){
	//校验
	var valid = detailDs.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
	if(detailDs.get("oprStatus") == "NEW"){
		detailListDs.insert(0,detailDs.getCurrent().copy());
	}
	if(detailDs.get("oprStatus") == "UPDATE"){
		detailListDs.remove(detailListDsUpdateRecord);
		detailListDsUpdateRecord="";
		detailListDs.insert(0,detailDs.getCurrent().copy());
	}
	if(detailDs.get("oprStatus") == "NEWUPDATE"){
		detailListDs.remove(detailListDsUpdateRecord);
		detailListDsUpdateRecord="";
		var insertRecord = detailDs.getCurrent().copy();
		insertRecord.set("oprStatus")="NEW";
		detailListDs.insert(0,detailDs.getCurrent().copy());
	}
	detailDs.removeAll();
	colseDetailEditWin();
}

//关闭窗口
function colseDetailEditWin(){
	detailDs.removeAll();
	var detailEditWin=L5.getCmp("detailEditWin");
	detailEditWin.hide();
}

function pickType(){
	pickTypeInfoSelf("allocationPurposeName","allocationPurpose");
}
//选择数据，并回填
function pickTypeInfoSelf(displayName,hiddenValue){
	var typeGrid=L5.getCmp("typeGrid");
	var cell=typeGrid.getSelectionModel().getSelections();
	if(cell.length<1){
		L5.Msg.alert("提示","请至少选择一条要查看的记录！");
		return;
	}
	document.getElementById(hiddenValue).value="";
	document.getElementById(displayName).value="";
	for(var i=0;i<cell.length;i++){
		if(document.getElementById(hiddenValue).value==""){		
			document.getElementById(hiddenValue).value += cell[i].get("value");
			document.getElementById(displayName).value += cell[i].get("text");
			detailDs.set(hiddenValue,document.getElementById(hiddenValue).value);
		}else{	
			document.getElementById(hiddenValue).value += (','+cell[i].get("value"));
			document.getElementById(displayName).value += (','+cell[i].get("text"));
			detailDs.getCurrent().set(hiddenValue,document.getElementById(hiddenValue).value);
		}
	}
	colseTypeWin();
}


// 选择管辖单位-无Ds赋值,查询使用
function selectOrganNoDs() {
	var userInfo;
	var command = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	command.execute("getUserInfo");
	if (!command.error) {
		userInfo = command.getReturn("userInfo");
	} else {
		alert("用户没有登录！");
		return;
	}

	var cantCode = userInfo.cantCode;
	var cantName = userInfo.cantName;
	var cantType = userInfo.userDepOrganType;
	var url = L5.webPath
			+ "/jsp/cams/dis/comm/organTree.jsp?cantCode="
			+ cantCode + "&cantName=" + escape(encodeURIComponent(cantName))
			+ "&cantType=" + cantType ;
	if(ds.get("allocationLevel") == "11"){
		url += "&selectedType=12,";
	}
	if(ds.get("allocationLevel") == "12"){
		url += "&selectedType=13,";
	}
	if(ds.get("allocationLevel") == "13"){
		url += "&selectedType=14,";
	}
	var win = showModalDialog(url, null,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:550px");
	if (win == null) {
		return;
	}

	var id = "";
	var name = "";
	var id_name = "";

	// 如果是点击的是【确定】
	if (win[0].length > 0) {

		// 第一个值前面没有逗号
		id = win[0][0];// id1,id2,id3......
		name = win[1][0];// name1,name2,name3......
		id_name = id + "[" + name + "]";// id1[name1],id2[name2],id3[name3].......

		// 其余值之间用逗号分隔
		if (win[0].length > 1) {
			for (var i = 1; i < win[0].length; i++) {
				id = id + "," + win[0][i];
				name = name + "," + win[1][i];
				id_name = id_name + "," + win[0][i] + "[" + win[1][i] + "]";
			}
		}
	}
	document.getElementById("allocateOrganName").value = name;
	document.getElementById("allocateOrganCode").value = id;
	detailDs.set("allocateOrganName",name);
	detailDs.set("allocateOrganCode",id);
}