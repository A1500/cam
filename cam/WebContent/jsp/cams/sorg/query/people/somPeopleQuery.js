function init(){
	L5.QuickTips.init();
}
//进行查询
function forQuery(){
	var data=new L5.Map();//定义一个map
	var name =_$("name");
	name = encodeURIComponent(encodeURIComponent(name));
	data.put("name",name);
	data.put("idCard",_$("idCard"));
	data.put("sex",_$("sex"));
	data.put("birthdayQ",_$("birthdayQ"));
	data.put("birthdayZ",_$("birthdayZ"));
	data.put("folk",_$("folk"));
	data.put("nation",_$("nation"));
	data.put("politics",_$("politics"));
	data.put("education",_$("education"));

	var populace =_$("populace");
	populace = encodeURIComponent(encodeURIComponent(populace));
	data.put("populace",populace);
	data.put("ifRetire",_$("ifRetire"));
	data.put("ifFulltime",_$("ifFulltime"));

	var workName =_$("workName");
	workName = encodeURIComponent(encodeURIComponent(workName));
	data.put("workName",workName);

	data.put("workPhone",_$("workPhone"));

	var workDuties =_$("workDuties");
	workDuties = encodeURIComponent(encodeURIComponent(workDuties));
	data.put("workDuties",workDuties);

	var adds =_$("adds");
	adds = encodeURIComponent(encodeURIComponent(adds));
	data.put("adds",adds);

	data.put("postCode",_$("postCode"));
	data.put("phone",_$("phone"));

	//人员关系查询条件
	var cnName =_$("cnName");
	cnName = encodeURIComponent(encodeURIComponent(cnName));
	data.put("cnName",cnName);

	data.put("sorgType",_$("sorgType"));
	data.put("sorgKind",_$("sorgKind"));
	data.put("ifServe",_$("ifServe"));
	data.put("sorgDuties",_$("sorgDuties"));

	var morgName =_$("morgName");
	morgName = encodeURIComponent(encodeURIComponent(morgName));
	data.put("morgName",morgName);

	data.put("ifPartyLeader",_$("ifPartyLeader"));
	data.put("partyLeaderLevel",_$("partyLeaderLevel"));
	var promiseOrgan = _$("promiseOrgan");
	promiseOrgan = encodeURIComponent(encodeURIComponent(promiseOrgan));
	data.put("promiseOrgan",promiseOrgan);

	url='jsp/cams/sorg/query/people/somPeopleQueryList.jsp';
	text='';
	L5.forward(url,text,data);
}
function forHelp(){
	var revalue=window.showModalDialog("../../../../bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=11,12,13,14&isExact=0&isCheckBox=0&isTree=0","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("morgCode").value = list[0];
		document.getElementById("morgName").value = list[1];

	}
}