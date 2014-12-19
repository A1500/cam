
/**
 * 前台session对象
 * @class L5.session
 */
L5.session = {};
/**
 * 获得用户信息，暂不可用
 * @method getUserInfo
 * @private
 * @return {Object} 用户信息
 */
L5.session.getUserInfo = function() {
	if (sameDomain&&top.userInfo != null){
		return top.userInfo;
	}
	var command=new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserCmd");
	command.execute("getLoginUserInfo");
	//判断返回值，如果返回的不是true，
	if (!command.error) {
		var info = command.getReturn("loginInfo");
		if(sameDomain){
		top.userInfo=info;
		}
		return info;
	} else {
		//如果有问题，alert出异常。
		  alert("用户没有登录！");
	}
}