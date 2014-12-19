var DOMObjects = new Object();//菜单元素
var IMGObjects = new Object();//菜单图片元素
function init(){
  if (window.DOMObjects && window.IMGObjects)
    DOMInitialize('tr');
    selectedNode(1)
}
function DOMInitialize(type) {
  if (document.getElementById){
    DOMObjects = document.getElementsByTagName(type);
    IMGObjects = document.getElementsByTagName('img');}
  else if (document.all) DOMObjects = document.all.tags(type);
  else if (document.layers) DOMObjects = document.layers;
  else DOMObjects = null;
}

function selectedNode(id){
	var frame = document.getElementById("nodeFrame");
	var url;
	if(id=='1'){//选举准备情况
		url = "cdcElectionPrepareDetail.jsp?recordId="+recordId+"&organ_Code="+organ_Code;
	}else if(id=='2'){//候选人的产生
		url = "cdcElectionNominateDetail.jsp?recordId="+recordId+"&organ_Code="+organ_Code;
	}else if(id=='3'){//正式选举
		url = "cdcElectionVoteDetail.jsp?recordId="+recordId+"&organ_Code="+organ_Code;
	}else if(id=='4'){//选举结果
		url = "cdcElectionResultDetail.jsp?recordId="+recordId+"&organ_Code="+organ_Code;
	}else if(id=='5'){//村务监督委员会情况
		url = "cdcElectionSupDetail.jsp?recordId="+recordId+"&organ_Code="+organ_Code;
	}else if(id=='6'){//村党组织成员情况
		url = "cdcElectionPartyDetail.jsp?recordId="+recordId+"&organ_Code="+organ_Code;
	}
	for(var i = 1 ; i<= 6;i++){
		var t = document.getElementById("node"+i);
		if(id == i){
			t.color = "#0000FF";
			t.style.fontWeight="bold";
		}else{
			t.color = "#000000";
			t.style.fontWeight="normal";
		}
	}
	frame.setAttribute("src", url);
}
function undo(){
	var url = "jsp/ext/cdc/manage/elect/country/cdcElectionList.jsp";
	var data=new L5.Map();
	L5.forward(url,'',data);
}