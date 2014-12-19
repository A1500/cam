//页面初始化方法
function init() {
	var arr = jtids.split("|");
	var familyIds=addFamilyIds(arr);
	esureyFamilyDS.baseParams["family_id@in@String"]=familyIds;	
	esureyFamilyDS.load();	
	//加载本单位对应的十个外部单位的信息
	var organConfigDS=L5.DatasetMgr.lookup("organConfigDS");
	organConfigDS.setParameter("organ_Id",organId);
	organConfigDS.setParameter("organ_Id",organId);
	organConfigDS.load();
	organConfigDS.on('load',getExtOrganId);
	var familyGridPanel = L5.getCmp("familyGridPanel");
	//familyGridPanel.on("rowclick", familyGridPanel);
	//事件点击单元格时显示审核
	familyGridPanel.on("cellclick", OnRowMemberGridPanel);
	//事件点击列名时该列全部显示为审核
	familyGridPanel.on("headerclick", OnColMemberGridPanel);
}
//选中取消标识
var colCheckFlags=new Array(2,2,2,2,2,2,2,2,2,2);
//某一列点击选中/取消
function OnColMemberGridPanel(grid, columnIndex,e){
   if(columnIndex>3){
	    var sm = grid.getSelectionModel();
		var cell = sm.getSelections();
		if(colCheckFlags[columnIndex-4]%2==0){
			switch(columnIndex){
				case 4:setColCheck(cell,"externalSocialOrg",0);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 5: setColCheck(cell,"externalHouseOrg",0);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 6:	setColCheck(cell,"externalBusinessOrg",0);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
			 	case 7:	setColCheck(cell,"externalCarOrg",0);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 8: setColCheck(cell,"externalTaxGOrg",0);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 9: setColCheck(cell,"externalTaxDOrg",0);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 10:setColCheck(cell,"externalFundOrg",0);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 11: setColCheck(cell,"externalBankOrg",0);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
			 	case 12:setColCheck(cell,"externalSecuritiesOrg",0);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
			 	case 13:setColCheck(cell,"externalInsuranceOrg",0);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
			}
		}else{
			switch(columnIndex){
				case 4:setColCheck(cell,"externalSocialOrg",1);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 5: setColCheck(cell,"externalHouseOrg",1);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 6:	setColCheck(cell,"externalBusinessOrg",1);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
			 	case 7:	setColCheck(cell,"externalCarOrg",1);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 8: setColCheck(cell,"externalTaxGOrg",1);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 9: setColCheck(cell,"externalTaxDOrg",1);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 10:setColCheck(cell,"externalFundOrg",1);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 11:setColCheck(cell,"externalBankOrg",1);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
			 	case 12:setColCheck(cell,"externalSecuritiesOrg",1);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
			 	case 13:setColCheck(cell,"externalInsuranceOrg",1);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
			}
		}
		
   }
}
function setColCheck(cell,cellField,flg){
	for(i=0;i<cell.length;i++){
		cell[i].set(cellField,flg);
	}
}
//单元格选中取消标志
var cellCheckFlag=1;
//单元格点击选中/取消
function OnRowMemberGridPanel(grid, rowIndex, columnIndex, e){
	if(columnIndex<=3){
		var fds = L5.DatasetMgr.lookup("esureyFamilyDS");
		var fRec = fds.getAt(rowIndex);
		var familyId = fRec.get("familyId");
		esureyPeopleDS.setParameter("family_Id", familyId);
		esureyPeopleDS.load();
	}
   if(columnIndex>3){
	    var sm = grid.getSelectionModel();
		var cell = sm.getSelections();
		if(cell.length==0){
			L5.Msg.alert('提示','请选中您要改变的行！');
			return;
		}
		var flg;
		switch(columnIndex){
			case 4:flg=isChecked(cell[0],"externalSocialOrg");cell[0].set("externalSocialOrg",flg);break;
			case 5: flg=isChecked(cell[0],"externalHouseOrg");cell[0].set("externalHouseOrg",flg);break;
			case 6:	flg=isChecked(cell[0],"externalBusinessOrg");cell[0].set("externalBusinessOrg",flg);break;
		 	case 7:	flg=isChecked(cell[0],"externalCarOrg");cell[0].set("externalCarOrg",flg);break;
			case 8: flg=isChecked(cell[0],"externalTaxGOrg");cell[0].set("externalTaxGOrg",flg);break;
			case 9: flg=isChecked(cell[0],"externalTaxDOrg");cell[0].set("externalTaxDOrg",flg);break;
			case 10: flg=isChecked(cell[0],"externalFundOrg");cell[0].set("externalFundOrg",flg);break;
			case 11: flg=isChecked(cell[0],"externalBankOrg");cell[0].set("externalBankOrg",flg);break;
		 	case 12:flg=isChecked(cell[0],"externalSecuritiesOrg");cell[0].set("externalSecuritiesOrg",flg);break;
		 	case 13:flg=isChecked(cell[0],"externalInsuranceOrg");cell[0].set("externalInsuranceOrg",flg);break;
		}
   }
}
//判断本单元格是否被选中
function isChecked(cell,cellField){
	var cellValue=cell.get(cellField);
	if(cellValue!=0||cellValue==""){
		return 0;
	}else{
		return 1;
	}
}

var extSocialId;
var extHouseId;
var extBusinessId;
var extCarId;
var extTaxGId;
var extTaxDId;
var extFundId;
var extBankId;
var extSecuritiesId;
var extInsuranceId;
//organConfigDS的load事件，加载外部单位ID
function getExtOrganId(organConfigDS){
	var records=organConfigDS.getAllRecords();
	for(i=0;i<records.length;i++){
		if(records[i].get("extOrganType")==01){
			extSocialId=records[i].get("extOrganId");
		}else if(records[i].get("extOrganType")==02){
			extHouseId=records[i].get("extOrganId");
		}else if(records[i].get("extOrganType")==03){
			extBusinessId=records[i].get("extOrganId");
		}else if(records[i].get("extOrganType")==04){
			extCarId=records[i].get("extOrganId");
		}else if(records[i].get("extOrganType")==05){
			extTaxGId=records[i].get("extOrganId");
		}else if(records[i].get("extOrganType")==06){
			extTaxDId=records[i].get("extOrganId");
		}else if(records[i].get("extOrganType")==07){
			extFundId=records[i].get("extOrganId");
		}else if(records[i].get("extOrganType")==08){
			extBankId=records[i].get("extOrganId");
		}else if(records[i].get("extOrganType")==09){
			extSecuritiesId=records[i].get("extOrganId");
		}else if(records[i].get("extOrganType")==10){
			extInsuranceId=records[i].get("extOrganId");
		}
	}
}
//当双击家庭信息时，在右侧显示其成员
function onSbjtxxGridPanel(g, rowIdx, r) {
	var fds = L5.DatasetMgr.lookup("esureyFamilyDS");
	var fRec = fds.getAt(rowIdx);
	var familyId = fRec.get("familyId");
	esureyPeopleDS.setParameter("family_Id", familyId);
	esureyPeopleDS.load();
}
//查看详细信息
function details() {
	var grid=L5.getCmp('sbjtxxGridPanel');
	var cell=grid.getSelectionModel().getSelections();
	if(cell.length!=1){
		L5.Msg.alert("提示","请选择一条记录查看!");
		return false;
	}
	
	L5.Msg.alert("提示","你选择的家庭ID是" + cell[0].get("jtid"));
}

//进行核对分发
function checkIssue() {
	L5.MessageBox.confirm('确认','确定要进行核对分发？',
		function(sta){
			if(sta=="yes"){
				var arr = jtids.split("|");
				//得到选中的记录
				//var grid=L5.getCmp('sbjtxxGridPanel');
				//var selected=grid.getSelectionModel().getSelections();
			//	var ids = "";
				var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureySurveyCmd"); 
				var peoCommand=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFeedbackCmd"); 
				for(var i=0; i < arr.length; i++) {
					var record=esureySurveyDS.newRecord();
					record.set("familyId",arr[i]);
					record.set("surveyOrg",surveyOrg);
					record.set("regId",regId);
					command.setParameter("record",record);
					command.execute("insert");
					//根据家庭ID数组将家庭成员（包括赡养信息）存入经济核对_外部单位填报信息表中
					insertInToFeedbace(arr);
				}
			//	ids = ids.substring(0, ids.length - 1);
				
				
				
			//	var mainPanel = L5.getCmp("mainPanel");
			//	mainPanel.hide();
				
			//	var subPanel = L5.getCmp("subPanel");
			//	subPanel.show();
				
				L5.Msg.alert('提示','家庭成员核对信息已存储！');
			}
		});
}
//根据家庭ID数组将家庭成员（包括赡养信息）存入经济核对_外部单位填报信息表中
function insertInToFeedbace(arr){
	var familyIds=addFamilyIds(arr);
	//esureyRelationDS
}
//根据
function insertByFamilyId(familyId){
	esureyPeopleFeedDS.setParameter("family_Id",familyId);
	esureyPeopleFeedDS.load();
	esureyPeopleFeedDS.on('load',insertInTo);
}
function insertInTo(esureyPeopleFeedDS){
	if(esureyPeopleFeedDS.getCount()!=0){
		var records=esureyPeopleFeedDS.getAllRecords();
	}
}
//将家庭ID数组拼接成用逗号隔开的字符串
function addFamilyIds(arr){
	var familyIds="";
	if(arr.length>1){
		familyIds=arr[0];
		for(var i = 1; i < arr.length; i++) {
			familyIds=familyIds+","+arr[i];
		}
	}else {
		familyIds=arr[0];
	}
	return familyIds;
}
//根据家庭Id得到其赡养家庭的Ids
function getSupportFamilyIds(familyId){
	esureyRelationDS.setParameter("FAMILY_ID",familyId);
	esureyRelationDS.load();
}







//返回至查询页面
function returnQuery() {
	var url='jsp/cams/drel/esurey/internal/esureyInfoCheckIssueQuery.jsp';
	var text = '查询家庭信息';
	L5.forward(url,text);
}