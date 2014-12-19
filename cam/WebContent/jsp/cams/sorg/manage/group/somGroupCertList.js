function init(){
	L5.QuickTips.init();
}
//点击打印证书 跳转到增加页面
/*function printcert(){
	var text="";
	var url="jsp/cams/sorg/manage/group/somGroupCertPrint.jsp";
	L5.forward(url,text);
}*/
//点击增加证书信息按钮跳转到增加页面
function insert(){
	var text="";
	var url="jsp/cams/sorg/manage/group/somGroupCertInsert.jsp";
	L5.forward(url,text);
}

//修改证书信息
function updateCert(){
		var grid = L5.getCmp('hlistPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
			var id=records[0].get("id");
			var url="jsp/cams/sorg/manage/group/somGroupCertUpdate.jsp?id="+id;
			var text = '修改证书信息';
			L5.forward(url,text);
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
}
//换发证书信息
function changeCert(){
		var grid = L5.getCmp('hlistPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
			if(records[0].get("certStatus")!="1"){
				L5.Msg.alert("提示","该证书不是有效状态，不能进行换发！");
				return;
			}
			var id=records[0].get("id");
			var url="jsp/cams/sorg/manage/group/somGroupCertChange.jsp?id="+id;
			var text = '换发证书信息';
			L5.forward(url,text);
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
}
//把社会组织名称变为一个超级链接
function jtxxDetailHref(value,cellmeta,record,rowindex,colindex,dataset){
	var ds=L5.DatasetMgr.lookup("somGroupCertDataset");
	return '<a href="javascript:jtxxDetail(\'' + ds.indexOf(record) + '\')">' + value + '</a>';
}
//超级链接所调用的方法
 function jtxxDetail(index){
   	var ds=L5.DatasetMgr.lookup("somGroupCertDataset");
   	var record= ds.getAt(index);
   	var certStatus=record.get('certStatus');
   	var id=record.get('id');
   	var certdataset=L5.DatasetMgr.lookup("Certdataset");
  	certdataset.setParameter("id@=",id);
   	certdataset.load();
   	certdataset.on("load",certDSLload);
   	var Cert=L5.getCmp("Cert");
	Cert.show();
	document.getElementById("receive").style.display='none';
	if(certStatus==0){
		document.getElementById("receive").style.display='block';
	}
	document.getElementById('id').value=id;
	
	
 }


//点击window里面的重新打印 跳转到打印预览页面
function rePrint(){
	forRePrint("group");
}
 //点击查询 返回查询结果
 function query(){
	 forQuery("somGroupCertDataset");
 }
 //点击收回证书 修改证书信息的状态
 function reclaim(){
	 forReclaim("group");
 }
 //点击发证按钮 弹出发证window
 function certF(){
 	forCertF("Certdataset");
 }

 //点击发证 处理发证事务
 function signcert(){
 	forSigncert("Certdataset","group");
 }
 //点击制证作废
function zzzf(){
	forZzzf("group");
}
//点击宣布作废
function xbzf(){
	forXbzf("group");
}
//打印预设
function forPrintDemo(){
	var win=L5.getCmp("printDemo");
	win.show();
}
//关闭该窗口
function closeP(){
	var win=L5.getCmp("printDemo");
	win.hide();
}
//进入打印预设页面
function inPrintDemo(){
	var num=document.getElementById('printCertType').value;
	if(num==''){L5.Msg.alert("错误","请选择证件类型！");return;}
	var url='';
	var text='';
	if(num==0){
		url="jsp/cams/sorg/manage/group/somGroupCertPrintView.jsp?id=ss";	
	}else if(num==1){
		url="jsp/cams/sorg/manage/group/somGroupCertPrintView.jsp?id=ss";
	}else if(num==2){
		url="jsp/cams/sorg/manage/group/somGroupCertPrintView.jsp?id=ss";
	}else if(num==3){
		url="jsp/cams/sorg/manage/group/somGroupCertPrintView.jsp?id=ss";
	}
	
	L5.forward(url,text);
}