//var $ = document;
var biz;
var processid;
var mainfname = "fj";

var cell;
var c = 0;
var cc = 0;

var flashname = "l-upload-flash-"+mainfname;
function isIE(){
	if(navigator.appName.indexOf("Microsoft") != -1) {
		return true;
	}
	else{
		return false;
	}
}
function getFlash() {
		if(isIE()==true) {
			return document.getElementById(flashname);
			
		} else {
			return document[flashname];
		}
}

function file(id , name){
	this.id = id;
	this.name = name;
}

function createNewFileDiv(fname , attname , filename , size , filetype){
	var attInfo = new AttInfo(fname , attname , filename , size , filetype);
	addAttach("attachTable" , attInfo);
}
//在附件上传完毕后自动调用
function uploadCompleteData(fname,attname,filename,size,filetype,uuid){
	var fileProgress = new FileProgress(attname+"-pro" , attname+"-container");
	var attInfo = new AttInfo(fname,attname,filename,size,filetype,uuid);
	fileProgress.complete(1000 , attInfo);
	
	getFlash().save(null);
}
	
//在附件上传进度变化时自动调用，可以用于进度条，上传状态等
function createProgressBar(a,h){
	var fileProgress = new FileProgress(a+"-pro" , a+"-container");
	fileProgress.setProgress(h);
}
//上传控件初始化时自动调用
function getParameter(parname){
	var biz = document.getElementById("attachment-biz").value;
	var processid = document.getElementById("attachment-processid").value;
	var encryption = document.getElementById("attachment-encryption").value;
	var bizclass = document.getElementById("attachment-bizclass").value;
	var filecount = document.getElementById("attachment-filecount").value;
	var filestored = document.getElementById("attachment-filestored").value;
	var filestoredsize = document.getElementById("attachment-filestoredsize").value;
	var fileselectcount = document.getElementById("attachment-fileselectcount").value;
	getFlash().setParameter("biz",biz);
	getFlash().setParameter("processid",processid);
	getFlash().setParameter("encryption",encryption);
	getFlash().setParameter("bizclass",bizclass);
	getFlash().setProperty("filecount",filecount);
	getFlash().setProperty("filestored",filestored);
	getFlash().setProperty("filestoredsize",filestoredsize);
	getFlash().setProperty("fileselectcount",fileselectcount);
}
//选择删除
function delMe(uuid){
	getFlash().removeRemoteFile(uuid);
}


function fdel(p,a){
	getFlash().removeFile(a);
	//中断传输后中断 隐藏进度条信息
	
	
}

function calldelbyuuid(u){
	document.getElementById(u).style.display = "none";
}

function Evt_butremove_click(){
	var uploadGridPanel = L5.getCmp('uploadGridPanel');
	var sm = uploadGridPanel.getSelectionModel();
	cell = sm.getSelections();
	cc = cell.length;
	if(cell==null || cell.length == 0){
		L5.Msg.alert("提示","请选择一条记录");
		return;
	}
	L5.MessageBox.confirm("提示","确认删除所选邮件?",
		function(sta){
			if(sta ==='yes'){
				if(cell[0]!=null){
					delMe(cell[0].get("fileID"));
				}
			}else{
				return;
			}
	});
}
function calldel(att){
	document.getElementById(att).style.display = "none";
}
function cancel(a){
	
}
function delAtt(uuid){
	getFlash().removeRemoteFile(uuid);
}
//上传未上传的附件
function upload(name,url){
	getFlash().save(url);
}
//设定初始化参数，参数为控件的name、业务分类、流程ID
function setInitParameter(bizt,processidt){
	biz = bizt;
	processid = processidt;
}

function OnUploadHttpError(e){callAlert(e);}

function OnUploadIOError(e){callAlert(e);}

function OnUploadSecurityError(e){callAlert(e);}

function OnUploadTotalFileSizeLimitReached(e){callAlert(e);}

function OnUploadFileSizeLimitReached(e){callAlert(e);}
function callAlert(o){
	L5.Msg.alert("警告",o);
}