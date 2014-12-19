function init() {
	document.getElementById("updateTr").style.display = 'none';
	document.getElementById("updateTr2").style.display = 'none';
	document.getElementById("btnAgain").style.display = 'none';
	if (method == 'null')
		method = 'INSERT';
	if (method == 'INSERT') {
		document.getElementById("btnAgain").style.display = '';
		cdcVoluntaryInfoDataSet.newRecord({"organName":organName,"organCode":organCode});
	} else if (method == 'UPDATE') {
		document.getElementById("updateTr").style.display = '';
		document.getElementById("updateTr2").style.display = '';
		cdcVoluntaryInfoDataSet.setParameter("VOLUNTARY_ID", voluntaryId);
		cdcVoluntaryInfoDataSet.on('load',function(){
			if(cdcVoluntaryInfoDataSet.getCount()>0) {
				var photoId = cdcVoluntaryInfoDataSet.getAt(0).get("photoId");
				if(photoId!='') {
					document.getElementById("img").src = L5.webPath+"/download?table=COM_PHOTO_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
				}
			}
		});
		cdcVoluntaryInfoDataSet.load();
	}
}
// 保存
function saveBack() {
	save(true);
}
// 保存并继续
function saveAgain() {
	save(false);
}
function save(ifBack) {
	var valid = cdcVoluntaryInfoDataSet.isValidate();
	if (valid != true) {
		L5.Msg.alert('提示', "校验未通过:" + valid);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.cdc.base.cmd.CdcVoluntaryInfoCmd");
	command.setParameter("method", method);
	command.setParameter("record", cdcVoluntaryInfoDataSet.getCurrent());
	command.setParameter("photoTemp",document.getElementById('idFile').value);
	command.setForm("editForm2");
	command.execute("insert");
	
	if (!command.error) {
		cdcVoluntaryInfoDataSet.commitChanges();
		if(ifBack) {
			L5.Msg.alert('提示', "保存成功!", function(){
				back();
			});
		}else {
			L5.Msg.alert('提示', "保存成功!", function(){
				document.getElementById("editForm2").reset();
				document.getElementById("img").src = "../../../../../skins/images/default.jpg";
				cdcVoluntaryInfoDataSet.newRecord({"organName":organName,"organCode":organCode});
			});
			
		}
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
// 返回
function back() {
	window.close();
	window.returnValue='T';
}
// 根据身份证号回填逝者生日、性别
function backBirthDay(value) {
	if(value) {
		var idCard = checkIdCard(value);
		if (idCard) {
			//双更新
			var cdcVoluntaryInfoDataSet = L5.DatasetMgr.lookup("cdcVoluntaryInfoDataSet");
			cdcVoluntaryInfoDataSet.getCurrent().set("birthday", getBirthByCode(idCard));
			cdcVoluntaryInfoDataSet.getCurrent().set("sex", getSexByCode(idCard));
			
			document.getElementById("birthday").value = getBirthByCode(idCard);
			document.getElementById("sex").value = getSexByCode(idCard);
		} else {
			L5.Msg.alert('提示', '身份证件号不符合规则，请检查!');
		}
	}
}
//选中上传图片
function selectImg() {
	document.getElementById("img").src = document.getElementById("idFile").value;
}
function floatFile() {
	document.getElementById("idFile").style.posTop = event.srcElement.offsetTop;
	document.getElementById("idFile").style.posLeft = event.x - document.getElementById("idFile").offsetWidth / 2;
} 
