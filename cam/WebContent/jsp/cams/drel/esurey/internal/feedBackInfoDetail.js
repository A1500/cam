function init(){
	fangguanDs.setParameter("peopleId", peopleId);
//	shebaoDs.setParameter("peopleId", peopleId);
//	gongshangDs.setParameter("peopleId", peopleId);
//	guoshuiDs.setParameter("peopleId", peopleId);
	cheliangDs.setParameter("peopleId", peopleId);
//	siwangDs.setParameter("peopleId", peopleId);
//	minfeiDs.setParameter("peopleId", peopleId);
//	fisDetailDs.setParameter("peopleId", peopleId);
//	marryDetailDs.setParameter("peopleId", peopleId);
	fangguanDs.load(true);
//	shebaoDs.load(true);
//	gongshangDs.load(true);
//	guoshuiDs.load(true);
	cheliangDs.load(true);
//	siwangDs.load(true);
//	minfeiDs.load(true);
//	fisDetailDs.load(true);
//	marryDetailDs.load(true);
	
	if(fangguanDs.getCount()<1){
		L5.getCmp("fangguanGrid").hide();
	}
	if(shebaoDs.getCount()<1){
		L5.getCmp("shebaoGrid").hide();
	}
	if(guoshuiDs.getCount()<1){
		L5.getCmp("guoshuiGrid").hide();
	}
	if(cheliangDs.getCount()<1){
		L5.getCmp("cheliangGrid").hide();
	}
	if(siwangDs.getCount()<1){
		L5.getCmp("siwangGrid").hide();
	}
	if(minfeiDs.getCount()<1){
		L5.getCmp("minfeiGrid").hide();
	}
	if(fisDetailDs.getCount()<1){
		L5.getCmp("fisGrid").hide();
	}
	if(gongshangDs.getCount()<1){
		L5.getCmp("gongshangGrid").hide();
	}
	
	if(marryDetailDs.getCount()<1){
		L5.getCmp("marryGrid").hide();
	}
}
function query(){
	var peopleName=document.getElementById("peopleName").value;
	var cardNumber=document.getElementById("cardNumber").value;
	var xtdwquery=document.getElementById("xtdwquery").value;
	var startDate=document.getElementById("startDate").value;
	var endDate=document.getElementById("endDate").value;
	if(startDate!=""&&endDate==""||startDate==""&&endDate!=""){
		L5.Msg.alert("提示","请填写全起止日期!");
	}
	if(xtdwquery==""||xtdwquery==null){
		if(peopleName==""&&cardNumber==""){
			L5.Msg.alert("提示","请至少输入姓名、身份证号或协同单位!");
		}else if(peopleName!=""&&cardNumber==""){
			L5.getCmp("fangguanGrid").setHeight(150);
			L5.getCmp("shebaoGrid").setHeight(150);
			L5.getCmp("gongshangGrid").setHeight(150);
			L5.getCmp("guoshuiGrid").setHeight(150);
			L5.getCmp("siwangGrid").setHeight(150);
			L5.getCmp("cheliangGrid").setHeight(150);
			L5.getCmp("minfeiGrid").setHeight(150);
			L5.getCmp("fisGrid").setHeight(150);
			L5.getCmp("marryGrid").setHeight(150);
			L5.getCmp("fangguanGrid").show();
			L5.getCmp("shebaoGrid").show();
			L5.getCmp("gongshangGrid").show();
			L5.getCmp("guoshuiGrid").show();
			L5.getCmp("siwangGrid").show();
			L5.getCmp("cheliangGrid").show();
			L5.getCmp("minfeiGrid").show();
			L5.getCmp("fisGrid").show();
			L5.getCmp("marryGrid").show();
			fangguanDs.setParameter("PEOPLE_NAME@like", peopleName);
			shebaoDs.setParameter("PEOPLE_NAME@like", peopleName);
			gongshangDs.setParameter("PEOPLE_NAME@like", peopleName);
			guoshuiDs.setParameter("PEOPLE_NAME@like", peopleName);
			cheliangDs.setParameter("PEOPLE_NAME@like", peopleName);
			siwangDs.setParameter("PEOPLE_NAME@like", peopleName);
			minfeiDs.setParameter("PEOPLE_NAME@like", peopleName);
			fisDetailDs.setParameter("PEOPLE_NAME@like", peopleName);
			marryDetailDs.setParameter("PEOPLE_NAME@like", peopleName);
			if(startDate!=""&&endDate!=""){
				fangguanDs.setParameter("INPUT_TIME@>=", startDate);
				shebaoDs.setParameter("INPUT_TIME@>=", startDate);
				gongshangDs.setParameter("INPUT_TIME@>=", startDate);
				guoshuiDs.setParameter("INPUT_TIME@>=", startDate);
				cheliangDs.setParameter("INPUT_TIME@>=", startDate);
				siwangDs.setParameter("INPUT_TIME@>=", startDate);
				minfeiDs.setParameter("INPUT_TIME@>=", startDate);
				fisDetailDs.setParameter("INPUT_TIME@>=", startDate);
				marryDetailDs.setParameter("INPUT_TIME@>=", startDate);
				
				fangguanDs.setParameter("INPUT_TIME@<", endDate);
				shebaoDs.setParameter("INPUT_TIME@<", endDate);
				gongshangDs.setParameter("INPUT_TIME@<", endDate);
				guoshuiDs.setParameter("INPUT_TIME@<", endDate);
				cheliangDs.setParameter("INPUT_TIME@<", endDate);
				siwangDs.setParameter("INPUT_TIME@<", endDate);
				minfeiDs.setParameter("INPUT_TIME@<", endDate);
				fisDetailDs.setParameter("INPUT_TIME@<", endDate);
				marryDetailDs.setParameter("INPUT_TIME@<", endDate);
			}
			fangguanDs.load();
			shebaoDs.load();
			gongshangDs.load();
			guoshuiDs.load();
			cheliangDs.load();
			siwangDs.load();
			minfeiDs.load();
			fisDetailDs.load();
			marryDetailDs.load();
		}else if(peopleName==""&&cardNumber!=""){
			L5.getCmp("fangguanGrid").setHeight(150);
			L5.getCmp("shebaoGrid").setHeight(150);
			L5.getCmp("gongshangGrid").setHeight(150);
			L5.getCmp("guoshuiGrid").setHeight(150);
			L5.getCmp("siwangGrid").setHeight(150);
			L5.getCmp("cheliangGrid").setHeight(150);
			L5.getCmp("minfeiGrid").setHeight(150);
			L5.getCmp("fisGrid").setHeight(150);
			L5.getCmp("marryGrid").setHeight(150);
			L5.getCmp("fangguanGrid").show();
			L5.getCmp("shebaoGrid").show();
			L5.getCmp("gongshangGrid").show();
			L5.getCmp("guoshuiGrid").show();
			L5.getCmp("siwangGrid").show();
			L5.getCmp("cheliangGrid").show();
			L5.getCmp("minfeiGrid").show();
			L5.getCmp("fisGrid").show();
			L5.getCmp("marryGrid").show();
			fangguanDs.setParameter("ID_CARD", cardNumber);
			shebaoDs.setParameter("ID_CARD", cardNumber);
			gongshangDs.setParameter("ID_CARD", cardNumber);
			guoshuiDs.setParameter("ID_CARD", cardNumber);
			cheliangDs.setParameter("ID_CARD", cardNumber);
			siwangDs.setParameter("ID_CARD", cardNumber);
			minfeiDs.setParameter("ID_CARD", cardNumber);
			fisDetailDs.setParameter("ID_CARD", cardNumber);
			marryDetailDs.setParameter("ID_CARD", cardNumber);
			if(startDate!=""&&endDate!=""){
				fangguanDs.setParameter("INPUT_TIME@>=", startDate);
				shebaoDs.setParameter("INPUT_TIME@>=", startDate);
				gongshangDs.setParameter("INPUT_TIME@>=", startDate);
				guoshuiDs.setParameter("INPUT_TIME@>=", startDate);
				cheliangDs.setParameter("INPUT_TIME@>=", startDate);
				siwangDs.setParameter("INPUT_TIME@>=", startDate);
				minfeiDs.setParameter("INPUT_TIME@>=", startDate);
				fisDetailDs.setParameter("INPUT_TIME@>=", startDate);
				marryDetailDs.setParameter("INPUT_TIME@>=", startDate);
				
				fangguanDs.setParameter("INPUT_TIME@<", endDate);
				shebaoDs.setParameter("INPUT_TIME@<", endDate);
				gongshangDs.setParameter("INPUT_TIME@<", endDate);
				guoshuiDs.setParameter("INPUT_TIME@<", endDate);
				cheliangDs.setParameter("INPUT_TIME@<", endDate);
				siwangDs.setParameter("INPUT_TIME@<", endDate);
				minfeiDs.setParameter("INPUT_TIME@<", endDate);
				fisDetailDs.setParameter("INPUT_TIME@<", endDate);
				marryDetailDs.setParameter("INPUT_TIME@<", endDate);
			}
			fangguanDs.load();
			shebaoDs.load();
			gongshangDs.load();
			guoshuiDs.load();
			cheliangDs.load();
			siwangDs.load();
			minfeiDs.load();
			fisDetailDs.load();
			marryDetailDs.load();
		}else{
			L5.getCmp("fangguanGrid").setHeight(150);
			L5.getCmp("shebaoGrid").setHeight(150);
			L5.getCmp("gongshangGrid").setHeight(150);
			L5.getCmp("guoshuiGrid").setHeight(150);
			L5.getCmp("siwangGrid").setHeight(150);
			L5.getCmp("cheliangGrid").setHeight(150);
			L5.getCmp("minfeiGrid").setHeight(150);
			L5.getCmp("fisGrid").setHeight(150);
			L5.getCmp("marryGrid").setHeight(150);
			L5.getCmp("fangguanGrid").show();
			L5.getCmp("shebaoGrid").show();
			L5.getCmp("gongshangGrid").show();
			L5.getCmp("guoshuiGrid").show();
			L5.getCmp("siwangGrid").show();
			L5.getCmp("cheliangGrid").show();
			L5.getCmp("minfeiGrid").show();
			L5.getCmp("fisGrid").show();
			L5.getCmp("marryGrid").show();
			fangguanDs.setParameter("PEOPLE_NAME@like", peopleName);
			shebaoDs.setParameter("PEOPLE_NAME@like", peopleName);
			gongshangDs.setParameter("PEOPLE_NAME@like", peopleName);
			guoshuiDs.setParameter("PEOPLE_NAME@like", peopleName);
			cheliangDs.setParameter("PEOPLE_NAME@like", peopleName);
			siwangDs.setParameter("PEOPLE_NAME@like", peopleName);
			minfeiDs.setParameter("PEOPLE_NAME@like", peopleName);
			fisDetailDs.setParameter("PEOPLE_NAME@like", peopleName);
			marryDetailDs.setParameter("PEOPLE_NAME@like", peopleName);
			fangguanDs.setParameter("ID_CARD", cardNumber);
			shebaoDs.setParameter("ID_CARD", cardNumber);
			gongshangDs.setParameter("ID_CARD", cardNumber);
			guoshuiDs.setParameter("ID_CARD", cardNumber);
			cheliangDs.setParameter("ID_CARD", cardNumber);
			siwangDs.setParameter("ID_CARD", cardNumber);
			minfeiDs.setParameter("ID_CARD", cardNumber);
			fisDetailDs.setParameter("ID_CARD", cardNumber);
			marryDetailDs.setParameter("ID_CARD", cardNumber);
			if(startDate!=""&&endDate!=""){
				fangguanDs.setParameter("INPUT_TIME@>=", startDate);
				shebaoDs.setParameter("INPUT_TIME@>=", startDate);
				gongshangDs.setParameter("INPUT_TIME@>=", startDate);
				guoshuiDs.setParameter("INPUT_TIME@>=", startDate);
				cheliangDs.setParameter("INPUT_TIME@>=", startDate);
				siwangDs.setParameter("INPUT_TIME@>=", startDate);
				minfeiDs.setParameter("INPUT_TIME@>=", startDate);
				fisDetailDs.setParameter("INPUT_TIME@>=", startDate);
				marryDetailDs.setParameter("INPUT_TIME@>=", startDate);
				
				fangguanDs.setParameter("INPUT_TIME@<", endDate);
				shebaoDs.setParameter("INPUT_TIME@<", endDate);
				gongshangDs.setParameter("INPUT_TIME@<", endDate);
				guoshuiDs.setParameter("INPUT_TIME@<", endDate);
				cheliangDs.setParameter("INPUT_TIME@<", endDate);
				siwangDs.setParameter("INPUT_TIME@<", endDate);
				minfeiDs.setParameter("INPUT_TIME@<", endDate);
				fisDetailDs.setParameter("INPUT_TIME@<", endDate);
				marryDetailDs.setParameter("INPUT_TIME@<", endDate);
			}
			fangguanDs.load();
			shebaoDs.load();
			gongshangDs.load();
			guoshuiDs.load();
			cheliangDs.load();
			siwangDs.load();
			minfeiDs.load();
			fisDetailDs.load();
			marryDetailDs.load();
		}
	}else{
		if(xtdwquery=="d003a"){
			var siwangGrid=L5.getCmp("siwangGrid");
			siwangGrid.setHeight(400);
			siwangGrid.show();
			L5.getCmp("fangguanGrid").hide();
			L5.getCmp("shebaoGrid").hide();
			L5.getCmp("gongshangGrid").hide();
			L5.getCmp("guoshuiGrid").hide();
			L5.getCmp("cheliangGrid").hide();
			L5.getCmp("minfeiGrid").hide();
			L5.getCmp("fisGrid").hide();
			L5.getCmp("marryGrid").hide();
			if(peopleName==""&&cardNumber!=""){
				siwangDs.setParameter("ID_CARD", cardNumber);
			}else if(peopleName!=""&&cardNumber==""){
				siwangDs.setParameter("PEOPLE_NAME@like", peopleName);
			}else if(peopleName!=""&&cardNumber!=""){
				siwangDs.setParameter("ID_CARD", cardNumber);
				siwangDs.setParameter("PEOPLE_NAME@like", peopleName);
			}
			if(startDate!=""&&endDate!=""){
				siwangDs.setParameter("INPUT_TIME@>=", startDate);
				siwangDs.setParameter("INPUT_TIME@<", endDate);
			}
			siwangDs.load();
		}else if(xtdwquery=="d003b"){
			var cheliangGrid=L5.getCmp("cheliangGrid");
			cheliangGrid.setHeight(400);
			cheliangGrid.show();
			L5.getCmp("fangguanGrid").hide();
			L5.getCmp("shebaoGrid").hide();
			L5.getCmp("gongshangGrid").hide();
			L5.getCmp("guoshuiGrid").hide();
			L5.getCmp("siwangGrid").hide();
			L5.getCmp("minfeiGrid").hide();
			L5.getCmp("fisGrid").hide();
			L5.getCmp("marryGrid").hide();
			if(peopleName==""&&cardNumber!=""){
				cheliangDs.setParameter("ID_CARD", cardNumber);
			}else if(peopleName!=""&&cardNumber==""){
				cheliangDs.setParameter("PEOPLE_NAME@like", peopleName);
			}else if(peopleName!=""&&cardNumber!=""){
				cheliangDs.setParameter("ID_CARD", cardNumber);
				cheliangDs.setParameter("PEOPLE_NAME@like", peopleName);
			}
			if(startDate!=""&&endDate!=""){
				cheliangDs.setParameter("INPUT_TIME@>=", startDate);
				cheliangDs.setParameter("INPUT_TIME@<", endDate);
			}
			cheliangDs.load();
		}else if(xtdwquery=="d005"){
			var fangguanGrid=L5.getCmp("fangguanGrid");
			fangguanGrid.setHeight(400);
			fangguanGrid.show();
			L5.getCmp("shebaoGrid").hide();
			L5.getCmp("gongshangGrid").hide();
			L5.getCmp("guoshuiGrid").hide();
			L5.getCmp("siwangGrid").hide();
			L5.getCmp("cheliangGrid").hide();
			L5.getCmp("minfeiGrid").hide();
			L5.getCmp("fisGrid").hide();
			L5.getCmp("marryGrid").hide();
			if(peopleName==""&&cardNumber!=""){
				fangguanDs.setParameter("ID_CARD", cardNumber);
			}else if(peopleName!=""&&cardNumber==""){
				fangguanDs.setParameter("PEOPLE_NAME@like", peopleName);
			}else if(peopleName!=""&&cardNumber!=""){
				fangguanDs.setParameter("ID_CARD", cardNumber);
				fangguanDs.setParameter("PEOPLE_NAME@like", peopleName);
			}
			if(startDate!=""&&endDate!=""){
				fangguanDs.setParameter("INPUT_TIME@>=", startDate);
				fangguanDs.setParameter("INPUT_TIME@<", endDate);
			}
			fangguanDs.load();
		}else if(xtdwquery=="d007"){
			var shebaoGrid=L5.getCmp("shebaoGrid");
			shebaoGrid.setHeight(400);
			shebaoGrid.show();
			L5.getCmp("fangguanGrid").hide();
			L5.getCmp("gongshangGrid").hide();
			L5.getCmp("guoshuiGrid").hide();
			L5.getCmp("siwangGrid").hide();
			L5.getCmp("cheliangGrid").hide();
			L5.getCmp("minfeiGrid").hide();
			L5.getCmp("fisGrid").hide();
			L5.getCmp("marryGrid").hide();
			if(peopleName==""&&cardNumber!=""){
				shebaoDs.setParameter("ID_CARD", cardNumber);
			}else if(peopleName!=""&&cardNumber==""){
				shebaoDs.setParameter("PEOPLE_NAME@like", peopleName);
			}else if(peopleName!=""&&cardNumber!=""){
				shebaoDs.setParameter("ID_CARD", cardNumber);
				shebaoDs.setParameter("PEOPLE_NAME@like", peopleName);
			}
			if(startDate!=""&&endDate!=""){
				shebaoDs.setParameter("INPUT_TIME@>=", startDate);
				shebaoDs.setParameter("INPUT_TIME@<", endDate);
			}
			shebaoDs.load();
		}else if(xtdwquery=="d008"){
			var guoshuiGrid=L5.getCmp("guoshuiGrid");
			guoshuiGrid.setHeight(400);
			guoshuiGrid.show();
			L5.getCmp("fangguanGrid").hide();
			L5.getCmp("shebaoGrid").hide();
			L5.getCmp("gongshangGrid").hide();
			L5.getCmp("siwangGrid").hide();
			L5.getCmp("cheliangGrid").hide();
			L5.getCmp("minfeiGrid").hide();
			L5.getCmp("fisGrid").hide();
			L5.getCmp("marryGrid").hide();
			if(peopleName==""&&cardNumber!=""){
				guoshuiDs.setParameter("ID_CARD", cardNumber);
			}else if(peopleName!=""&&cardNumber==""){
				guoshuiDs.setParameter("PEOPLE_NAME@like", peopleName);
			}else if(peopleName!=""&&cardNumber!=""){
				guoshuiDs.setParameter("ID_CARD", cardNumber);
				guoshuiDs.setParameter("PEOPLE_NAME@like", peopleName);
			}
			if(startDate!=""&&endDate!=""){
				guoshuiDs.setParameter("INPUT_TIME@>=", startDate);
				guoshuiDs.setParameter("INPUT_TIME@<", endDate);
			}
			guoshuiDs.load();
		}else if(xtdwquery=="d010"){
			var gongshangGrid=L5.getCmp("gongshangGrid");
			gongshangGrid.setHeight(400);
			gongshangGrid.show();
			L5.getCmp("fangguanGrid").hide();
			L5.getCmp("shebaoGrid").hide();
			L5.getCmp("guoshuiGrid").hide();
			L5.getCmp("siwangGrid").hide();
			L5.getCmp("cheliangGrid").hide();
			L5.getCmp("minfeiGrid").hide();
			L5.getCmp("fisGrid").hide();
			L5.getCmp("marryGrid").hide();
			if(peopleName==""&&cardNumber!=""){
				gongshangDs.setParameter("ID_CARD", cardNumber);
			}else if(peopleName!=""&&cardNumber==""){
				gongshangDs.setParameter("PEOPLE_NAME@like", peopleName);
			}else if(peopleName!=""&&cardNumber!=""){
				gongshangDs.setParameter("ID_CARD", cardNumber);
				gongshangDs.setParameter("PEOPLE_NAME@like", peopleName);
			}
			if(startDate!=""&&endDate!=""){
				gongshangDs.setParameter("INPUT_TIME@>=", startDate);
				gongshangDs.setParameter("INPUT_TIME@<", endDate);
			}
			gongshangDs.load();
		}else if(xtdwquery=="d002a"){
			var minfeiGrid=L5.getCmp("minfeiGrid");
			minfeiGrid.setHeight(400);
			minfeiGrid.show();
			L5.getCmp("fangguanGrid").hide();
			L5.getCmp("shebaoGrid").hide();
			L5.getCmp("guoshuiGrid").hide();
			L5.getCmp("siwangGrid").hide();
			L5.getCmp("cheliangGrid").hide();
			L5.getCmp("gongshangGrid").hide();
			L5.getCmp("fisGrid").hide();
			L5.getCmp("marryGrid").hide();
			if(peopleName==""&&cardNumber!=""){
				minfeiDs.setParameter("ID_CARD", cardNumber);
			}else if(peopleName!=""&&cardNumber==""){
				minfeiDs.setParameter("PEOPLE_NAME@like", peopleName);
			}else if(peopleName!=""&&cardNumber!=""){
				minfeiDs.setParameter("ID_CARD", cardNumber);
				minfeiDs.setParameter("PEOPLE_NAME@like", peopleName);
			}
			if(startDate!=""&&endDate!=""){
				minfeiDs.setParameter("INPUT_TIME@>=", startDate);
				minfeiDs.setParameter("INPUT_TIME@<", endDate);
			}
			minfeiDs.load();
		}else if(xtdwquery=="d002b"){
			var fisGrid=L5.getCmp("fisGrid");
			fisGrid.setHeight(400);
			fisGrid.show();
			L5.getCmp("fangguanGrid").hide();
			L5.getCmp("shebaoGrid").hide();
			L5.getCmp("guoshuiGrid").hide();
			L5.getCmp("siwangGrid").hide();
			L5.getCmp("cheliangGrid").hide();
			L5.getCmp("gongshangGrid").hide();
			L5.getCmp("minfeiGrid").hide();
			L5.getCmp("marryGrid").hide();
			if(peopleName==""&&cardNumber!=""){
				fisDetailDs.setParameter("ID_CARD", cardNumber);
			}else if(peopleName!=""&&cardNumber==""){
				fisDetailDs.setParameter("PEOPLE_NAME@like", peopleName);
			}else if(peopleName!=""&&cardNumber!=""){
				fisDetailDs.setParameter("ID_CARD", cardNumber);
				fisDetailDs.setParameter("PEOPLE_NAME@like", peopleName);
			}
			if(startDate!=""&&endDate!=""){
				fisDetailDs.setParameter("INPUT_TIME@>=", startDate);
				fisDetailDs.setParameter("INPUT_TIME@<", endDate);
			}
			fisDetailDs.load();
		}else if(xtdwquery=="d002c"){
			var marryGrid=L5.getCmp("marryGrid");
			marryGrid.setHeight(400);
			marryGrid.show();
			L5.getCmp("fangguanGrid").hide();
			L5.getCmp("shebaoGrid").hide();
			L5.getCmp("guoshuiGrid").hide();
			L5.getCmp("siwangGrid").hide();
			L5.getCmp("cheliangGrid").hide();
			L5.getCmp("gongshangGrid").hide();
			L5.getCmp("fisGrid").hide();
			L5.getCmp("minfeiGrid").hide();
			if(peopleName==""&&cardNumber!=""){
				marryDetailDs.setParameter("ID_CARD", cardNumber);
			}else if(peopleName!=""&&cardNumber==""){
				marryDetailDs.setParameter("PEOPLE_NAME@like", peopleName);
			}else if(peopleName!=""&&cardNumber!=""){
				marryDetailDs.setParameter("ID_CARD", cardNumber);
				marryDetailDs.setParameter("PEOPLE_NAME@like", peopleName);
			}
			if(startDate!=""&&endDate!=""){
				marryDetailDs.setParameter("INPUT_TIME@>=", startDate);
				marryDetailDs.setParameter("INPUT_TIME@<", endDate);
			}
			marryDetailDs.load();
		}
	}
}
