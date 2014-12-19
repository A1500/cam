var familyId='';
var familyArchiveId='';
var photoId='';
var applyDate='';
var applyReason='';
var photoId='';
var assistanceMode='';
var assistanceMoney='';
var assistanceClassMoney='';
var assistanceClass='';
function init(){
	applyDataSet.setParameter("APPLY_ID",applyId);
	applyDataSet.load();
	applyDataSet.on("load",function(){
		if(applyDataSet.getCount() == 1){
			applyDate=applyDataSet.get('applyDate');
			applyReason=applyDataSet.get('applyReason');
			assistanceMode=applyDataSet.get('assistanceMode');
			assistanceMoney=applyDataSet.get('assistanceMoney');
			assistanceClassMoney=applyDataSet.get('assistanceClassMoney');
			assistanceClass=applyDataSet.get('asisstanceClass');
			familyId=applyDataSet.get('familyId');
			var supportWay=applyDataSet.get('supportWay');
			$('supportWay').innerHTML=getDicText(supportWayDataset,supportWay);//供养方式
			if(supportWay=='03'){//集中供养
				var supportOrg=applyDataSet.get('supportOrg'); 	
				$('supportOrg').innerHTML=getDicText(supportOrgDataset,supportOrg);//供养机构
			}
			loadAsisstanceClass();
			//当有变更事项字段是，显示变更事项一行，并把“申请理由”改为“变更原因”
			if( applyDataSet.get('changeItem') != '' ){
				document.getElementById("changeTR").style.display = "block";
				document.getElementById("reasonLabel").innerHTML = "变更原因";
				setChangeItemText(applyDataSet.get('changeItem'));
			}
		}
		
	});
    acceptSurveyDataset.on('load',function(){
		if(acceptSurveyDataset.getCount() == 0){
			acceptSurveyDataset.newRecord();
		}
	});
	  acceptDiscussionDataset.on('load',function(){
		if(acceptDiscussionDataset.getCount() == 0){
			acceptDiscussionDataset.newRecord();
		}
	});
	  acceptNoticeDataset.on('load',function(){
		if(acceptNoticeDataset.getCount() == 0){
			acceptNoticeDataset.newRecord();
		}
	});
	
	checkSurveyDataset.on('load',function(){
		if(checkSurveyDataset.getCount() == 0){
			checkSurveyDataset.newRecord({"activityId":"check"});
		}
	});
	
	checkNoticeDataset.on('load',function(){
		if(checkNoticeDataset.getCount() == 0){
			checkNoticeDataset.newRecord({"activityId":"check"});
		}
	});
	auditSurveyDataset.on('load',function(){
		if(auditSurveyDataset.getCount() == 0){
			auditSurveyDataset.newRecord({"activityId":"audit"});
		}
	});
	auditNoticeDataset.on('load',function(){
		if(auditNoticeDataset.getCount() == 0){
			auditNoticeDataset.newRecord({"activityId":"audit"});
		}
	});
	//家庭加载的时候把业务表的相关字段放入家庭表里
	familyDataSet.on('load',function(){
		if(familyDataSet.getCount() == 1){
			familyDataSet.set('applyReason',applyReason);
			familyDataSet.set('applyDate',applyDate);
			familyDataSet.set('assistanceMode',assistanceMode);
			familyDataSet.set('assistanceMoney',assistanceMoney);
			familyDataSet.set('assistanceClassMoney',assistanceClassMoney);
			familyDataSet.set('assistanceClass',assistanceClass);
			
			photoId=familyDataSet.get("photoId");
			showPhotoAbleEdit(photoId);//加载照片
		}
	});
}
//明细页面显示变更事项
function setChangeItemText(changeItems){
	var itemText="";
	for (var i=0;i<samChangeItemDs.getTotalCount();i++){
		var record = samChangeItemDs.getAt(i);
		if(changeItems.indexOf(samChangeItemDs.getAt(i).get('value'))>-1){
			if(""==itemText){
				itemText=samChangeItemDs.getAt(i).get('text');
			} else {
				itemText=itemText+","+samChangeItemDs.getAt(i).get('text');
			}
		}
	}
	document.getElementById("changeItemText").innerText=itemText;
}
function loadAsisstanceClass(){
	//加载分类施保类别字典
	var asisstanceClassDataset = L5.DatasetMgr.lookup("asisstanceClassDataset");
    asisstanceClassDataset.setParameter("filterSql", "ASSISTANCE_TYPE='03' AND IN_USE='1' AND AREA_CODE= '" + organArea.substring(0, 6) + "000000'");
    asisstanceClassDataset.load();
    asisstanceClassDataset.on('load',loadBank);
}
function loadBank(ds){
	ds.un("load",loadBank);
	bankAccountDS.setParameter("FAMILY_ID",familyId);
    bankAccountDS.on("load",loadFamilyDs);
    bankAccountDS.load();
}
//加载家庭信息
function loadFamilyDs(ds){
	if(ds.getCount() == 0 ){
		bankAccountDS.newRecord({"releaseWay":"01","accountStatus":"1","assistanceType":"01"});
	}
	ds.un("load",loadFamilyDs);
    familyDataSet.setParameter("APPLY_ID",applyId);
    familyDataSet.on("load",loadPeopleListDs);
    familyDataSet.load();
}
//加载家庭成员基本信息
function loadPeopleListDs(ds){
	ds.un("load",loadPeopleListDs);
	if(ds.getCount()>0){
		familyArchiveId=ds.get("familyArchiveId");
	}
	peopleListDataSet.setParameter("APPLY_ID",applyId);
    peopleListDataSet.on("load",loadSupportedPeopleDs);
	peopleListDataSet.load();
}
function loadSupportedPeopleDs(ds){
	ds.un("load",loadSupportedPeopleDs);
	var supportedPeopleDataSet = L5.DatasetMgr.lookup("supportedPeopleDataSet");
    supportedPeopleDataSet.setParameter("filterSql", "FAMILY_ARCHIVE_ID='" + familyArchiveId + "'");
    supportedPeopleDataSet.load();
    supportedPeopleDataSet.on("load",loadHouseListDs);
}
function loadHouseListDs(ds){
	ds.un("load",loadHouseListDs);    
	houseListDataset.setParameter("FAMILY_ARCHIVE_ID",familyArchiveId);
	houseListDataset.load();
	houseListDataset.on('load',loadestateListDataset);
}
function loadestateListDataset(ds){
	ds.un("load",loadestateListDataset);
	estateListDataset.setParameter("FAMILY_ARCHIVE_ID",familyArchiveId);
	estateListDataset.load();
	estateListDataset.on('load',loadesupportListDataset);
}
function loadesupportListDataset(ds){
	ds.un("load",loadesupportListDataset);
	supportListDataset.setParameter("FAMILY_ARCHIVE_ID",familyArchiveId);
	supportListDataset.load();
	supportListDataset.on('load',loadefilesDataset);
}
function loadefilesDataset(ds){
	ds.un("load",loadefilesDataset);
	ArchCatalogDS.setParameter("sysType","sam");
	ArchCatalogDS.setParameter("applyId",applyId);
	ArchCatalogDS.load();
	ArchCatalogDS.on("load",loadacceptSurvey);
}
//获取当前时间
	function getCurrent(){
		
		return (new Date()).getTime();
	}
function loadacceptSurvey(ds){
	ds.un("load",loadacceptSurvey);
     ds.filterBy(function(record, id){
		//函数内部执行的操作写在这里
		var  pageSize =record.get("PAGE_SIZE");
		if(pageSize!=""&&parseInt(pageSize)!=0){
			return true ;
		}else{
			return false ;
		}
	});
	acceptSurveyDataset.load();
    acceptSurveyDataset.on("load",loadAcceptDiscussionDs);
}
//加载评议结果
function loadAcceptDiscussionDs(ds){
	ds.un("load",loadAcceptDiscussionDs);
	acceptDiscussionDataset.load();
    acceptDiscussionDataset.on("load",loadAcceptNoticeDs);
}
//加载公告
function loadAcceptNoticeDs(ds){
	ds.un("load",loadAcceptNoticeDs);
	acceptNoticeDataset.load();
 	acceptNoticeDataset.on('load',loadcheckSurvey);
}
function loadcheckSurvey(ds){
	ds.un("load",loadcheckSurvey);
	checkSurveyDataset.load();
	checkSurveyDataset.on("load",loadCheckSurveyNoticeDs);
}
//增加扫描文件
function scanFiles(){
	if(applyId==''||applyId=='null'){
		L5.Msg.alert("提示","数据有误！");
		return;
	}
	var width = screen.width-600;
    var height = screen.height-600;
    
    var url="../../../comm/arch/archUploadfileDetail.jsp?applyId="+applyId+"&sysType=sam&hrefFlg="+getCurrent();
    
	window.showModalDialog(url, window, "scroll:1;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//加载审核公告
function loadCheckSurveyNoticeDs(ds){
	ds.un("load",loadCheckSurveyNoticeDs);
	checkNoticeDataset.load();
	checkNoticeDataset.on("load",loadauditSurvey);
}
function loadauditSurvey(ds){
	ds.un("load",loadauditSurvey);
	auditSurveyDataset.load();
	auditSurveyDataset.on('load',loadAuditNoticeDs);
}
//加载审批公告
function loadAuditNoticeDs(ds){
	ds.un("load",loadAuditNoticeDs);
	auditNoticeDataset.load();
	auditNoticeDataset.on('load',loadAuditNotice);
}
//加载救助开始月份或者救助截止月份
function loadAuditNotice(ds){		
	ds.un("load",loadAuditNotice);
	if(applyDataSet.get("auditOpinionId") == '1'&& applyDataSet.get("changeItem") != '03'){
		document.getElementById('beginDateSL').style.display="block";
		document.getElementById('beginDateL').style.display="none";
	} else if(applyDataSet.get("auditOpinionId") == '1'&& applyDataSet.get("changeItem") == '03'){
		document.getElementById('beginDateL').style.display="block";
		document.getElementById('beginDateSL').style.display="none";
	}else{
		document.getElementById('beginDateL').style.display="none";
		document.getElementById('beginDateSL').style.display="none";
	}	
}

//关闭
function returnBack(){
	window.close();
}
function showPhotoAbleEdit(photoId){
	if(photoId){
		var src = rootPath+"download?table="+"COM_PHOTO"+"_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
		document.getElementById('img').src=src
	}else{
	}
}
//明细
function getName(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href=# onclick="peopleDetail(\''+record.get("PEOPLE_ID")+'\')">'+value+'</a>';
}
//查看特定人员的明细
function peopleDetail(peopleId){
	var width = 1000;
    var height = 423;
	var url="samRuralAreasPeopleDetail.jsp?peopleId="+peopleId+'&applyId='+applyId;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
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
//下载申请证明材料
function downloadFile(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("applyFileId");
	if(record.get('fileName')){
	    var url0=rootPath+"download?table=sam_apply_files&column=file_content&pk=apply_file_id&filename=file_name&apply_file_id='"+id+"'";
		return '<a id="download"  href='+url0+'>'+record.get('fileName')+'</a>';
	}else{
		return '';
	}
}	
//赡扶抚养义务人员
function getSupportName(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:detailSupport(\''+record.get("supportId")+'\')">'+value+'</a>';
}
//查看赡扶抚养义务人员
function detailSupport(supportId){
	var width = 850;
    var height = 187;
	var url="supportDetail.jsp?familyId="+familyId+"&supportId="+supportId+"&assistanceType=03";
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}