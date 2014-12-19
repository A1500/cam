var STMenuInfoDs = [['000','社会团体申请名称核准'],['001','社会团体筹备成立'],['002','社会团体成立登记'],['003','社会团体变更登记'],['004','社会团体注销登记'],['005','社会团体分支（代表）机构设立登记'],['006','社会团体分支（代表）机构变更登记'],['007','社会团体分支（代表）机构注销登记'],['014','年检'],['008','社会团体章程核准'],['009','社会团体换届（成立）事先报批'],['032','社会团体延期换届选举报批'],['017','负责人换届备案'],['033','负责人届中备案'],['016','会费标准备案']];
var MFMenuInfoDs = [['100','申请名称核准'],['101','民办非企业单位成立登记（法人）'],['105','民办非企业单位成立登记（合伙）'],['106','民办非企业单位成立登记（个体）'],['102','民办非企业单位变更登记'],['103','民办非企业单位注销登记'],['108','民办非企业单位章程核准'],['114','年检']];
var JJMenuInfoDs = [['200','基金会申请名称核准'],['201','基金会设立登记'],['202','基金会变更登记'],['203','基金会注销登记'],['204','基金会分支（代表）机构设立登记'],['205','基金会分支（代表）机构变更登记'],['206','基金会分支（代表）机构注销登记'],['208','基金会章程核准'],['209','基金会换届审批'],['234','基金会延期换届选举报批'],['214','年检'],['224','负责人换届备案'],['235','负责人届中备案']];
var initUserId = "";
function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord({"accountStatus":"1","areaCode":areaCode});
		somExtuserMenuds.newRecord();
	}
	else if (method=="UPDATE"){
		ds.baseParams["USER_ID@="]=idField;
		ds.load();
		ds.on("load",function(){
			somExtuserMenuds.baseParams["USER_ID@="]=idField;
			somExtuserMenuds.load();
			somExtuserMenuds.on('load',function(ds){
				$("sorgCode").value = ds.get("sorgCode");
			});
			initUserId =_$("userId");
		});
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init();
	initMenuInfo();
}

function save(){
	var record = ds.getCurrent();
	var menuRecord = somExtuserMenuds.getCurrent();
	if(_$("sorgCode") == ""){
		//L5.Msg.alert('提示',"请输入登记证号!");
		//return;
	}else{
		menuRecord.set("sorgCode",_$("sorgCode"));
	}
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}
	if(checkUserId()){
		L5.Msg.alert('提示',"该用户名已经存在,不能保存!");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.sorg.online.extuser.cmd.SomExtUserCmd");
	command.setParameter("comExtUser",record);
	command.setParameter("menuRecord",menuRecord);
	if(method=="INSERT"){
		command.execute("insert");
	}
	if(method=="UPDATE"){
		command.setParameter("initUserId",initUserId);
		command.execute("update");
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!",function(){
			back();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back()
 {	 	var url='jsp/cams/sorg/online/extUser/onlinecomextuser_list.jsp';
		var text = 'COM_EXT_USER';
		L5.forward(url,text);
 }

function initMenuInfo(){
	new L5.ux.ItemSelector({
		field:"menuInfo",
		applyTo:"menuInfoDiv",
		id:"menuInfo",
		name:"menuInfo",
		dataFields:["value","text"],
		fromData:STMenuInfoDs,
		valueField:"value",
		displayField:"text",
		msWidth:285,
		msHeight:320,
		toLegend:"已选择功能",
		fromLegend:"未选择功能",
		drawUpIcon:true,
		drawDownIcon:true,
		drawTopIcon:true,
		drawBotIcon:true
	});
}

function adsa(){
	var menuInfoDs = [['value', 'text'],["2","2"]];
	L5.getCmp("menuInfo").fromMultiselect.dataset.loadData(menuInfoDs);
}

function organTypeOnChange(organType){
	//L5给dataset赋值时会触发onchangge事件，此时控件还没正常加载，下边取双边栏控件会出错
	if (typeof L5.getCmp("menuInfo") == "undefined") return;
	var menuInfoDs = [];
	if(organType == "ST"){
		menuInfoDs = STMenuInfoDs;
	}
	if(organType == "MF"){
		menuInfoDs = MFMenuInfoDs;
	}
	if(organType == "JJ"){
		menuInfoDs = JJMenuInfoDs;
	}
	//清空选择列表
	L5.getCmp("menuInfo").toMultiselect.dataset.removeAll();
	//somExtuserMenuds.set("menuInfo","");
	//根据organtype加载待选择列表
	L5.getCmp("menuInfo").fromMultiselect.dataset.loadData(menuInfoDs);
}

function checkUserId(){
	//initUserId说明是增加页面的，需要调校验，修改页面的需要判断初始userid不等于最终的userid时才调用校验
	if(initUserId == ""||(initUserId != _$("userId")&&method=="UPDATE")){
		var command=new L5.Command("com.inspur.cams.sorg.online.extuser.cmd.SomExtUserCmd");
		command.setParameter("USER_ID",_$("userId"));
		command.execute("checkUserId");
		status = command.getReturn("status");
		if(status == "true"){
			$("userCheck").style.display="";
			return true;
		}
		$("userCheck").style.display="none";
		return false;
	}
	if(initUserId == _$("userId")){
		$("userCheck").style.display="none";
	}
	return false;
}

function fillSorgCode(name){
	//社会组织名称与用户名相同，直接回填
	var comExtUserDataSet=L5.DatasetMgr.lookup("ds");
	var comExtUserRecord=comExtUserDataSet.getCurrent();
	$("userName").value = name;
	comExtUserRecord.set("userName",name);
	somOrganDataSet.baseParams["CN_NAME@="]=name;
	somOrganDataSet.load();
	somOrganDataSet.on('load',function(ds){
		if(ds.getCount()==0){
		     return;
		}
		$("sorgCode").value = ds.get("sorgCode");
		comExtUserRecord.set("sorgCode",ds.get("sorgCode"));
	});
}

function fillSorgName(sorgCode){
	var comExtUserDataSet=L5.DatasetMgr.lookup("ds");
	var comExtUserRecord=comExtUserDataSet.getCurrent();
	somOrganDataSet.baseParams["SORG_CODE@="]=sorgCode;
	somOrganDataSet.baseParams["SORG_TYPE@="]=$("organType").value.substring(0,1);
	somOrganDataSet.load();
	somOrganDataSet.on('load',function(ds){
		if(ds.getCount()==0){
			L5.Msg.alert('提示',"根据登记证号和社会组织类别没有查询到相应的社会组织，请检查！");
		     return;
		}
		$("userId").value = ds.get("cnName");
		comExtUserRecord.set("userId",ds.get("cnName"));
		$("userName").value = ds.get("cnName");
		comExtUserRecord.set("userName",ds.get("cnName"));
	});
}