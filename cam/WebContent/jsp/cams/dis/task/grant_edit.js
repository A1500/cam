var allUseFunds=0.0;
var allUseFoods=0.0;
var allUseClothes=0.0;

var grantFunds=0.0;
var grantFoods=0.0;
var grantClothes=0.0;

function init() {
	amountds.setParameter("BATCH_DETAIL_ID@=",batchDetailId);	
	amountds.setParameter("RELIEF_TYPE@=",reliefType);
	amountds.setParameter("WORKFLOW_STATUS@!=",'4');
	amountds.on('load', function(){
		if(amountds.getCount()>0) {
			document.getElementById("funds").innerText = formatNum(amountds.get("MONRY_AMOUNT"));
			document.getElementById("foods").innerText = (amountds.get("FOOD_AMOUNT"));
			document.getElementById("clothes").innerText = (amountds.get("CLOTHES_AMOUNT"));
		}
	});
	amountds.load(true);
	
	grantDs.on("load", function() {
		allUseFunds=disFundsSourceDs.getAt(0).get("M");
		allUseFoods=disFundsSourceDs.getAt(0).get("F");
		allUseClothes=disFundsSourceDs.getAt(0).get("C");
		if(grantDs.getCount()>0) {
			var rec = grantDs.getAt(0);
			grantFoods+=parseFloat(rec.get("DCFOOD"));
			grantClothes+=parseFloat(rec.get("DCCLOTHES"));
			grantFunds+=parseFloat(rec.get("DCMONEY"));
			grantFoods+=parseFloat(rec.get("YJFOOD"));
			grantClothes+=parseFloat(rec.get("YJCLOTHES"));
			grantFunds+=parseFloat(rec.get("YJMONEY"));
			grantFoods+=parseFloat(rec.get("GDFOOD"));
			grantClothes+=parseFloat(rec.get("GDCLOTHES"));
			grantFunds+=parseFloat(rec.get("GDMONEY"));
			grantFunds+=parseFloat(rec.get("SWMONEY"));
			grantFunds+=parseFloat(rec.get("CJMONEY"));
		}
//		alert(allUseFunds+" "+allUseFoods+" "+allUseClothes)
//		alert(grantFunds+" "+grantFoods+" "+grantClothes)
		document.getElementById("useFunds").innerText = formatNum(allUseFunds-grantFunds);
		document.getElementById("useFoods").innerText = (allUseFoods-grantFoods);
		document.getElementById("useClothes").innerText = (allUseClothes-grantClothes);
		isCompare();
	});
	
	disFundsSourceDs.setParameter("qOrganCode", organCode);
	disFundsSourceDs.setParameter("qDisYear", "2013");
	disFundsSourceDs.on("load", function() {
				if(disFundsSourceDs.getCount()>0) {
					grantDs.setParameter("xzqu",organCode);
					grantDs.setParameter("ffsjq", "2013-01-01");
					grantDs.setParameter("ffsjz", "2013-12-31");
					grantDs.load();
				}
			});
	disFundsSourceDs.load();
			
	document.getElementById("grantPeopleName").value = currentUserName;
	document.getElementById("grantTime").value = day;
//	L5.QuickTips.init();
};
//比较是否满足发放要求
function isCompare() {
//	grantBtn
	document.getElementById("grantBtn").style.display='none';
	var flag = true;
	if(parseFloat(document.getElementById("useFunds").innerText)<parseFloat(document.getElementById("funds").innerText)) {
		flag = false;
		document.getElementById("useFunds").style.color='red';
	}
	if(parseFloat(document.getElementById("useFoods").innerText)<parseFloat(document.getElementById("foods").innerText)) {
		flag = false;
		document.getElementById("useFoods").style.color='red';
	}
	if(parseFloat(document.getElementById("useClothes").innerText)<parseFloat(document.getElementById("clothes").innerText)) {
		flag = false;
		document.getElementById("useClothes").style.color='red';
	}
	if(flag)
		document.getElementById("grantBtn").style.display='';
}

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function save() {
	L5.MessageBox.confirm('确定', '确定要发放吗?', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefTaskCommand");
			command.setParameter("grantPeopleName",getParam("grantPeopleName"));
			command.setParameter("grantTime", getParam("grantTime"));
			command.setParameter("batchDetailId", batchDetailId);
			command.execute("grant");
			if (!command.error) {
				L5.Msg.alert('提示',"发放成功!",function(){
					window.returnValue = "T";
					window.close();
				});
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}
