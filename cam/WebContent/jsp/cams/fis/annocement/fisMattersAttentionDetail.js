/**
 *  页面加载后自动运行，进行初始化事件等操作。
 */
function init(){
	var fisMattersAttention=L5.DatasetMgr.lookup("fisMattersAttention");
		  fisMattersAttention.setParameter("ATTENTION_ID@=",attentionId);
		  fisMattersAttention.load(true);
    var attentionTitle = fisMattersAttention.get("attentionTitle");
    var attentionType = fisMattersAttention.get("attentionType");
    var attentionEmerg = fisMattersAttention.get("emergencyDegree");
    var attentionContents = fisMattersAttention.get("attentionContents");
    var faceWhat=fisMattersAttention.get("toOrganFis");
    var attentionTime = fisMattersAttention.get("attentionTime");
			document.getElementById("title").value=attentionTitle;//标题
			document.getElementById("content").innerHTML=attentionContents;//内容
				if(attentionEmerg=="notify_normal"){
				   document.getElementById("emergencyDegree").value="一般通知";//紧急程度
				}else if(attentionEmerg=="notify_urgent"){
				   document.getElementById("emergencyDegree").value="紧急通知";
				}else{
					document.getElementById("emergencyDegree").value="公告";
				}
	if(attentionType=="releasing"){
		document.getElementById("informtype").value="发布性";//通知类型
	}
	if(attentionType=="approve"){
		document.getElementById("informtype").value="批转性";//通知类型
	}
	if(attentionType=="forwarding"){
		document.getElementById("informtype").value="转发性";//通知类型
	}
	if(attentionType=="directive"){
		document.getElementById("informtype").value="指示性";//通知类型
	}
	if(attentionType=="removal"){
		document.getElementById("informtype").value="任免性";//通知类型
	}
	if(attentionType=="transactional"){
		document.getElementById("informtype").value="事务性";//通知类型
	}
	document.getElementById("sendmanid").value=faceWhat;//面向单位
	document.getElementById("attentionTime").value=attentionTime;
}

/*
 * 点击【返回】
 */
function click_back(){
		window.location="fisMattersAttentionList.jsp";
}
