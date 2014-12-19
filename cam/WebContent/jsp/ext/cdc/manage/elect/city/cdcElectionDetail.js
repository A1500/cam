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
	if(id=='8'){//两委
		url = "cdcElectionCommitteeDetail.jsp?recordId="+recordId;
	}else if(id=='1'){//准备
		url = "cdcElectionPrepareDetail.jsp?recordId="+recordId;
	}else if(id=='2'){//提名方式
		url = "cdcElectionNominateDetail.jsp?recordId="+recordId;
	}else if(id=='3'){//正式候选人
		url = "cdcElectionCandidateDetail.jsp?recordId="+recordId;
	}else if(id=='4'){//投票方式
		url = "cdcElectionVoteDetail.jsp?recordId="+recordId;
	}else if(id=='5'){//选举程序
		url = "cdcElectionProgramDetail.jsp?recordId="+recordId;
	}else if(id =='6'){//居委会组成党员比例统计
		url = "cdcElectionMemberDetail.jsp?recordId="+recordId;
	}else if(id=='7'){//居民代表、居民小组长统计
		url = "cdcElectionGroupDetail.jsp?recordId="+recordId;
	}else if(id=='9'){//居委会成员罢免情况
		url = "cdcElectionRecallDetail.jsp?recordId="+recordId;
	}
	for(var i = 1 ; i<= 9;i++){
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
	var url = "jsp/ext/cdc/manage/elect/city/cdcElectionList.jsp";
	var data=new L5.Map();
	L5.forward(url,'',data);
}