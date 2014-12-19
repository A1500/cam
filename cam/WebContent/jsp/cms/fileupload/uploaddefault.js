var $ = document;
var mainfname = "fj";
var flashname = "l-upload-flash-"+mainfname;
var cmsLinkStyle  = "font:12px arial, tahoma, helvetica, sans-serif; text-decoration: underline; color:#0000FF;";
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

var fid = 0;
var f_progress_name = "";
var f_progress_count = 0;
var f_updated_count = 1;
var f_updated_name = new Array();
function file(id , name){
	this.id = id;
	this.name = name;
}
function createNewFileDiv(fname,attname,filename,size,filetype){
	add(fname,attname,attname,filename,size,filetype);
	//if(f_progress_count == 0)
	//	pop();
	//f_updated_name[f_progress_count] = 	filename;
	//f_progress_count++;
	//var fileid = "fileid" + fid;
	//var f = new file(fileid , f_updated_name[f_updated_count - 1]);
	//
	//var progress = new FileProgress(f, "fsUploadProgress");
	//progress.setStatus("wait..." + "(" + f_updated_count + "/" + f_progress_count + ")");
	//var args = new Array(fname , attname);
	//progress.toggleCancel(true , "fdel" , args , 2);
}
function add(fname,att,divid,filename,size,filetype){
	addTR(fname,"att",att,divid,filename,size,filetype);
}
function addTR(fname,table,att,divid,filename,size,filetype){
	var tr = $.createElement("tr");
	tr.setAttribute("id",att);
	tr.className = "FieldInput";
	//addTD(tr,divid);
	addTD(tr,filename);
	addTD(tr,filetype);
	addTD(tr,size);
	addTD(tr,"<div id='"+att+"-processbar"+"' style='backgroundColor: #FF0000;width: 0%'>0%</div>");
	addTD2(tr,"等待",att,"stat");
	//addTD2(tr,"",att,"uuid");
	//addTD(tr,"<a href=\"javascript:void(0);\" onclick=\"(fdel('"+fname+"','"+att+"'))\">删除</a>");
	addTD(tr,"<div onclick=\"(fdel('"+fname+"','"+att+"'))\" class=\"cmsDelLink\">删除</div>");
	if(isIE()==true){
		$.getElementById(table).childNodes[0].appendChild(tr);
	}
	else{
		$.getElementById(table).childNodes[1].appendChild(tr);
	}
}
function addTD2(tr,value,att,type){
	var td = $.createElement("td");
	td.setAttribute("id",att+"-"+type);
	td.innerHTML = value;
	tr.appendChild(td);
}
function addTD(tr,value){
	var td = $.createElement("td");
	td.innerHTML = value;
	tr.appendChild(td);
}
function fdel(p,a){
	getFlash().removeFile(a);
}
function calldel(a){
	if(isIE()){
		$.getElementById(a).removeNode(true);
	}
	else{
		var aa = $.getElementById(a);
		aa.parentNode.removeChild(aa);
	}
}
function calldelbyuuid(u){
	if(isIE()){
		$.getElementById(u).removeNode(true);
	}
	else{
		var aa = $.getElementById(u);
		aa.parentNode.removeChild(aa);
	}
}
function cancel(a){
	
}
function upload(name,url){
	getFlash().save(url);
}
function getElementValue(id){
	return $.getElementById(id).value;
}
function getParameter(parname){
	var biz = getElementValue("attachment-biz");
	var processid = getElementValue("attachment-processid");
	var encryption = getElementValue("attachment-encryption");
	var bizclass = getElementValue("attachment-bizclass");
	var filecount = getElementValue("attachment-filecount");
	var filestored = getElementValue("attachment-filestored");
	var filestoredsize = getElementValue("attachment-filestoredsize");
	var fileselectcount = getElementValue("attachment-fileselectcount");
	var creatorid = getElementValue("attachment-creatorid");
	
	getFlash().setParameter("biz",biz);
	getFlash().setParameter("processid",processid);
	//getFlash().setParameter("encryption",encryption);
	getFlash().setParameter("bizclass",bizclass);
	if(creatorid != null){
		getFlash().setParameter("creatorid",creatorid);
		//getFlash().setParameter("creatorname",creatorname);
	}
	getFlash().setProperty("filecount",filecount);
	getFlash().setProperty("filestored",filestored);
	getFlash().setProperty("filestoredsize",filestoredsize);
	getFlash().setProperty("fileselectcount",fileselectcount);
}

function createProgressBar(a,h){
	//alert(h);
	$.getElementById(a+"-processbar").style.cssText = "width:"+h+"%";
	$.getElementById(a+"-processbar").style.backgroundColor ="#01DF74";
	$.getElementById(a+"-processbar").innerHTML = h+"%";
	$.getElementById(a+"-stat").innerHTML = "正在上传";
	if(h == 100){
		$.getElementById(a+"-"+"stat").innerHTML = "完成";
	}
	
	
	//var fileid = "fileid" + fid;
	//var f = new file(fileid , f_updated_name[f_updated_count - 1]);
	//var progress = new FileProgress(f, "fsUploadProgress");
	//progress.setProgress(parseInt(h));
	//progress.setStatus("Uploading" +  h + "%" + "(" + f_updated_count + "/" + f_progress_count + ")" );
	//if(h == 100){
	//	document.getElementById(a+"-"+"stat").innerHTML = "Finished";
	//	progress.setStatus("Complete" + "(" + f_updated_count + "/" + f_progress_count + ")");
	//	progress.toggleCancel(true , null , null , null);
	//}
}
function formatTime(time){
	var year = time.substr(0,4);
	var month = time.substr(4,2);
	var day = time.substr(6,2);
	var hour = time.substr(9,2);
	var min = time.substr(12,2);
	var sec = time.substr(15,2);
	return year+"年"+month+"月"+day+"日"+hour+"时"+min+"分"+sec+"秒";
}
function uploadCompleteData(fname,attname,filename,size,filetype,uuid,time){
	//alert("上传完毕"+a);
	createProgressBar(attname,100);
	var creatorname = getElementValue("attachment-creatorname");
	addTR2(fname,"att-complete",filename,size,filetype,uuid,time,creatorname);
	
	//alert(time);
	//alert(formatTime(time));
	//alert(decodeURI(creator));
	//var fileid = "fileid" + fid;
	//var f = new file(fileid , f_updated_name[f_updated_count - 1]);
	//var progress = new FileProgress(f, "fsUploadProgress");
	//progress.setComplete();
	//progress.setCancelled();

	//if(f_updated_count == f_progress_count)
	//{
	//	f_progress_count = 0;
	//	f_updated_count = 1;
	//	hide();
	//	return;
	//}
	//f_updated_count++;
	
	
	
	
	getFlash().save(null);
}
function addTR2(fname,table,filename,size,filetype,uuid,time,creator){
	var tr = $.createElement("tr");
	tr.setAttribute("id",uuid);
	tr.className = "FieldInput";
	//addTD(tr,"<a href=\"javascript:void(0);\" onclick=\"fdown('"+uuid+"')\">"+filename+"</a>");
	//addTD(tr,"<div  onclick=\"fdown('"+uuid+"')\" style=\""+ cmsLinkStyle +"\">"+filename+"</div>");
	addTD(tr,"<div  onclick=\"fdown('"+uuid+"')\" class=\"cmsDelLink\">"+filename+"</div>");
	//alert(filename+filetype+size);
	addTD(tr,filetype);
	addTD(tr,size);
	//addTD(tr,"<a href=\"javascript:void(0);\" onclick=\"fdelbyuuid('"+uuid+"')\">删除</a>");
	//addTD(tr,"<div onclick=\"fdelbyuuid('"+uuid+"')\" style=\"" + cmsLinkStyle + "\">删除</div>");
	
	addTD(tr,decodeURI(creator));
	addTD(tr,formatTime(time));
	addTD(tr,"<div onclick=\"fdelbyuuid('"+uuid+"')\" class=\"cmsDelLink\">删除</div>");
	
	if(isIE()==true){
		$.getElementById(table).childNodes[0].appendChild(tr);
	}
	else{
		$.getElementById(table).childNodes[1].appendChild(tr);
	}
}
function fdelbyuuid(uuid){
	if(!confirm("确认删除文件?")) 
    {
         return;
    }
	getFlash().removeRemoteFile(uuid);
}
function fdown(uuid){
	getFlash().downloadFile(uuid);
}
function downloadByURL(url){
	var downloadFrame = document.getElementById("downloadFrame");
	//alert(url);
	//var elemIF = document.createElement("iframe");   
	downloadFrame.src = url;   
	//elemIF.style.display = "none";   
	//document.body.appendChild(elemIF);
	//window.open(url);
}
function downloadByUuids(uuids){
	var downloadFrame = document.getElementById("downloadFrame");
	//alert(url);
	//var elemIF = document.createElement("iframe");
	downloadFrame.src = L5.webPath+"/UploadServlet?method=downloadall&uuids="+uuids;
	//elemIF.style.display = "none";
	//document.body.appendChild(elemIF);
	//window.open(url);
}
function downloadall(){
	var uuids = "";
	var t = document.getElementById("att-complete");
	for(var i=1;i<t.rows.length;i++){
		uuids+=t.rows[i].id;
		if(i!=t.rows.length-1){
			uuids+=",";
		}
	}
	if(uuids != ""){
		downloadByUuids(uuids);
	}
	else{
		callAlert("没有可下载附件");
	}
}
function OnUploadHttpError(e){alert(e);}

function OnUploadIOError(e){alert(e);}

function OnUploadSecurityError(e){alert(e);}

function OnUploadTotalFileSizeLimitReached(e){alert(e);}

function OnUploadFileSizeLimitReached(e){alert(e);}
function callAlert(o){
	//if(isIE()){
	//	alert(o);
	//}
	//else{
	//	showInfo(o);
	//}
	L5.Msg.alert("警告",o);
}
function showInfo(info){
	document.getElementById("showinfo").innerHTML=info;
}