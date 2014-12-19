var applyType="007";
function init() {
	if(method=="INSERT"){
		somOrganDataSet.newRecord();		
		somApplyDataSet.newRecord({"taskCode":taskCode,"dataSource":"MEND","sorgType":"S","acceptOpinionId":"1","examinOpinionId":"1","checkOpinionId":"1","auditOpinionId":"1"});
	}else{
		somOrganDataSet.setParameter("SORG_ID",sorgId);
		somOrganDataSet.load();
		somApplyDataSet.setParameter("TASK_CODE", taskCode);
		somApplyDataSet.load();
		//加载电子档案
		somElectronicDataSet_load();
	}
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});	
	L5.QuickTips.init();
}
//根据登记证号加载社会组织信息
function loadSorg(){
	if(method=="INSERT"){
		if(""!=_$("sorgCode")){
			somOrganDataSet.setParameter("SORG_CODE",_$("sorgCode"));
			somOrganDataSet.setParameter("SORG_TYPE","S");
			somOrganDataSet.setParameter("IF_BRANCH","1");
			somOrganDataSet.load();
			somOrganDataSet.on("load",function(){
				if(somOrganDataSet.getCount()<1){
					somOrganDataSet.removeAll();
					somOrganDataSet.newRecord();
					L5.Msg.alert("提示","登记证号不存在!");
					return;
				}else{
					sorgId=somOrganDataSet.get('sorgId');
					//加载电子档案
					somElectronicDataSet_load();
				}	
			});	
		}
	}	
}
function loadCancelReasonDesc(){
	if(_$("cancelReason") == "4"){
		$("cancelReasonDescTr").style.display = "block";
	}else{
		$("cancelReasonDescTr").style.display = "none";
	}
}
//保存
function save(){
	var somOrganRd = somOrganDataSet.getCurrent();	
	var somApplyRd = somApplyDataSet.getCurrent();
	var somOrganDataSetIsValidate = somOrganDataSet.isValidate();
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	//校验社会组织信息
	if(somOrganDataSetIsValidate!=true){
		L5.Msg.alert("提示",somOrganDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}
	//校验业务意见
	if(somApplyDataSetIsValidate!=true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("2");
		return;
	}	
	
	/*var somOrganQueryDataSet = L5.DatasetMgr.lookup("somOrganQueryDataSet");
	somOrganQueryDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganQueryDataSet.on("load",function(ds){
		var sorgStatus = ds.get("sorgStatus");
		if(method=="INSERT"){
			if(sorgStatus!="22"){
				L5.Msg.alert("提示","社会团体分支（代表）机构不是已成立状态，不能进行注销操作！",function(){
					goBack();
				});
				return;
			}
		}else{
			if(sorgStatus!="32"){
				L5.Msg.alert("提示","社会团体分支（代表）机构不是已注销状态，不能进行修改操作！",function(){
					goBack();
				});
				return;
			}
		}
	
		//查看社会组织主体状态
		/*command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchCancelCmd");
		command.setParameter("sorgId",mainSorgId);
		command.setParameter("ifBranch","0");
		command.execute("querySorgStatus");
		var mainSorgStatus = command.getReturn("sorgStatus");
		if(mainSorgStatus!="22"){
			L5.Msg.alert("提示","社会团体主体机构不是已成立状态，不能进行注销操作！",function(){
				goBack();
			});
			return;
		}
	});//
		*/
	
	var command = new L5.Command("com.inspur.cams.sorg.history.group.cmd.SomGroupHistoryCmd");
	//提交保存
	command.setParameter("somOrganRd",somOrganRd);
	command.setParameter("somApplyRd",somApplyRd);
	if(method=="INSERT"){
		command.execute("saveBranchCancel");
	}else if(method=="UPDATE"){
		command.execute("updateBranchCancel");
	}
	if(!command.error){	
		L5.Msg.alert("提示","保存成功！",function(){
			//goBack();
			method="UPDATE";
			somOrganDataSet.setParameter("SORG_ID",sorgId);
			somOrganDataSet.load();
			somApplyDataSet.setParameter("TASK_CODE", taskCode);
			somApplyDataSet.load();
			//加载电子档案
			somElectronicDataSet_load();
		});
	}else{
		L5.Msg.alert("错误","保存时出现错误！"+command.error);	
	}
}
//返回
function goBack(){
	if(method=="UPDATE"){
		var data=new L5.Map();
		data.put("searchCnName",encodeURIComponent(encodeURIComponent(document.getElementById('cnName').innerHTML)));
		data.put("searchSorgCode",_$("sorgCode"));	
		url="jsp/cams/sorg/history/group/branchCancel/groupBranchHistoryCancelList.jsp";
		L5.forward(url,'',data);
	}else{
		history.go(-1);
	}
}

//点击增加上传附件按钮
function clickUploadFile(){
	uploadFile();
}