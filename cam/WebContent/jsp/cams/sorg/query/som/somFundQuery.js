	var fileCodeL="J064";//理事
	var fileCodeS="";//监事
	var taskCode="";
//初始化
	function init(){
		var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
		somOrganDataSet.setParameter("SORG_ID@=",sorgId);
		somOrganDataSet.load();
		somOrganDataSet.on("load",function(ds){
			if(ds.getCount()<1){
				ds.newRecord();
			}else{
				var rec=ds.getAt(0);
				var borgName = rec.get('borgName');
				var nowBorgName = getBorgName(borgName);
				rec.set('nowBorgName', nowBorgName);
			}
		});

		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.setParameter("SORG_ID@=",sorgId);
		somSessionDataSet.load();
		L5.getCmp("sessionGrid").on("rowclick",function(grid,rowIndex,e){
			var record=grid.getSelectionModel().getSelected();
			if(record){
				aspForJianShi.setParameter("SESSION_ID",record.get('sessionId'));
				aspForJianShi.load();
				
				aspForLiShi.setParameter("SESSION_ID", record.get('sessionId'));
				aspForLiShi.load();
			}
		});
		aspForLiShi.on('load',function(){
			aspForLiShi.filterBy(function(record, id){
				if("00001,00003,00004,00005,00013".indexOf(record.get('sorgDuties'))>-1){
					return record;
				}
			});
		});
		aspForJianShi.on('load',function(){
			aspForJianShi.filterBy(function(record, id){
				if("00006".indexOf( record.get('sorgDuties') ) > -1){
					return record;
				}
			});
		});
		var AccountDS=L5.DatasetMgr.lookup("AccountDS");
		AccountDS.setParameter("SORG_ID@=",sorgId);
		AccountDS.load();
		var somOfficeDataSet=L5.DatasetMgr.lookup("somOfficeDataSet");
		somOfficeDataSet.setParameter("SORG_ID@=",sorgId);
		somOfficeDataSet.load();
		var EntityDS=L5.DatasetMgr.lookup("EntityDS");
		EntityDS.setParameter("SORG_ID@=",sorgId);
		EntityDS.load();
		somCertDatasetZ.setParameter("SORG_ID@=",sorgId);
		somCertDatasetZ.load();
		somCertDatasetZ.on('load',function (){
			if(somCertDatasetZ.getCount() == 0){
				somCertDatasetZ.newRecord();
			}
		});
		somCertDatasetF.setParameter("SORG_ID@=",sorgId);
		somCertDatasetF.load();
		somCertDatasetF.on('load',function (){
			if(somCertDatasetF.getCount() == 0){
				somCertDatasetF.newRecord();
			}
		});
	}
	
function detailPeople(){
	var grid=L5.getCmp("peopleGrid");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.getCmp("peopleWin").show();
	var birthday=record.get("birthday");
	showAge(birthday);
}
function showAge(birthday){
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}

function closePeople(){
	var win=L5.getCmp("peopleWin");
	win.setVisible(false);
}
function detailAccount(){
	var grid=L5.getCmp("accountgrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("id",records[0].get("id"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(somOrganDataSet.get("cnName"))));
	data.put("sorgCode",somOrganDataSet.get("sorgCode"));
	var url="jsp/cams/sorg/manage/fund/fundAccountDetail.jsp";
	L5.forward(url,'',data);
}
function detailOffice(){
	var grid=L5.getCmp("officegrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("id",records[0].get("id"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(somOrganDataSet.get("cnName"))));
	data.put("sorgCode",somOrganDataSet.get("sorgCode"));
	var url="jsp/cams/sorg/manage/fund/fundOfficeDetail.jsp";
	L5.forward(url,'',data);
}
function detailEntity(){
	var grid=L5.getCmp("entitygrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("id",records[0].get("id"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(somOrganDataSet.get("cnName"))));
	data.put("sorgCode",somOrganDataSet.get("sorgCode"));
	var url="jsp/cams/sorg/manage/fund/fundEntityDetail.jsp";
	L5.forward(url,'',data);
}
function detailRule(){
	var grid=L5.getCmp("rulegrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("ruleId",records[0].get("ruleId"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(somOrganDataSet.get("cnName"))));
	data.put("sorgCode",somOrganDataSet.get("sorgCode"));
	var url="jsp/cams/sorg/manage/fund/fundRuleDetail.jsp";
	L5.forward(url,'',data);
}
function returnQueryList(){
	window.history.go(-1);
}
function countRenderS(value){
	if(value === undefined){
		value=0;
	}
	return "监事总人数: "+value+" 人";

}
function countRender(value){
	if(value === undefined){
		value=0;
	}
	return "理事总人数: "+value+" 人";

}
// 查看负责人明细
function detailL(){
	peopleType="L";
	var grid=L5.getCmp("peopleGrid");
	var currentRecord=grid.getSelectionModel().getSelected();
	if(!currentRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	somDutyDataSet.removeAll();
	somDutyDataSet.insert(0,currentRecord.copy());
	somResumeInsertDataSet.removeAll();
	somResumeInsertDataSet.setParameter("DUTY_ID",currentRecord.get('dutyId'));
	somResumeInsertDataSet.load();
	L5.getCmp("peopleWin").show();
	showAge();
	synPhotoDetail(somDutyDataSet.get("photoId"),"1");//同步照片
	taskCode=currentRecord.get('taskCode');
	somPeopleElectronicDataSet_load(fileCodeL,currentRecord.get('dutyId'));//同步法律要件
}
// 查看负责人明细
function detailS(){
	peopleType="S";
	var grid=L5.getCmp("peopleGrid1");
	var currentRecord=grid.getSelectionModel().getSelected();
	if(!currentRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	somDutyDataSet.removeAll();
	somDutyDataSet.insert(0,currentRecord.copy());
	somResumeInsertDataSet.removeAll();
	somResumeInsertDataSet.setParameter("DUTY_ID",currentRecord.get('dutyId'));
	somResumeInsertDataSet.load();
	L5.getCmp("peopleWin").show();
	showAge();
	synPhotoDetail(somDutyDataSet.get("photoId"),"1");//同步照片
	somPeopleElectronicDataSet.removeAll();//同步法律要件
}
/** *查询信息* **/
function getBorgName(borgCode){
	var publicCmd = new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgChangeCmd");
	publicCmd.setParameter("borgCode", borgCode);
	publicCmd.execute("nowBorgName");
	var getReturns = publicCmd.getReturn("borgName");
	if (getReturns == null || getReturns == "" || getReturns == undefined){
		return "";
	}else {
		return getReturns;
	}
}