package com.inspur.cams.comm.informUtil;

import org.loushang.bsp.security.context.BspInfo;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.bsp.share.organization.OrganFactory;
import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.bsp.share.organization.provider.IOrganProvider;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.web.cmd.BaseAjaxCommand;



public class InformSessionCmd extends BaseAjaxCommand{
	private static IOrganProvider IOrgan=(IOrganProvider)OrganFactory.getIOrganProvider();
	//2010-11-20 商春德 bsp3升级到bsp5 修改
	public void getUserInfo(){

		BspInfo obj = (BspInfo)GetBspInfo.getBspInfo();
		UserInfo info = new UserInfo();
		if(obj.getEmployeeStruId()!=null){
			info.setUserId(obj.getEmployeeOrganId()==null?"nobodyid":obj.getEmployeeOrganId());
			info.setUserLoginName(obj.getUserId());
			info.setUserName(obj.getUserName());
			info.setStruId(obj.getEmployeeStruId());
			info.setStruName(obj.getUserName());

			info.setLoginCorporationId(obj.getEmployeeOrganId());
			//info.setLoginCorporationName(IOrgan.getDepartmentOfEmployee(obj.getEmployeeOrganId())[0].getOrganName());
			info.setCorporationName(info.getLoginCorporationName());
			InformPubOrganDao pubOrganDao=(InformPubOrganDao)DaoFactory.getDao(InformPubOrganDao.class);
			String  organId=obj.getDepartmentOrganId();
			String cantCode =IOrgan.getOrganByOrganId(organId).getOrganCode();
			InformPubOrgan pubOrgan=pubOrganDao.getPubOrganByOrgId(obj.getCorporationOrganId());
			info.setCorporationId(cantCode);
			info.setUserDepOrganName(OrganFactory.getIOrganProvider().getLoginUserDepartName());
			info.setUserDepOrganId(obj.getDepartmentOrganId());
			String organType=IOrgan.getOrganByOrganId(organId).getOrganType();
			info.setUserDepOrganType(organType);
			info.setUserDepstruId(IOrgan.getParent(obj.getEmployeeStruId()).getStruId());
			info.setUserDepstrutype(IOrgan.getParent(obj.getEmployeeStruId()).getOrganType());
		//	info.setUserYYDepstruId(IOrgan.getParent(IOrgan.getParent(obj.getEmployeeStruId()).getStruId()).getStruId());
			String organCode =IOrgan.getOrganByOrganId(organId).getOrganCode();
			String sj = IOrgan.getOrganByOrganId(organId).getOrganCode();
			String sjName = pubOrgan.getShortName();
			if(organCode.length()==12){
				if("0000000000".equals(organCode.substring(2, 12))){//省局登陆
					organCode = organCode.substring(0, 2);
				}else if("00000000".equals(organCode.substring(4, 12))){//市局
					organCode = organCode.substring(0, 4);
				}else if("000000".equals(organCode.substring(6, 12))){//分局（县）
					organCode = organCode.substring(0, 6);
				}else if("000".equals(organCode.substring(9, 12))){//乡
					organCode = organCode.substring(0, 9);
				}


				if(organCode.length()<=9){
					if(organCode.length()==2){
						sj=organCode+"9999999999";
					}else if(organCode.length()==4){
						sj=organCode+"99999999";
					}else if(organCode.length()==6){
						sj=organCode+"999999";
					}else if(organCode.length()==9){
						sj=organCode+"999";
					}
				    sjName+="（本级）";
				}
				}
			info.setSubOrganCode(organCode);
			info.setSjOrganCode(sj);
			info.setSjOrganName(sjName);





			if(pubOrgan!=null){
				info.setCantCode(pubOrgan.getOrganCode());
				//info.setCantName(pubOrgan.getOrganName());
				info.setCantName(pubOrgan.getShortName());

			}
		}else{
			info.setUserId(obj.getUserId());
			info.setUserLoginName(obj.getUserId());
			info.setUserName(obj.getUserName());
			info.setStruId("1");

			info.setStruName("根机构");
			info.setLoginCorporationId("1");
			info.setLoginCorporationName("根机构");
			info.setCorporationName("根机构");
			info.setCorporationId("1");
			info.setUserDepOrganName("根机构");
			info.setUserDepOrganId("1");
			info.setUserDepOrganType("1");
			info.setUserDepstruId("1");


			InformPubOrganDao pubOrganDao=(InformPubOrganDao)DaoFactory.getDao(InformPubOrganDao.class);

			InformPubOrgan pubOrgan=pubOrganDao.getPubOrganByOrgId(obj.getCorporationOrganId());


			if(pubOrgan!=null){
				info.setCantCode(pubOrgan.getOrganCode());
			//	info.setCantName(pubOrgan.getOrganName());
				info.setCantName(pubOrgan.getShortName());
			}else{
				info.setCantCode("1");
				info.setCantName("根机构");
			}

		}



		//info.setCantName(obj.getDepartment().getOrgan().getWorkplace().getCant().getCantName());
		this.setReturn("userInfo", info);
	}
	
	public void getRootUserInfo() {
		BspInfo bspInfo = (BspInfo) GetBspInfo.getBspInfo();
		StruView[] sv = IOrgan.getAllTop(IOrgan.getCorporation(bspInfo.getEmployeeStruId()).getStruType());
		StruView sv2 = sv[0];
		UserInfo info = new UserInfo();
		info.setCantCode(sv2.getOrganCode());
		info.setCantName(sv2.getOrganName());
		info.setUserDepOrganType(sv2.getOrganType());
		this.setReturn("userInfo", info);
	}
	
	
	public static class UserInfo{
		private String userId;
		private String userName;
		private String userLoginName;
		private String struName;
		private String struId;
		private String corporationId;
		private String corporationName;
		private String loginCorporationId;
		private String loginCorporationName;
		private String userDepOrganName;
		private String cantCode;
		private String cantName;
		private String userDepOrganId;
		private String userDepOrganType;
		private String userDepstruId;
		private String userDepstrutype;
		private String userYYDepstruId;
		private String subOrganCode;
		private String sjOrganCode;
		private String sjOrganName;

		public String getUserId() {
			return userId;
		}
		public void setUserId(String userId) {
			this.userId = userId;
		}
		public String getUserName() {
			return userName;
		}
		public void setUserName(String userName) {
			this.userName = userName;
		}
		public String getStruName() {
			return struName;
		}
		public void setStruName(String struName) {
			this.struName = struName;
		}
		public String getStruId() {
			return struId;
		}
		public void setStruId(String struId) {
			this.struId = struId;
		}
		public String getCorporationId() {
			return corporationId;
		}
		public void setCorporationId(String corporationId) {
			this.corporationId = corporationId;
		}
		public String getCorporationName() {
			return corporationName;
		}
		public void setCorporationName(String corporationName) {
			this.corporationName = corporationName;
		}
		public String getLoginCorporationId() {
			return loginCorporationId;
		}
		public void setLoginCorporationId(String loginCorporationId) {
			this.loginCorporationId = loginCorporationId;
		}
		public String getLoginCorporationName() {
			return loginCorporationName;
		}
		public void setLoginCorporationName(String loginCorporationName) {
			this.loginCorporationName = loginCorporationName;
		}
		public String getUserLoginName() {
			return userLoginName;
		}
		public void setUserLoginName(String userLoginName) {
			this.userLoginName = userLoginName;
		}
		public String getUserDepOrganName() {
			return userDepOrganName;
		}
		public void setUserDepOrganName(String userDepOrganName) {
			this.userDepOrganName = userDepOrganName;
		}
		public String getCantCode() {
			return cantCode;
		}
		public void setCantCode(String cantCode) {
			this.cantCode = cantCode;
		}
		public String getCantName() {
			return cantName;
		}
		public void setCantName(String cantName) {
			this.cantName = cantName;
		}
		public String getUserDepOrganId() {
			return userDepOrganId;
		}
		public void setUserDepOrganId(String userDepOrganId) {
			this.userDepOrganId = userDepOrganId;
		}
		public String getUserDepOrganType() {
			return userDepOrganType;
		}
		public void setUserDepOrganType(String userDepOrganType) {
			this.userDepOrganType = userDepOrganType;
		}
		public String getUserDepstruId() {
			return userDepstruId;
		}
		public void setUserDepstruId(String userDepstruId) {
			this.userDepstruId = userDepstruId;
		}
		public String getUserYYDepstruId() {
			return userYYDepstruId;
		}
		public void setUserYYDepstruId(String userYYDepstruId) {
			this.userYYDepstruId = userYYDepstruId;
		}
		public String getUserDepstrutype() {
			return userDepstrutype;
		}
		public void setUserDepstrutype(String userDepstrutype) {
			this.userDepstrutype = userDepstrutype;
		}
		public String getSubOrganCode() {
			return subOrganCode;
		}
		public void setSubOrganCode(String subOrganCode) {
			this.subOrganCode = subOrganCode;
		}
		public String getSjOrganCode() {
			return sjOrganCode;
		}
		public void setSjOrganCode(String sjOrganCode) {
			this.sjOrganCode = sjOrganCode;
		}
		public String getSjOrganName() {
			return sjOrganName;
		}
		public void setSjOrganName(String sjOrganName) {
			this.sjOrganName = sjOrganName;
		}


	}
}
