var $=document;var ce=function(e){$.createElement(e);}
var ge=function(e){$.getElementById(e);}
function createNewFileDiv(name){var fileInfo=$.getElementById("l-upload-flash-"+name).getFileInfo();var attDiv=$.createElement("div");attDiv.setAttribute("id","l-div-"+name);for(var i=0;i<fileInfo.length;i++){var progressDiv1=$.createElement("div");var progressDiv2=$.createElement("div");var progressDiv3=$.createElement("div");var ranId=createRanId();progressDiv2.className="dQ";progressDiv3.className="dR";progressDiv3.setAttribute("id","l-progress-"+name+"-"+i);progressDiv3.style.cssText="width:0%";progressDiv2.appendChild(progressDiv3);var span=$.createElement("a");span.innerHTML=fileInfo[i][0]+" "+fileInfo[i][2];progressDiv1.appendChild(span);progressDiv1.appendChild(progressDiv2);var delSpan=$.createElement("span");var delBtn=$.createElement("a");delBtn.innerHTML="\u53d6\u6d88 ";delBtn.href="javascript:fdel("+"'"+name+"'"+",'"+ranId+"')";delSpan.appendChild(delBtn);progressDiv1.appendChild(delSpan);progressDiv1.setAttribute('id',"l-div-file-"+ranId);attDiv.appendChild(progressDiv1);}
$.getElementById('l-upload-div-'+name).appendChild(attDiv);}
function fdel(n,i){$.getElementById("l-upload-flash-"+n).onCancelUpload();$.getElementById("l-div-file-"+i).removeNode(true);}
function createProgressBar(n,i,h){$.getElementById("l-progress-"+n+"-"+i).style.cssText="width:"+h+"%";}
function uploadCompleteData(n,i){$.getElementById("l-progress-"+n+"-"+i).parentElement.parentElement.firstChild.href="";$.getElementById("l-progress-"+n+"-"+i).parentElement.removeNode(true);}
function OnUploadHttpError(e){alert(e);}
function OnUploadIOError(e){alert(e);}
function OnUploadSecurityError(e){alert(e);}
function OnUploadTotalFileSizeLimitReached(e){alert(e);}
function OnUploadFileSizeLimitReached(e){alert(e);}
function createRanId(){var id="";var selectArray=new Array(0,'d',1,'D',2,'l',3,'L',4,'q',5,'Q',6,'y',7,'Y',8,'t',9,'T');for(var i=0;i<7;i++){var index=Math.floor(Math.random()*10);id+=selectArray[index];}return id;}