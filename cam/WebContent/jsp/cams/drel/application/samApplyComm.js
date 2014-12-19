
//从经济核对结果中回填数据
function backEsureyMsg(){
	var revalue = window.showModalDialog(L5.webPath + "/jsp/cams/drel/application/esureyInfoSumList.jsp?parentPage=edit&nameValue=", "",
			"dialogHeight:600px;dialogWidth:950px;resizable:no;scroll:yes;");
	if(revalue){//根据返回的家庭ID回填信息
		var arry=revalue.split(";");
//		checkCradNo(document.getElementById("familyCardNo"));
		if(!checkIfExist(arry[1])){
			familyDataSet.set("familyCardNo",arry[1]);
			var command = new L5.Command("com.inspur.cams.drel.application.comm.cmd.SamApplyFromEnsureyCmd");
			command.setParameter("familyId",arry[0]);
			applyDataSet.set("applyId",applyId);
			applyDataSet.set("familyId",familyId);
			applyDataSet.set("domicileName",organName);
			applyDataSet.set("domicileCode",organArea);
			applyDataSet.set("address",address);
			applyDataSet.set("familyId",familyId);
			applyDataSet.set("assignmentId",assignmentId);
			command.setParameter("applyRecord",applyDataSet.getCurrent());
			command.execute("insertFromEnsurey");
			if(!command.error){
	//			L5.Msg.alert('提示',"保存成功！");
				checkCradNo(document.getElementById("familyCardNo"));
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}
	}
}
function checkIfExist(cardNo){
		var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
		command.setParameter("cardNo",cardNo);
		command.execute("checkIDCard");
		var errorFlag=command.getReturn("errorFlag");
		var returnFamilyId=command.getReturn("familyId");
		var personalStatsTag=command.getReturn("personalStatsTag");
		var peopleId=command.getReturn("peopleId");
		if(errorFlag != '' && typeof(errorFlag)!="undefined" && errorFlag!=null){//有此人享有其他待遇的提示
			if(personalStatsTag=='01'){
				L5.Msg.alert("提示",errorFlag);
				obj.value='';
				return;
			}else if(personalStatsTag=='03'){//死亡
				L5.Msg.alert("提示","该人员已死亡！");
				obj.value='';
				return;
			}else if(personalStatsTag=='06'){//分户迁出
			  	peopleListDataSet.setParameter("PEOPLE_ID",peopleId);
				peopleListDataSet.load();
				peopleListDataSet.on('load',loadPeopleListDataSet);
			}else{
			  	L5.MessageBox.confirm('提示', errorFlag.substring(0,2)+'所在家庭'+errorFlag.substring(2)+'，是否把该人员从原来家庭中分离出来？',function(sta){
					if(sta=="yes"){
					  	L5.MessageBox.confirm('提示','该人员状态为'+getDicText(samPersonalStatsDataSet,personalStatsTag)+'，确定要提取该人员信息吗？',function(sta_tq){
							if(sta_tq=="yes"){
							  	peopleListDataSet.setParameter("PEOPLE_ID",peopleId);
								peopleListDataSet.load();
								peopleListDataSet.on('load',loadPeopleListDataSet);
							}else{
								obj.value='';
								return;
							}
						});	
					}else{
						obj.value='';
						return;
					}
				});	
			}
		}else{
			if(returnFamilyId != '' && typeof(returnFamilyId)!="undefined" && returnFamilyId!=null){
				familyId=returnFamilyId;
				familyDataSet.setParameter("FAMILY_ID",familyId);
			    familyDataSet.on("load",loadPeopleListDs);
			    familyDataSet.load();
			    return true;
			}else{
				return false;
			}
		}
		
}