function init(){
//	dicCityDS.setParameter("filerSql"," id like +""+ ");
	var ds=L5.DatasetMgr.lookup("comExtOrganDs");
	if(method=="insert"){
		ds.newRecord({"areaCode":id,"areaName":name});
		organTypeDsNew.setParameter("filterSql"," id like '"+id.substring(0,4)+"%000000' ");
		organTypeDsNew.load();
	}else if(method=="update"){
		ds.setParameter("ORGAN_ID@=", organId);
		
		ds.on('load',function(){
			var record=ds.getCurrent();
			var samMServiceAreaDs=L5.DatasetMgr.lookup("samMServiceAreaDs");
			samMServiceAreaDs.setParameter("ORGAN_ID",organId);
			samMServiceAreaDs.load();
			var areaCode="";
			samMServiceAreaDs.on('load',function(){
				var records=samMServiceAreaDs.getAllRecords();
				if(records.length>0){
					areaCode=records[0].get("areaCode");
					for(i=0;i<records.length;i++){
						areaCode=areaCode+"','"+records[i].get("areaCode");
					}
				}
				if(areaCode){
					organTypeDsNew.setParameter("filterSql"," id like '"+record.get("areaCode").substring(0,4)+"%000000' and id not in ('"+areaCode+"') ");
					organTypeDsNew.load();
					cityDs.setParameter("filterSql"," id like '"+record.get("areaCode").substring(0,4)+"%000000' and id  in ('"+areaCode+"') ");
					cityDs.load();
				}else{
					organTypeDsNew.setParameter("filterSql"," id like '"+record.get("areaCode").substring(0,4)+"%000000' ");
					organTypeDsNew.load();
				//	cityDs.setParameter("filterSql"," id like '"+record.get("areaCode").substring(0,4)+"%000000' ");
				//	cityDs.load();
				}
			});
			showAreaCodeSelectDiv(record.get("organType"));
		});
		ds.load();
		document.getElementById("organName").disabled=true;
		document.getElementById("organType").disabled=true;
	}
	initTargetRef();
}
//判断所选单位类型，如果所选单位类型时医院则显示属地配置
function showAreaCodeSelectDiv(value){
	if(value==30){
		document.getElementById("areaCodeSelectDiv").style.display="";
	}else{
		document.getElementById("areaCodeSelectDiv").style.display="none";
	}
}

function initTargetRef(){
		new L5.ux.ItemSelector({
		field:"forAreaCode",
		applyTo:"favordiv",
		id:"targetRefId",
		name:"targetRef_name",
		dataFields:["value","text"],
		fromDataset:organTypeDsNew,
		toDataset:cityDs,
		valueField :"value",
		displayField:"text",
	    msWidth:206,
	    msHeight:195,
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	    });
}

function save(){
	var values=L5.get("targetRefId").getValue();
	var ds=L5.DatasetMgr.lookup("comExtOrganDs");
	var valid =ds.isValidate(true);
	if(valid !== true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	
	var comExtOrgan=ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtOrganCmd");
	command.setParameter("comExtOrgan", comExtOrgan);
	command.setParameter("areaCodes",values);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	
	if(!command.error){
		var parentWin = window.parent.window;
		var tree = parentWin.L5.getCmp("usertree");
		if(method=="insert"){
			L5.get("targetRefId").vlaue=command.getReturn("areaCodes");
			var node = tree.getNodeByRecordId(id, "cityRecord");
			ds.getCurrent().set("organId", command.getReturn("organId"))
			var rec = new parentWin.L5.tree.TreeRecord.recordTypes["organRecord"](ds.getCurrent().data, command.getReturn("organId"));
			node.record.insert(rec);
		}else if(method=="update"){
			var node = tree.getNodeByRecordId(ds.getCurrent().get("organId"), "organRecord");
			node.record.set("organName", ds.getCurrent().get("organName"));
			node.record.set("organType", ds.getCurrent().get("organType"));
			node.record.commit();
		}
		L5.Msg.alert("提示","保存成功！");
		var url="jsp/cams/comm/extuser/comExtOrganEdit.jsp?method=update&organId="+ds.getCurrent().get("organId");
		L5.forward(url);
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}