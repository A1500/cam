var DOMObjects = new Object();//菜单元素
var IMGObjects = new Object();//菜单图片元素
function init(){
  if (window.DOMObjects && window.IMGObjects)
    DOMInitialize('tr');
    selectedNode(1);
}
function DOMInitialize(type) {
	if (document.getElementById){
    	DOMObjects = document.getElementsByTagName(type);
    	IMGObjects = document.getElementsByTagName('img');
	}
  else if (document.all) DOMObjects = document.all.tags(type);
  else if (document.layers) DOMObjects = document.layers;
  else DOMObjects = null;
}
function selectedNode(id){
	var frame = document.getElementById("nodeFrame");
	var url;
	if(id=='8'){//两委
		url = "cdcElectionCommitteeEdit.jsp?recordId="+recordId+"&reportTime="+reportTime;
	}else if(id=='1'){//准备
		url = "cdcElectionPrepareEdit.jsp?recordId="+recordId+"&reportTime="+reportTime;
	}else if(id=='2'){//提名方式
		url = "cdcElectionNominateEdit.jsp?recordId="+recordId+"&reportTime="+reportTime;
	}else if(id=='3'){//正式候选人信息
		url = "cdcElectionCandidateEdit.jsp?recordId="+recordId+"&reportTime="+reportTime;
	}else if(id=='4'){//投票方式
		url = "cdcElectionVoteEdit.jsp?recordId="+recordId+"&reportTime="+reportTime;
	}else if(id=='5'){//选举程序
		url = "cdcElectionProgramEdit.jsp?recordId="+recordId+"&reportTime="+reportTime;
	}else if(id=='6'){//居委会成员组成
		url = "cdcElectionMemberEdit.jsp?recordId="+recordId+"&reportTime="+reportTime;
	}else if(id=='7'){//居民代表、居民小组长统计
		url = "cdcElectionGroupEdit.jsp?recordId="+recordId+"&reportTime="+reportTime;
	}else if(id=='9'){//居委会罢免情况
		url = "cdcElectionRecallEdit.jsp?recordId="+recordId+"&reportTime="+reportTime;
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

