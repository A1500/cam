//返回社团总页面
function returnCertList(name){
	var url="";
	var text="";
	if(name=="group"){
		url="jsp/cams/sorg/manage/group/somGroupCertList.jsp";
	}else if(name=="fund"){
		url="jsp/cams/sorg/manage/fund/somFundCertList.jsp";
	}else if(name=="ungov"){
		url="jsp/cams/sorg/manage/ungov/somUngovCertList.jsp";
	}
	L5.forward(url,text);
}
//加载证书信息
function funAdd(somOrganDataset){
	var num=somOrganDataset.getCount();
	//判断登记证号是否存在
	if(num==0){
		L5.Msg.alert("提示","您输入的登记证号不存在！");
		forClearAll();
		return;
	}else{
		//得到根据登记证号查询的记录
		var record= somOrganDataset.getCurrent();
		//回填到页面
		document.getElementById("sorgCode").value=record.get("sorgCode");
		document.getElementById("sorgName").innerHTML=record.get("cnName");
		document.getElementById("organCode").innerHTML=record.get("organCode");
		document.getElementById("businessForPrint").innerHTML=record.get("businessForPrint");
		document.getElementById("residence").innerHTML=record.get("residence");
		document.getElementById("actArea").value=record.get("actArea");
		document.getElementById("regMon").innerHTML=record.get("regMon");
		document.getElementById("borgName").value=record.get("borgName");
		document.getElementById("sorgId").value=record.get("sorgId");
		document.getElementById("sorgType").value=record.get("sorgType");
		document.getElementById("morgName").value=record.get("morgName");
		document.getElementById("morgArea").value=record.get("morgArea");
		document.getElementById("sorgKind").value=record.get("sorgKind");
		document.getElementById("regDate").innerHTML=record.get("regDate");
		document.getElementById("ifBranch").value=record.get('ifBranch');

		//去后台获取当前登录人
		var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomCertSaveCmd");
		command.execute("getOnLine");
		var signOrganName=command.getReturn('CorpName');
		var issuePeople=command.getReturn('UserName');

		var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupChangeCmd");
		command.setParameter("sorgId",record.get("sorgId"));
		command.execute("getLegalPeopleNameByTaskCode");
		legalName=command.getReturn("legalPeopleName");
		document.getElementById("legalPeople").innerHTML=legalName;

		//回填相关信息
		document.getElementById('signOrgan').innerHTML=signOrganName;
		document.getElementById('printPeople').innerHTML=issuePeople;
		if(name=='insert'){
			document.getElementById('issuePeople').innerHTML=issuePeople;
		}
	}

}
//输入登记证号加载证书信息
function loadCertSorg(name){
	//获得登记证号
	var sorgCode=document.getElementById('sorgCode').value;
	if(sorgCode=='')return;
	var somOrganDataset=L5.DatasetMgr.lookup("somOrganDataset");
	somOrganDataset.setParameter("SORG_CODE",sorgCode);
	somOrganDataset.load();
	somOrganDataset.on('load',funAdd);
}
//选择证件状态为收缴时显示收缴信息
function forChangeStatus(){
	var num=document.getElementById('certStatus').value;
	var certType=document.getElementById('certType').value;
	if(certType==''){
		L5.Msg.alert("错误","请先填写证件类型！");
		forClearAll();
		return;
	}
	if(num==0){
		document.getElementById('receiveTr').style.display='block';
		document.getElementById('ifReceive').value="1";
		return;
	}
	if(num==1){
		document.getElementById('receiveTr').style.display='none';
		document.getElementById('ifReceive').value="0";
		forCheckR();
	}
	document.getElementById('receiveTr').style.display='none';
	document.getElementById('ifReceive').value="0";
}
//复用的方法 用于清空回填的所有内容
function forClearAll(){
	document.getElementById("sorgCode").value='';
	document.getElementById("sorgName").innerHTML='';
	document.getElementById("organCode").innerHTML='';
	document.getElementById("businessForPrint").innerHTML='';
	document.getElementById("residence").innerHTML='';
	document.getElementById("legalPeople").innerHTML='';
	document.getElementById("actArea").value='';
	document.getElementById("regMon").innerHTML='';
	document.getElementById("borgName").value='';
	document.getElementById("sorgId").value='';
	document.getElementById("sorgType").value='';
	document.getElementById("morgName").value='';
	document.getElementById("morgArea").value='';
	//document.getElementById("certType").value='';
	document.getElementById('certStatus').value='';
	document.getElementById("sorgKind").value='';
	document.getElementById("regDate").innerHTML='';
	document.getElementById("ifBranch").value='';
	certTypeforCheck='';
}
//判断证书是否存在
function funCheck(ds){
	var num=ds.getCount();
	if(num==0){
		return;
	}
	if(certTypeforCheck==0){
		L5.Msg.alert("错误","该证书正本已经打印！");
	}else if(certTypeforCheck==1){
		L5.Msg.alert("错误","该证书副本已经打印！");
	}
	forClearAll();
}
//判断证书在数据库中是否存在
var certTypeforCheck='';
function forCheckR(){
		if(document.getElementById("sorgCode").value==''){
		L5.Msg.alert("错误","请先填写登记证号！");
		forClearAll();
		return;
	}
	var sorgCode=document.getElementById("sorgCode").value;
	certTypeforCheck=document.getElementById('certType').value;
	checkCertDataset.setParameter("cert_Type",certTypeforCheck);
	checkCertDataset.setParameter("sorg_Code",sorgCode);
	checkCertDataset.load();
	checkCertDataset.on('load',funCheck);
}
//保存证书信息
var datasetName="";//用于打印时，弹出窗口获得dataset的名字
function saveCert(dataName,name,method){
	var certDataset=L5.DatasetMgr.lookup(dataName);
	datasetName=dataName;
	//得到文本框的内容
	var sorgCode=document.getElementById("sorgCode").value;
	var sorgName=document.getElementById("sorgName").innerHTML;
	var organCode=document.getElementById("organCode").innerHTML;
	var business=document.getElementById("businessForPrint").innerHTML;
	var residence=document.getElementById("residence").innerHTML;
	var legalPeople=document.getElementById("legalPeople").innerHTML;
	var actArea=document.getElementById("actArea").value;
	var regMon=document.getElementById("regMon").innerHTML;
	var borgName=document.getElementById("borgName").value;
	var sorgType=document.getElementById("sorgType").value;
	var morgArea=document.getElementById("morgArea").value;
	var morgName=document.getElementById("morgName").value;
	var signBeginDate=document.getElementById("signBeginDate").value;
	var signDate=document.getElementById("signDate").value;
	var printTime=document.getElementById("printTime").value;
	var printPeople=document.getElementById("printPeople").innerHTML;
	var sorgId=document.getElementById("sorgId").value;
	var signOrgan=document.getElementById('signOrgan').innerHTML;
	var sorgKind=document.getElementById("sorgKind").value;
	var ifBranch=document.getElementById("ifBranch").value;
	var certType=document.getElementById("certType").value;
	//登记日期
	var regDate=document.getElementById("regDate").innerHTML;
	//得到当前记录
	var record=certDataset.getCurrent();
	//将数据存入当前记录
	record.set('taskCode',taskCode);

	record.set('sorgCode',sorgCode);
	record.set('sorgName',sorgName);
	record.set('organCode',organCode);
	record.set('business',business);
	record.set('residence',residence);
	record.set('legalPeople',legalPeople);
	record.set('actArea',actArea);
	record.set('regMon',regMon);
	record.set('borgName',borgName);
	record.set('sorgId',sorgId);
	record.set('sorgType',sorgType);
	record.set('morgArea',morgArea);
	record.set('morgName',morgName);
	record.set('signBeginDate',signBeginDate);
	record.set('signDate',signDate);
	record.set('signOrgan',signOrgan);
	record.set('printTime',printTime);
	record.set('printPeople',printPeople);
	record.set('sorgKind',sorgKind);
	record.set('regDate',regDate);
	record.set('ifBranch',ifBranch);
	record.set('certType',certType);
	if(method=="print"){
		record.set('certStatus','1');
		record.set('ifReceive','0');
	}
	//得到证书类型 根据证书类型选择所需要的打印预览页面
	var certType=record.get('certType');
	var issueReasonDesc=record.get('issueReasonDesc');
	if(issueReasonDesc.length>100){
		L5.Msg.alert("错误","无法通过校验！发证原因描述字数超过限制！");
		return;
	}
	var isValidate=certDataset.isValidate(true);
	if(isValidate!=true){
		L5.Msg.alert("错误","无法通过校验！"+isValidate);
		return;
	}
	var signEndDate=record.get('signEndDate');
	var edate=signEndDate.replace('-','').replace('-','');
	var bdate=signBeginDate.replace('-','').replace('-','');
	if(bdate-edate>0){
		L5.Msg.alert("错误","无法通过校验！有效期起大于有效期止！");
		return;
	}
	L5.MessageBox.confirm('确定', '你确定要保存吗？',function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomCertSaveCmd");
			command.setParameter("somCert", record.toBean("com.inspur.cams.sorg.base.data.SomCert"));
			command.execute("insert");
			if (!command.error) {
				var id=command.getReturn("id");
				var url='';
				var text="";
				if(name=="group"){
					url="jsp/cams/sorg/manage/group/somGroupCertList.jsp";
					//if(method=="print"){
					//	var certTypeWin=L5.getCmp("certTypeWin");
					//	certTypeWin.show();
					//}
				}else if(name=="fund"){
					url="jsp/cams/sorg/manage/fund/somFundCertList.jsp";
					//if(method=="print"){
					//	var certTypeWin=L5.getCmp("certTypeWin");
					//	certTypeWin.show();
					//}
				}else if(name=="ungov"){
					url="jsp/cams/sorg/manage/ungov/somUngovCertList.jsp";
					//if(method=="print"){
					//	var certTypeWin=L5.getCmp("certTypeWin");
					//	certTypeWin.show();
					//}
				}
				L5.MessageBox.confirm('确定', '保存成功，是否打印证书？',function(sta){
					if(sta=="yes"){
						var certTypeWin=L5.getCmp("certTypeWin");
						certTypeWin.show();
						document.getElementById('certTypeSelect').value="0";//默认打印证书类型选择为正本
					}else{
						window.history.go(-1);
					}
				});
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else
			return;
	}
	);
}
//获得当前日期 2011-05-16
function getCurDate(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	var day = date.getDate();
	if(day<10){day = "0"+day;}
	return year+"-"+month+"-"+day;
}
//计算证书有效期
function countSignPeriod(){
	var signEndDate=document.getElementById('signEndDate').value;
	var signBeginDate=document.getElementById('signBeginDate').value;
	//TODO
}
 //点击查询 返回查询结果
 function forQuery(dataName){
 	var somCertDataset = L5.DatasetMgr.lookup(dataName);
	var sorgName=document.getElementById("sorgName").value;
	var signOrgan=document.getElementById("signOrgan").value;
	var sorgCode=document.getElementById("sorgCode").value;
	var certStatus=document.getElementById("certStatus").value;

	//如果没有只就设为undifined对应java的null
		if(sorgName=="") sorgName=undefined;
		if(sorgName==" "||sorgName=="~"||sorgName=="%"){
			L5.Msg.alert("提示","组织名称包含非法查询字符！");
			return false;
		}
		//设置参数值,用@分开的两段：前面是参数名,后面是比较符号
		somCertDataset.setParameter("SOM_CERT.sorg_Name@like",sorgName);
		if(signOrgan=="") signOrgan=undefined;
		if(signOrgan==" "||signOrgan=="~"||signOrgan=="%"){
			L5.Msg.alert("提示","发证机关包含非法查询字符！");
			return false;
		}
		somCertDataset.setParameter("SOM_CERT.sign_Organ@=",signOrgan);
		if(sorgCode=="") sorgCode=undefined;
		if(sorgCode==" "||sorgCode=="~"||sorgCode=="%"){
			L5.Msg.alert("提示","登记证号包含非法查询字符！");
			return false;
		}
		somCertDataset.setParameter("SOM_CERT.sorg_Code@=",sorgCode);
		if(certStatus=="") certStatus=undefined;
		somCertDataset.setParameter("SOM_CERT.cert_Status@=",certStatus);
		//默认加载证书类型为正本的
		somCertDataset.setParameter("SOM_CERT.cert_Type@=","0");
		// 加载数据
		somCertDataset.load();
 }
 //发证window中的关闭按钮
 function closecertF(){
 	var win=L5.getCmp("certF");
	win.hide();
 }
  //点击发证按钮 弹出发证 window
 function forCertF(dataName){
 		var grid = L5.getCmp('hlistPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
			var id=records[0].get("id");
			var certStatus=records[0].get('certStatus');
			var fetchPeople=records[0].get('fetchPeople');
			if(certStatus!=1){
				L5.Msg.alert("错误","该证书无效！");
				return;
			}
			if(fetchPeople!=''){
				L5.Msg.alert("错误","该证书已发证！");
				return;
			}
			var certdataset=L5.DatasetMgr.lookup(dataName);
  			certdataset.setParameter("id@=",id);
   			certdataset.load();
   			certdataset.on("load",certDSLload);
   			//给有效期起设置当前时间为初始时间
			var time=getCurDate();
			//去后台获取当前登录人
			var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomCertSaveCmd");
			command.execute("getOnLine");
			var userName=command.getReturn('UserName');
			var Cert=L5.getCmp("certF");
			Cert.show();
			//回填相关信息
			document.getElementById('issuePeople').innerHTML=userName;
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
 }
 //点击发证 处理发证事务
 function forSigncert(dataName,name){
 	var certdataset=L5.DatasetMgr.lookup(dataName);
 	var Record=certdataset.getCurrent();
 	if(Record.get('fetchPeople')==''){
 		L5.Msg.alert("错误","领证人不允许为空！");return;
 	}
 	if(document.getElementById('fetchDatewin').value==''){
 		L5.Msg.alert("错误","领证日期不允许为空！");return;
 	}
 	Record.set('fetchDate',document.getElementById('fetchDatewin').value);
 	Record.set('issuePeople',document.getElementById('issuePeople').innerHTML);

 	var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomCertSaveCmd");
	command.setParameter("somCert", Record.toBean("com.inspur.cams.sorg.base.data.SomCert"));
	command.execute("update");
	if (!command.error) {
		var url="";
		var text="";
		if(name=="group"){
			url="jsp/cams/sorg/manage/group/somGroupCertList.jsp";
		}else if(name=="fund"){
			url="jsp/cams/sorg/manage/fund/somFundCertList.jsp";
		}else if(name=="ungov"){
			url="jsp/cams/sorg/manage/ungov/somUngovCertList.jsp";
		}
		L5.Msg.alert("提示","发证成功！",function(){L5.forward(url,text);});
	}else{
		L5.Msg.alert("错误",command.error);
	}

 }
 //点击收回证书 修改证书信息的状态
  function forReclaim(name){
 		var grid = L5.getCmp('hlistPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要收回吗？',function(sta){
			if(sta=="yes"){
			if(records[0].get('certStatus')!=1){
				L5.Msg.alert("错误","该证书已经无效！");
				return;
			}
				var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomCertSaveCmd");
				command.setParameter("somCert", records[0].toBean("com.inspur.cams.sorg.base.data.SomCert"));
				command.execute("receive");
			if (!command.error) {
				var url="";
				var text="";
				if(name=="group"){
					url="jsp/cams/sorg/manage/group/somGroupCertList.jsp";
				}else if(name=="fund"){
					url="jsp/cams/sorg/manage/fund/somFundCertList.jsp";
				}else if(name=="ungov"){
					url="jsp/cams/sorg/manage/ungov/somUngovCertList.jsp";
				}
				L5.Msg.alert("提示","收回成功！",function(){L5.forward(url,text);});
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else
			return;
	}
	);
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
 }

//点击制证作废
function forZzzf(name){
	var grid = L5.getCmp('hlistPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要进行制证作废吗？',function(sta){
			if(sta=="yes"){
			if(records[0].get('certStatus')!=1){
				L5.Msg.alert("错误","该证书已经无效！");
				return;
			}
			var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomCertSaveCmd");
			records[0].set('certStatus','2');
			command.setParameter("somCert", records[0].toBean("com.inspur.cams.sorg.base.data.SomCert"));
			command.execute("update");
			if (!command.error) {
				var url="";
				var text="";
				if(name=="group"){
					url="jsp/cams/sorg/manage/group/somGroupCertList.jsp";
				}else if(name=="fund"){
					url="jsp/cams/sorg/manage/fund/somFundCertList.jsp";
				}else if(name=="ungov"){
					url="jsp/cams/sorg/manage/ungov/somUngovCertList.jsp";
				}
				L5.Msg.alert("提示","操作成功！",function(){L5.forward(url,text);});
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else
			return;
	}
	);
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
}
//点击宣布作废
function forXbzf(name){
	var grid = L5.getCmp('hlistPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要进行宣布作废吗？',function(sta){
			if(sta=="yes"){
			if(records[0].get('certStatus')!=1){
				L5.Msg.alert("错误","该证书已经无效！");
				return;
			}
			var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomCertSaveCmd");
			records[0].set('certStatus','3');
			command.setParameter("somCert", records[0].toBean("com.inspur.cams.sorg.base.data.SomCert"));
			command.execute("update");
			if (!command.error) {
				var url="";
				var text="";
				if(name=="group"){
					url="jsp/cams/sorg/manage/group/somGroupCertList.jsp";
				}else if(name=="fund"){
					url="jsp/cams/sorg/manage/fund/somFundCertList.jsp";
				}else if(name=="ungov"){
					url="jsp/cams/sorg/manage/ungov/somUngovCertList.jsp";
				}
				L5.Msg.alert("提示","操作成功！",function(){L5.forward(url,text);});
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else
			return;
	}
	);
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
}

//点击window里面的重新打印 跳转到打印预览页面
var sorgTypeName="";
function forRePrint(name){
	var certTypeWin=L5.getCmp("certTypeWin");
	certTypeWin.show();
	document.getElementById('certTypeSelect').value="0";//默认打印证书类型选择为正本
	sorgTypeName=name;
}
//重新打印证书，选择证书类型后的确定方法
function confirmReCertTypeWin(){
	var Certdataset=L5.DatasetMgr.lookup("Certdataset");
	var record=Certdataset.getCurrent();
	var business = encodeURIComponent(encodeURIComponent(record.get('business')));
	var url="";
	var text="";
	//获得选择打印的证书类型
	var certTypeSelected=document.getElementById("certTypeSelect").value;
	if(certTypeSelected==""||certTypeSelected==null){
		L5.Msg.alert("提示","请选择证书类型！");
		return;
	}else{
		if(sorgTypeName=="group"){
			if(record.get('ifBranch')=="0"){
				var url=pathUrl+"/jsp/cams/sorg/comm/print/groupBuildForPrint.jsp?id="+record.get('sorgId')+"&PrintDate="+record.get('signDate')+"&beginDate="+record.get('signBeginDate')+"&endDate="+record.get('signEndDate')+"&taskCode="+record.get('taskCode')+"&certType="+certTypeSelected+"&business="+business+"&organCode="+record.get('organCode');
			}else if(record.get('ifBranch')=="1"){
				var url=pathUrl+"/jsp/cams/sorg/comm/print/groupBranchBuildForPrint.jsp?id="+record.get('sorgId')+"&PrintDate="+record.get('signDate')+"&beginDate="+record.get('signBeginDate')+"&endDate="+record.get('signEndDate')+"&taskCode="+record.get('taskCode')+"&certType="+certTypeSelected;
				url+='&sorgCode='+record.get('sorgCode')+"&business="+business+"&actArea="+encodeURIComponent(encodeURIComponent(record.get('actArea')));
			}
		}else if(sorgTypeName=="fund"){
			if(record.get('ifBranch')=="0"){
				var url=pathUrl+"/jsp/cams/sorg/comm/print/fundBuildForPrint.jsp?id="+record.get('sorgId')+"&PrintDate="+record.get('signDate')+"&beginDate="+record.get('signBeginDate')+"&endDate="+record.get('signEndDate')+"&taskCode="+record.get('taskCode')+"&certType="+certTypeSelected+"&business="+business+"&organCode="+record.get('organCode')+"&checkResult="+encodeURIComponent(encodeURIComponent(record.get('checkResult')));
			}else if(record.get('ifBranch')=="1"){
				var url=pathUrl+"/jsp/cams/sorg/comm/print/fundBranchBuildForPrint.jsp?id="+record.get('sorgId')+"&PrintDate="+record.get('signDate')+"&beginDate="+record.get('signBeginDate')+"&endDate="+record.get('signEndDate')+"&taskCode="+record.get('taskCode')+"&certType="+certTypeSelected;
				url+='&sorgCode='+record.get('sorgCode')+"&business="+business+"&actArea="+encodeURIComponent(encodeURIComponent(record.get('actArea')));
			}
		}else if(sorgTypeName=="ungov"){
			var url=pathUrl+"/jsp/cams/sorg/comm/print/ungovBuildForPrint.jsp?id="+record.get('sorgId')+"&PrintDate="+record.get('signDate')+"&beginDate="+record.get('signBeginDate')+"&endDate="+record.get('signEndDate')+"&taskCode="+record.get('taskCode')+"&certType="+certTypeSelected+"&business="+business+"&organCode="+record.get('organCode');

		}
	}
	window.open(url);
}
//点击window里面的关闭按钮 关闭win
function closewin(){
	var win=L5.getCmp("Cert");
	win.hide();
}

//点击更新保存按钮 进行保存
function forSaveUpdate(dataName,name){
	var somCertDataset=L5.DatasetMgr.lookup(dataName);

	var Record=somCertDataset.getCurrent();
	var issueReasonDesc=Record.get('issueReasonDesc');
	if(issueReasonDesc.length>100){
		L5.Msg.alert("错误","无法通过校验！发证原因描述字数超过限制！");
		return;
	}
	var isValidate=somCertDataset.isValidate(true);
	if(isValidate!=true){
		L5.Msg.alert("错误","无法通过校验！"+isValidate);
		return;
	}

	L5.MessageBox.confirm('确定', '你确定要保存吗？',function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomCertSaveCmd");
			command.setParameter("somCert", Record.toBean("com.inspur.cams.sorg.base.data.SomCert"));
			command.execute("update");
			if (!command.error) {
				var url="";
				var text="";
				if(name=="group"){
					url="jsp/cams/sorg/manage/group/somGroupCertList.jsp";
				}else if(name=="fund"){
					url="jsp/cams/sorg/manage/fund/somFundCertList.jsp";
				}else if(name=="ungov"){
					url="jsp/cams/sorg/manage/ungov/somUngovCertList.jsp";
				}
				L5.Msg.alert("提示","修改成功！",function(){L5.forward(url,text);});
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else
			return;
	}
	);
}

function certDSLload(ds){
 		ds.un('load',certDSLload);
		ds.each(function(record, id){
			var borgName = record.get('borgName');
			var nowBorgName = getBorgName(borgName);
			record.set('borgName', nowBorgName);
		});
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
//打印证书，选择证书类型后的确定方法
function confirmCertTypeWin(){
	var certDataset=L5.DatasetMgr.lookup(datasetName);
	//得到文本框的内容
	var sorgCode=document.getElementById("sorgCode").value;
	var sorgName=document.getElementById("sorgName").innerHTML;
	var organCode=document.getElementById("organCode").innerHTML;
	var business=document.getElementById("businessForPrint").innerHTML;
	var residence=document.getElementById("residence").innerHTML;
	var legalPeople=document.getElementById("legalPeople").innerHTML;
	var actArea=document.getElementById("actArea").value;
	var regMon=document.getElementById("regMon").innerHTML;
	var borgName=document.getElementById("borgName").value;
	var sorgType=document.getElementById("sorgType").value;
	var morgArea=document.getElementById("morgArea").value;
	var morgName=document.getElementById("morgName").value;
	var signBeginDate=document.getElementById("signBeginDate").value;
	var signDate=document.getElementById("signDate").value;
	var printTime=document.getElementById("printTime").value;
	var printPeople=document.getElementById("printPeople").innerHTML;
	var sorgId=document.getElementById("sorgId").value;
	var signOrgan=document.getElementById('signOrgan').innerHTML;
	var sorgKind=document.getElementById("sorgKind").value;
	var ifBranch=document.getElementById("ifBranch").value;
	var checkResult="";
	if(sorgType=="J"){
		checkResult=document.getElementById("checkResult").value;
	}
	//登记日期
	var regDate=document.getElementById("regDate").innerHTML;
	//得到当前记录
	var record=certDataset.getCurrent();
	//将数据存入当前记录
	record.set('taskCode',taskCode);

	record.set('sorgCode',sorgCode);
	record.set('sorgName',sorgName);
	record.set('organCode',organCode);
	record.set('business',business);
	record.set('residence',residence);
	record.set('legalPeople',legalPeople);
	record.set('actArea',actArea);
	record.set('regMon',regMon);
	record.set('borgName',borgName);
	record.set('sorgId',sorgId);
	record.set('sorgType',sorgType);
	record.set('morgArea',morgArea);
	record.set('morgName',morgName);
	record.set('signBeginDate',signBeginDate);
	record.set('signDate',signDate);
	record.set('signOrgan',signOrgan);
	record.set('printTime',printTime);
	record.set('printPeople',printPeople);
	record.set('sorgKind',sorgKind);
	record.set('regDate',regDate);
	record.set('ifBranch',ifBranch);
	record.set('checkResult',checkResult);
	record.set('certStatus','1');
	record.set('ifReceive','0');
	//获得选择打印的证书类型
	var certTypeSelected=document.getElementById("certTypeSelect").value;
	if(certTypeSelected==""||certTypeSelected==null){
		L5.Msg.alert("提示","请选择证书类型！");
		return;
	}else{
		if(sorgType=="S"){
			if(ifBranch=="0"){
				var url=pathUrl+"/jsp/cams/sorg/comm/print/groupBuildForPrint.jsp?id="+sorgId+"&PrintDate="+printTime+"&beginDate="+signBeginDate+"&endDate="+record.get('signEndDate')+"&taskCode="+taskCode+"&certType="+certTypeSelected+"&business="+encodeURIComponent(encodeURIComponent(business))+"&organCode="+organCode;
				window.open(url);
			}else if(ifBranch=="1"){
				var openUrl=pathUrl+"/jsp/cams/sorg/comm/print/groupBranchBuildForPrint.jsp?id="+sorgId+"&PrintDate="+printTime+"&beginDate="+signBeginDate+"&endDate="+record.get('signEndDate')+"&taskCode="+taskCode+"&certType="+certTypeSelected;
				openUrl+='&sorgCode='+sorgCode+"&business="+encodeURIComponent(encodeURIComponent(business))+"&actArea="+encodeURIComponent(encodeURIComponent(actArea));
				window.open(openUrl);
			}
		}
		if(sorgType=="J"){
			if(ifBranch=="0"){
				var url=pathUrl+"/jsp/cams/sorg/comm/print/fundBuildForPrint.jsp?id="+sorgId+"&PrintDate="+printTime+"&beginDate="+signBeginDate+"&endDate="+record.get('signEndDate')+"&taskCode="+taskCode+"&certType="+certTypeSelected+"&business="+encodeURIComponent(encodeURIComponent(business))+"&organCode="+organCode+"&checkResult="+encodeURIComponent(encodeURIComponent(record.get('checkResult')));
				window.open(url);
			}else if(ifBranch=="1"){
				var openUrl=pathUrl+"/jsp/cams/sorg/comm/print/fundBranchBuildForPrint.jsp?id="+sorgId+"&PrintDate="+printTime+"&beginDate="+signBeginDate+"&endDate="+record.get('signEndDate')+"&taskCode="+taskCode+"&certType="+certTypeSelected;
				openUrl+='&sorgCode='+sorgCode+"&business="+encodeURIComponent(encodeURIComponent(business))+"&actArea="+encodeURIComponent(encodeURIComponent(actArea));
				window.open(openUrl);
			}
		}
		if(sorgType=="M"){
			var url=pathUrl+"/jsp/cams/sorg/comm/print/ungovBuildForPrint.jsp?id="+sorgId+"&PrintDate="+printTime+"&beginDate="+signBeginDate+"&endDate="+record.get('signEndDate')+"&taskCode="+taskCode+"&certType="+certTypeSelected+"&business="+encodeURIComponent(encodeURIComponent(business))+"&organCode="+organCode;
			window.open(url);
		}
	}
}
//关闭选择证书类型窗口
function closeCertTypeWin(){
	var certTypeWin=L5.getCmp("certTypeWin");
	certTypeWin.hide();
	history.go(-1);
}
//关闭重新打印证书，选择证书类型窗口
function closeReCertTypeWin(){
	var certTypeWin=L5.getCmp("certTypeWin");
	certTypeWin.hide();
	var Cert=L5.getCmp("Cert");
	Cert.hide();
}

//点击更新保存按钮 进行保存
function forSaveChange(dataName,name){
	var somCertDataset=L5.DatasetMgr.lookup(dataName);

	var Record=somCertDataset.getCurrent();
	var issueReasonDesc=Record.get('issueReasonDesc');
	if(issueReasonDesc.length>100){
		L5.Msg.alert("错误","无法通过校验！发证原因描述字数超过限制！");
		return;
	}
	var isValidate=somCertDataset.isValidate(true);
	if(isValidate!=true){
		L5.Msg.alert("错误","无法通过校验！"+isValidate);
		return;
	}

	L5.MessageBox.confirm('确定', '你确定要保存吗？',function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomCertSaveCmd");
			command.setParameter("somCert", Record.toBean("com.inspur.cams.sorg.base.data.SomCert"));
			command.execute("change");
			if (!command.error) {
				var url="";
				var text="";
				if(name=="group"){
					url="jsp/cams/sorg/manage/group/somGroupCertList.jsp";
				}else if(name=="fund"){
					url="jsp/cams/sorg/manage/fund/somFundCertList.jsp";
				}else if(name=="ungov"){
					url="jsp/cams/sorg/manage/ungov/somUngovCertList.jsp";
				}
				L5.Msg.alert("提示","换发成功！",function(){L5.forward(url,text);});
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else
			return;
	}
	);
}