var sorgTypeName="";
function forRePrint(name){
	var certTypeWin=L5.getCmp("certTypeWin");
	certTypeWin.show();
	document.getElementById('certTypeSelect').value="0";//默认打印证书类型选择为正本
	sorgTypeName=name;
}
//重新打印证书，选择证书类型后的确定方法
function confirmReCertTypeWin(){
	var certDs=L5.DatasetMgr.lookup("certDs");
	var record=certDs.getCurrent();
	var taskCode=record.get('taskCode');
	var url="";
	var text="";
	//获得选择打印的证书类型
	var certTypeSelected=document.getElementById("certTypeSelect").value;
	if(certTypeSelected==""||certTypeSelected==null){
		L5.Msg.alert("提示","请选择证书类型！");
		return;
	}else{
		if(sorgTypeName=="fit"){
			if(certTypeSelected=="0"){
				url=L5.webPath+"/jsp/cams/welfare/word/wealFitCertOForPrint.jsp?taskCode="+taskCode;
			}else if(certTypeSelected=="1"){
				url=L5.webPath+"/jsp/cams/welfare/word/wealFitCertCForPrint.jsp?taskCode="+taskCode;
			}
		}else if(sorgTypeName=="unit"){
			if(certTypeSelected=="0"){
				url=L5.webPath+"/jsp/cams/welfare/word/wealUnitCertOForPrint.jsp?taskCode="+taskCode;
			}else if(certTypeSelected=="1"){
				url=L5.webPath+"/jsp/cams/welfare/word/wealUnitCertCForPrint.jsp?taskCode="+taskCode;
			}
		}	
	}	
	window.open(url);
}
//关闭重新打印证书，选择证书类型窗口
function closeReCertTypeWin(){
	var certTypeWin=L5.getCmp("certTypeWin");
	certTypeWin.hide();
	var Cert=L5.getCmp("Cert");
	Cert.hide();
}
//保存证书后，选择证书类型后的确定方法
function confirmCertTypeWin(){
	var certDs=L5.DatasetMgr.lookup("ds");
	var record=certDs.getCurrent();
	var taskCode=record.get('taskCode');
	var url="";
	var text="";
	//获得选择打印的证书类型
	var certTypeSelected=document.getElementById("certTypeSelect").value;
	if(certTypeSelected==""||certTypeSelected==null){
		L5.Msg.alert("提示","请选择证书类型！");
		return;
	}else{
		if(sorgTypeName=="fit"){
			if(certTypeSelected=="0"){
				url=L5.webPath+"/jsp/cams/welfare/word/wealFitCertOForPrint.jsp?taskCode="+taskCode;
			}else if(certTypeSelected=="1"){
				url=L5.webPath+"/jsp/cams/welfare/word/wealFitCertCForPrint.jsp?taskCode="+taskCode;
			}
		}else if(sorgTypeName=="unit"){
			if(certTypeSelected=="0"){
				url=L5.webPath+"/jsp/cams/welfare/word/wealUnitCertOForPrint.jsp?taskCode="+taskCode;
			}else if(certTypeSelected=="1"){
				url=L5.webPath+"/jsp/cams/welfare/word/wealUnitCertCForPrint.jsp?taskCode="+taskCode;
			}
		}	
	}	
	window.open(url);
}
//保存证书后打印证书，选择证书类型窗口
function closeCertTypeWin(){
	var certTypeWin=L5.getCmp("certTypeWin");
	certTypeWin.hide();
}