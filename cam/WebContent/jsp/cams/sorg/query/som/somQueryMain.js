
function init(){
}

var data=new L5.Map();//定义一个map
//证书查询的条件
var signOrgan='';
var signDate='';
var signEndDate='';
//账户查询条件
var bank='';
var accountDate='';
var accountCode='';


function forQuery(){
	var sorgName=document.getElementById('sorgName').value;
	var sorgCode=document.getElementById('sorgCode').value;
	var sorgType=document.getElementById('sorgType').value;
	var ifBranch=document.getElementById('ifBranch').value;
	var sorgKind=document.getElementById('sorgKind').value;

	var sorgStatus=document.getElementById('sorgStatus').value;
	var regDate=document.getElementById('regDate').value;
	var enName=document.getElementById('enName').value;

	var abName=document.getElementById('abName').value;
	var sorgEmail=document.getElementById('sorgEmail').value;
	var organCode=document.getElementById('organCode').value;
	var sorgPhone=document.getElementById('sorgPhone').value;
	var sorgFax=document.getElementById('sorgFax').value;

	var sorgPost=document.getElementById('sorgPost').value;
	var sorgAdds=document.getElementById('sorgAdds').value;
	var sorgWeb=document.getElementById('sorgWeb').value;
	var borgName=document.getElementById('borgName').value;
	var ifHis=document.getElementById('ifHis').value;
	var morgName=document.getElementById('morgName').value;

	var morgArea=document.getElementById('morgArea').value;
	var actArea=document.getElementById('actArea').value;
	var business=document.getElementById('business').value;
	var busScope=document.getElementById('busScope').value;

	var regMon=document.getElementById('regMon').value;
	var legalPeople=document.getElementById('legalPeople').value;
	var memberNum=document.getElementById('memberNum').value;
	var unitsNum=document.getElementById('unitsNum').value;
	var peopleNum=document.getElementById('peopleNum').value;

	var standCouncilNum=document.getElementById('standCouncilNum').value;
	var councilNum=document.getElementById('councilNum').value;
	var engagedNum=document.getElementById('engagedNum').value;
	var cancelDate=document.getElementById('cancelDate').value;

	var residence=document.getElementById('residence').value;

	//根据证书查询的条件
	//signOrgan=document.getElementById('signOrgan').value;
	//signDate=document.getElementById('signDate').value;
	//signEndDate=document.getElementById('signEndDate').value;

	//根据账户查询的条件
	//bank=document.getElementById('bank').value;
	//accountDate=document.getElementById('accountDate').value;
	//accountCode=document.getElementById('accountCode').value;

	//var s1=queryForCert();
	//var s2=queryForAccount();
	//var sorgIDs=getUnion(s1,s2);//根据账户和证书条件得到的符合条件的社会组织ID的交集
	//alert('社会组织ID交集为：'+sorgIDs);
	sorgName = encodeURIComponent(encodeURIComponent(sorgName));
	data.put("sorgName",sorgName);
	data.put("sorgCode",sorgCode);
	data.put("sorgType",sorgType);
	data.put("ifBranch",ifBranch);
	data.put("sorgKind",sorgKind);
	data.put("sorgStatus",sorgStatus);
	data.put("regDate",regDate);
	enName = encodeURIComponent(encodeURIComponent(enName));
	data.put("enName",enName);
	abName = encodeURIComponent(encodeURIComponent(abName));
	data.put("abName",abName);
	data.put("sorgEmail",sorgEmail);
	data.put("organCode",organCode);
	data.put("sorgPhone",sorgPhone);
	data.put("sorgFax",sorgFax);
	data.put("sorgPost",sorgPost);
	sorgAdds = encodeURIComponent(encodeURIComponent(sorgAdds));
	data.put("sorgAdds",sorgAdds);
	data.put("sorgWeb",sorgWeb);
	data.put("borgName",borgName);
	data.put("ifHis",ifHis);
	morgName = encodeURIComponent(encodeURIComponent(morgName));
	data.put("morgName",morgName);
	data.put("morgArea",morgArea);
	actArea = encodeURIComponent(encodeURIComponent(actArea));
	data.put("actArea",actArea);
	business = encodeURIComponent(encodeURIComponent(business));
	data.put("business",business);
	data.put("busScope",busScope);
	data.put("regMon",regMon);
	legalPeople = encodeURIComponent(encodeURIComponent(legalPeople));
	data.put("legalPeople",legalPeople);
	data.put("memberNum",memberNum);
	data.put("unitsNum",unitsNum);
	data.put("peopleNum",peopleNum);
	data.put("standCouncilNum",standCouncilNum);
	data.put("councilNum",councilNum);
	data.put("engagedNum",engagedNum);
	data.put("cancelDate",cancelDate);
	residence = encodeURIComponent(encodeURIComponent(residence));
	data.put("residence",residence);
	//把通过证书和账户得到的ID传进去
	//data.put("sorgIDs",sorgIDs);

	url='jsp/cams/sorg/query/som/somQueryList.jsp';
	text='';
	L5.forward(url,text,data);
}

//查找出根据证书查询条件查询出的集合
function queryForCert(){
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomCertCmd");
	command.setParameter("signDate",signDate);
	command.setParameter("signOrgan",signOrgan);
	command.setParameter("signEndDate",signEndDate);
	command.execute("forQuery");
	var idString=command.getReturn('idString');
	return idString;
}
//查找出根据账户查询条件查询出的集合
function queryForAccount(){
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomAccountCmd");
	command.setParameter("bank",bank);
	command.setParameter("accountDate",accountDate);
	command.setParameter("accountCode",accountCode);
	command.execute("forQuery");
	var idString2=command.getReturn('idString2');
	return idString2;

}
//得到2个数组的交集
function getUnion(str1,str2){
	var a1 = str1.split(','),a2 = str2.split(','),l1 = a1.length-1,l2 = a2.length-1;
	var ret = [],tmp = {},ta,tb;
	for(var i=0;i<l1;i++){
   	 	ta = a1[i];
   	 	if(ta in tmp){if(tmp[ta]==2){ret.push(ta);}continue;}
  	  	tmp[ta] = 1;
	}
	for(i=0;i<l2;i++){
    	tb = a2[i];
    	if(tb in tmp){if(tmp[tb]==1){ret.push(tb);}continue;}
    	tmp[tb] = 2;
	}
	tmp = null;
     return ret;
}

function forCityHelp() {
		if (organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID", organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if (fullName != null && fullName != "") {
				organName = fullName;
			}
		}
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&radioMaxlevel=0&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	// var
	// revalue=window.showModalDialog(L5.webPath+"/jsp/cams/bpt/comm/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("morgArea").value = list[0];
		document.getElementById("morgAreaName").value = list[4];
	}
}


// 选择管辖单位-无Ds赋值,查询使用
function selectOrganNoDs() {
	var userInfo;
	var command = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	command.execute("getUserInfo");
	if (!command.error) {
		userInfo = command.getReturn("userInfo");
	} else {
		alert("用户没有登录！");
		return;
	}

	var cantCode = userInfo.cantCode;
	var cantName = userInfo.cantName;
	var cantType = userInfo.userDepOrganType;
	var url = L5.webPath
			+ "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&radioType=checkbox&organCode="
			+ cantCode + "&organName=" + escape(encodeURIComponent(cantName))
			+ "&cantType=" + cantType;
	var revalue  = showModalDialog(url, null,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:550px");

	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		//是否本级
		var isSelf = list[5];
		//上级代码，本级的上级代码为实际代码
		var ups = list[3];
		//行政区划名称
		var name = list[1];
		//区划代码
		var code = list[0];
		document.getElementById("morgAreaName").value = name;
		//为1的说明只选择了一个，并且为本级的将查询代码替换为ups。不为1的可能有两种情况，一是0，此时按原代码查询，二是多选此时ups为类似0，1，0格式，这种的程序暂不处理，按原code进行in处理
		if(isSelf=="1"){
			document.getElementById("morgArea").value = ups;
		}else{
			document.getElementById("morgArea").value = code;
		}
	}
}

function clearBorg(obj){
	if(obj.value == ""){
		$("borgName").value = "";
	}
}