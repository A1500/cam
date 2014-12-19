//页面初始化方法
function init(){
	var esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
	esureyFamilyDS.baseParams["family_id@in@String"]=jtids;	
	esureyFamilyDS.load();
	var esureyPeopleDS=L5.DatasetMgr.lookup("esureyPeopleDS");
	esureyPeopleDS.setParameter('FAMILY_ID','0');
	esureyPeopleDS.load();
	var esureyRelPeopleDS=L5.DatasetMgr.lookup("esureyRelPeopleDS");
	esureyRelPeopleDS.setParameter('FAMILY_ID','0');
	esureyRelPeopleDS.load();
	//加载本单位对应的十个外部单位的信息
	var organConfigDS=L5.DatasetMgr.lookup("organConfigDS");
	organConfigDS.setParameter("ORGAN_ID",organId);
	organConfigDS.load();
	organConfigDS.on('load',getExtOrganId);
	//editGridPannel单击事件
	var sbjtxxGridPanel = L5.getCmp("sbjtxxGridPanel");
	sbjtxxGridPanel.on("rowclick", onSbjtxxGridPanel);
	var memberGridPanel = L5.getCmp("memberGridPanel");
	var memberRelGridPanel = L5.getCmp("memberRelGridPanel");
	//事件点击单元格时显示审核
	memberGridPanel.on("cellclick", OnRowMemberGridPanel);
	memberRelGridPanel.on("cellclick", OnRowMemberGridPanel);
	//事件点击列名时该列全部显示为审核
	memberGridPanel.on("headerclick", OnColMemberGridPanel);
	memberRelGridPanel.on("headerclick", OnColMemberGridPanel);
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
		}else{
			switch(columnIndex){
				case 4:setColCheck(cell,"externalSocialOrg",2);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 5: setColCheck(cell,"externalHouseOrg",2);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 6:	setColCheck(cell,"externalBusinessOrg",2);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
			 	case 7:	setColCheck(cell,"externalCarOrg",2);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 8: setColCheck(cell,"externalTaxGOrg",2);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 9: setColCheck(cell,"externalTaxDOrg",2);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 10:setColCheck(cell,"externalFundOrg",2);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
				case 11:setColCheck(cell,"externalBankOrg",2);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
			 	case 12:setColCheck(cell,"externalSecuritiesOrg",2);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
			 	case 13:setColCheck(cell,"externalInsuranceOrg",2);colCheckFlags[columnIndex-4]=colCheckFlags[columnIndex-4]+1;break;
			}
		}
		
   }
}
//给界面赋值
function setColCheck(cell,cellField,flg){
	for(i=0;i<cell.length;i++){
		cell[i].set(cellField,flg);
	}
}
//单元格选中取消标志
var cellCheckFlag=1;
//单元格点击选中/取消
function OnRowMemberGridPanel(grid, rowIndex, columnIndex, e){
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
	if(cellValue!=1||cellValue==""){
		return 1;
	}else{
		return 2;
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
	var messages="";
	var messFlags=new Array(0,0,0,0,0,0,0,0,0,0,0);
	for(i=0;i<records.length;i++){
		//01人力资源和社会保障
		//02房管局
		//03工商局
		//04（公安）车管
		//05国税局
		//06地税局
		//07公积金
		//08人民银行
		//09证监
		//10保监
		
		if(records[i].get("extOrganType")==01){
			extSocialId=records[i].get("extOrganId");
			if(!(extSocialId==''||extSocialId=='null')){
				messFlags[0]=1;
			}
		}else if(records[i].get("extOrganType")==02){
			extHouseId=records[i].get("extOrganId");
			if(!(extHouseId==''||extHouseId=='null')){
				messFlags[1]=1;
			}
		}else if(records[i].get("extOrganType")==03){
			extBusinessId=records[i].get("extOrganId");
			if(!(extBusinessId==''||extBusinessId=='null')){
				messFlags[2]=1;
			}
		}else if(records[i].get("extOrganType")==04){
			extCarId=records[i].get("extOrganId");
			if(!(extCarId==''||extCarId=='null')){
				messFlags[3]=1;
			}
		}else if(records[i].get("extOrganType")==05){
			extTaxGId=records[i].get("extOrganId");
			if(!(extTaxGId==''||extTaxGId=='null')){
				messFlags[4]=1;
			}
		}else if(records[i].get("extOrganType")==06){
			extTaxDId=records[i].get("extOrganId");
			if(!(extTaxDId==''||extTaxDId=='null')){
				messFlags[5]=1;
			}
		}else if(records[i].get("extOrganType")==07){
			extFundId=records[i].get("extOrganId");
			if(!(extFundId==''||extFundId=='null')){
				messFlags[6]=1;
			}
		}else if(records[i].get("extOrganType")==08){
			extBankId=records[i].get("extOrganId");
			if(!(extBankId==''||extBankId=='null')){
				messFlags[7]=1;
			}
		}else if(records[i].get("extOrganType")==09){
			extSecuritiesId=records[i].get("extOrganId");
			if(!(extSecuritiesId==''||extSecuritiesId=='null')){
				messFlags[8]=1;
			}
		}else if(records[i].get("extOrganType")==10){
			extInsuranceId=records[i].get("extOrganId");
			if(!(extInsuranceId==''||extInsuranceId=='null')){
				messFlags[9]=1;
			}
		}
	}
	
	for(var i=0;i<messFlags.length;i++){
		switch(i)
		   {
		   case 0:if(messFlags[0]==0){messages+="人力资源和社会保障、"} break;
		   case 1:if(messFlags[1]==0){messages+="房管局、"} break;
		   case 2:if(messFlags[2]==0){messages+="工商局、"} break;
		   case 3:if(messFlags[3]==0){messages+="（公安）车管、"} break;
		   case 4:if(messFlags[4]==0){messages+="国税局、"} break;
		   case 5:if(messFlags[5]==0){messages+="地税局、"} break;
		   case 6:if(messFlags[6]==0){messages+="公积金、"} break;
		   case 7:if(messFlags[7]==0){messages+="人民银行、"} break;
		   case 8:if(messFlags[8]==0){messages+="证监、"} break;
		   case 9:if(messFlags[9]==0){messages+="保监、"} break;
		   }
		}
		if(messages!=""){
			L5.Msg.alert("提示",messages.substring(0,messages.length-1)+"还没进行配置，请及时配置！",function(){
//				var url='jsp/cams/drel/esurey/internal/esureyOrganConfig.jsp';
//				L5.forward(url);
			});
		}
	}
var familyRecord;
var removeIdx;
//当双击家庭信息时，在右侧显示其成员
function onSbjtxxGridPanel(g, rowIdx, r) {
	removeIdx=rowIdx;
	var esureyFamilyDS = L5.DatasetMgr.lookup("esureyFamilyDS");
	familyRecord = esureyFamilyDS.getAt(rowIdx);
	var familyId = familyRecord.get("familyId");
	var esureyPeopleDS=L5.DatasetMgr.lookup("esureyPeopleDS");
	esureyPeopleDS.setParameter("FAMILY_ID", familyId);
	esureyPeopleDS.load();
	esureyPeopleDS.on("load",changeMessExt);
	var esureyRelationDS = L5.DatasetMgr.lookup("esureyRelationDS");
	esureyRelationDS.setParameter("FAMILY_ID", familyId);
	esureyRelationDS.load();
	esureyRelationDS.on('load',getRelFamilyMsg);
}
function changeMessExt(esureyPeopleDS){
	var Num=esureyPeopleDS.getCount();
	var peoRecords=esureyPeopleDS.getAllRecords();
	if(Num==0){
		return;
	}else{
		for(i=0;i<Num;i++){
		var peoRecord=peoRecords[i];
		peoRecord.set("externalSocialOrg","");
		peoRecord.set("externalHouseOrg","");
		peoRecord.set("externalBusinessOrg","");
		peoRecord.set("externalCarOrg","");
		peoRecord.set("externalTaxGOrg","");
		peoRecord.set("externalTaxDOrg","");
		peoRecord.set("externalFundOrg","");
		peoRecord.set("externalBankOrg","");
		peoRecord.set("externalSecuritiesOrg","");
		peoRecord.set("externalInsuranceOrg","");
		}
	}
}
//加载赡养家庭人员信息
function getRelFamilyMsg(esureyRelationDS){
	if(esureyRelationDS.getCount()==0){
		var esureyRelPeopleDS=L5.DatasetMgr.lookup("esureyRelPeopleDS");
		esureyRelPeopleDS.setParameter('FAMILY_ID','0');
		esureyRelPeopleDS.load();
	}else if(esureyRelationDS.getCount()!=0){
		var records=esureyRelationDS.getAllRecords();
		var relFamilyIds=records[0].get("supportFamilyId");
		if(records.length>1){
			for(i=1;i<records.length;i++){
				relFamilyIds=relFamilyIds+","+records[i].get("supportFamilyId");
			}
		}
		if(relFamilyIds){
			var esureyRelPeopleDS = L5.DatasetMgr.lookup("esureyRelPeopleDS");
			esureyRelPeopleDS.baseParams["family_id@in@String"]=relFamilyIds;
			esureyRelPeopleDS.load();
			esureyRelPeopleDS.on("load",changeRelMess);
		}
	}
}
function changeRelMess(esureyRelPeopleDS){
 var RelNum=esureyRelPeopleDS.getCount();
 if(RelNum==0){
 	return;
 }else if(RelNum!=0){
 	var relPeoRecords=esureyRelPeopleDS.getAllRecords();
 	for(var n=0;n<RelNum;n++){
 		var relPeoRecord=relPeoRecords[n];
 		relPeoRecord.set("externalSocialOrg","");
		relPeoRecord.set("externalHouseOrg","");
		relPeoRecord.set("externalBusinessOrg","");
		relPeoRecord.set("externalCarOrg","");
		relPeoRecord.set("externalTaxGOrg","");
		relPeoRecord.set("externalTaxDOrg","");
		relPeoRecord.set("externalFundOrg","");
		relPeoRecord.set("externalBankOrg","");
		relPeoRecord.set("externalSecuritiesOrg","");
		relPeoRecord.set("externalInsuranceOrg","");
 	}
 }
}
//核对流水ID
var surveyId;
//家庭成员
var records;
//赡养家庭成员
var relPeopleRecords;
//核对分发方法
function checkIssue(){
	var esureyPeopleDS=L5.DatasetMgr.lookup("esureyPeopleDS");
	records = esureyPeopleDS.getAllChangedRecords();
	var esureyRelPeopleDS=L5.DatasetMgr.lookup("esureyRelPeopleDS");
	relPeopleRecords= esureyRelPeopleDS.getAllChangedRecords();
	if(records.length==0&&relPeopleRecords.length==0){
		L5.Msg.alert('提示','请选择要核对分发的家庭、成员及相应的外部单位！');
		return;
	}
	var arrNum=records.length;
	var arrNumR=relPeopleRecords.length;
	var isMess="";
	for(var i=0;i<arrNum;i++ ){
		var externalSocialOrg=records[i].get("externalSocialOrg");
		var externalHouseOrg=records[i].get("externalHouseOrg");
		var externalBusinessOrg=records[i].get("externalBusinessOrg");
		var externalCarOrg=records[i].get("externalCarOrg");
		var externalTaxGOrg=records[i].get("externalTaxGOrg");
		var externalTaxDOrg=records[i].get("externalTaxDOrg");
		var externalFundOrg=records[i].get("externalFundOrg");
		var externalBankOrg=records[i].get("externalBankOrg");
		var externalSecuritiesOrg=records[i].get("externalSecuritiesOrg");
		var externalInsuranceOrg=records[i].get("externalInsuranceOrg");
		if(externalSocialOrg!=1&&externalHouseOrg!=1&&externalBusinessOrg!=1&&externalCarOrg!=1&&externalTaxGOrg!=1&&externalTaxDOrg!=1&&externalFundOrg!=1&&externalBankOrg!=1&&externalSecuritiesOrg!=1&&externalInsuranceOrg!=1){
			isMess="1";
		}
	}
	for(var i=0;i<arrNumR;i++ ){
		var externalSocialOrg2=relPeopleRecords[i].get("externalSocialOrg");
		var externalHouseOrg2=relPeopleRecords[i].get("externalHouseOrg");
		var externalBusinessOrg2=relPeopleRecords[i].get("externalBusinessOrg");
		var externalCarOrg2=relPeopleRecords[i].get("externalCarOrg");
		var externalTaxGOrg2=relPeopleRecords[i].get("externalTaxGOrg");
		var externalTaxDOrg2=relPeopleRecords[i].get("externalTaxDOrg");
		var externalFundOrg2=relPeopleRecords[i].get("externalFundOrg");
		var externalBankOrg2=relPeopleRecords[i].get("externalBankOrg");
		var externalSecuritiesOrg2=relPeopleRecords[i].get("externalSecuritiesOrg");
		var externalInsuranceOrg2=relPeopleRecords[i].get("externalInsuranceOrg");
		if(externalSocialOrg2!=1&&externalHouseOrg2!=1&&externalBusinessOrg2!=1&&externalCarOrg2!=1&&externalTaxGOrg2!=1&&externalTaxDOrg2!=1&&externalFundOrg2!=1&&externalBankOrg2!=1&&externalSecuritiesOrg2!=1&&externalInsuranceOrg2!=1){
			isMess+="1";
		}
	}
	if(isMess.length!=0){
		L5.Msg.alert("提示","请选择要分发的外部单位！");
		return;
	}
	//经济核对_核对流水插入
	var esureySurveyDS=L5.DatasetMgr.lookup("esureySurveyDS");
	var record=esureySurveyDS.newRecord();
	record.set("familyId",records[0].get("familyId"));
	record.set("surveyOrg",organId);
	record.set("regId",regId);
	
	var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureySurveyCmd");
	command.setParameter("record",record);
	if(records.length!=0){
		command.setParameter("peoRecords",records);
	}else{
		command.setParameter("peoFlag","peoNull");
	}
	if(relPeopleRecords.length!=0){
		command.setParameter("relPeoRecords",relPeopleRecords);
	}else{
		command.setParameter("relPeoFlag","relPeoNull");
	}
	command.setParameter("organId",organId);
	command.execute("insert");
	if (!command.error) {
		L5.Msg.alert('提示',"核对分发成功!",function(){
			var familyIds="";
			var arr=jtids.split(",");
			for(var i=0;i<arr.length;i++){
				if(arr[i]==records[0].get("familyId")){
					arr.splice(i,1);
				}
			}
			if(arr.length!=0){
				for(var i=0;i<arr.length;i++){
					familyIds+=arr[i]+",";
				}
				jtids=familyIds.substring(0,familyIds.length-1);
				init();
			}else{
				var url="jsp/cams/drel/esurey/internal/esureyInfoCheckIssueQuery.jsp";	
				L5.forward(url);		
			}
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
	
}
















