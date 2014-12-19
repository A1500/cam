package com.inspur.cams.comm.util;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.bsp.security.data.GetUser;
import org.loushang.bsp.share.organization.OrganFactory;
import org.loushang.bsp.share.organization.bean.OrganView;
import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.bsp.share.organization.provider.IOrganProvider;
import org.loushang.bsp.share.permit.bean.RoleView;
import org.loushang.bsp.share.permit.security.SecurityFactory;
import org.loushang.bsp.share.permit.security.provider.ISecurityProvider;

/**
 * Bsp工具类，获取当前登录人Bsp信息
 * @author shgtch
 * @date 2011-5-10
 */
public class BspUtil {

	// 省级组织机构类型
	public static String PROVINCE = "11";
	
	// 市级组织机构类型
	public static String CITY = "12";
	
	// 县级组织机构类型
	public static String TWON = "13";
	
	public static String EMPLOYEE = "8";
	
	public static String EMPLOYEE_CN = "员工";
	
	public static String DEFAULT_STRU_TYPE = "00";
	
	// 获取Bsp接口
	private static IOrganProvider op = OrganFactory.getIOrganProvider();

	/**
	 * 获取当前登录单位Id
	 * @return
	 */
	public static String getCorpOrganId() {
		return GetBspInfo.getBspInfo().getCorporationOrganId();
	}

	/**
	 * 获取当前登录单位OrganView
	 * @return
	 */
	public static OrganView getCorpOrgan() {
		return op.getOrganByOrganId(getCorpOrganId());
	}

	/**
	 * 获取当前登录部门Id
	 * @return
	 */
	public static String getDeptOrganId() {
		return GetBspInfo.getBspInfo().getDepartmentOrganId();
	}

	/**
	 * 获取当前登录部门OrganView
	 * @return
	 */
	public static OrganView getDeptOrgan() {
		return op.getOrganByOrganId(getDeptOrganId());
	}

	/**
	 * 获取当前登录人Id
	 * @return
	 */
	public static String getEmpOrganId() {
		return GetBspInfo.getBspInfo().getEmployeeOrganId();
	}

	/**
	 * 获取当前登录人OrganView
	 * @return
	 */
	public static OrganView getEmpOrgan() {
		return op.getOrganByOrganId(getEmpOrganId());
	}

	/**
	 * 获取当前登录单位上级单位OrganView
	 * @modify shgtch 当未顶级单位时，返回本单位OrganView
	 * @return
	 */
	public static OrganView getParentOrgan(){
		String parentId = op.getListByOrganId(GetBspInfo.getBspInfo().getCorporationOrganId())[0].getParentId();
		if ("rootId".equals(parentId)) {
			return getCorpOrgan();
		} else {
			return op.getOrganByOrganId(parentId);
		}
	}

	/**
	 * 获取当前登录单位平级单位OrganView列表
	 * @return
	 */
	public static OrganView[] getSameOrgan(){
		return op.getUnderLingByOrganId(op.getListByOrganId(GetBspInfo.getBspInfo().getCorporationOrganId())[0].getParentId(),"1","00");
	}

	/**
	 * 获取当前登录单位下级单位OrganView列表
	 * @return
	 */
	public static OrganView[] getUnderOrgan(){
		return op.getUnderLingByOrganId(GetBspInfo.getBspInfo().getCorporationOrganId(),"2","00");
	}

	/**
	 * 获得当前登录人所在单位StruView
	 */
	public static StruView getCorpStru(){
		return op.getCorporation(GetBspInfo.getBspInfo().getEmployeeStruId());
	}

	/**
	 * 获取当前登录单位组织结构Id
	 */
	public static String getCorpStruId() {
		return getCorpStru().getStruId();
	}

	/**
	 * 获得当前登录人所在单位上级单位OrganId
	 */
	public static String getParentOrganId(){
		return getCorpStru().getParentId();
	}

	/**
	 * 获得当前登录人所在单位上级单位StruId
	 */
	public static String getParentStrId(){
		StruView[] struView = op.getListByOrganId(getParentOrganId());
		if (struView == null || struView.length <= 0) {
			return "";
		} else{
			return struView[0].getStruId();
		}
	}
	/**
	 * 获取当前登录单位StruId
	 * @return
	 */
	public static String getStruId() {
		String organId = GetBspInfo.getBspInfo().getCorporationOrganId();
		StruView[] struV = op.getListByOrganId(organId);
		String struId = ((StruView)struV[0]).getStruId();
		return struId;
		}
	/**
	 * 获取当前登录单位OrganCode
	 * @return
	 */
	public static String getOrganCode() {
		String organId = GetBspInfo.getBspInfo().getCorporationOrganId();
		OrganView OrganView = op.getOrganByOrganId(organId);
		String OrganCode = OrganView.getOrganCode();
		return OrganCode;
	}
	
	/**
	 * 获取当前登录单位OrganType
	 * @return
	 */
	public static String getOrganType() {
		String organId = GetBspInfo.getBspInfo().getCorporationOrganId();
		OrganView OrganView = op.getOrganByOrganId(organId);
		String OrganType= OrganView.getOrganType();
		return OrganType;
	}
	/**
	 * 获取当前登录单位OrganName
	 * @return
	 */
	public static String getOrganName() {
		String organId = GetBspInfo.getBspInfo().getCorporationOrganId();
		OrganView OrganView = op.getOrganByOrganId(organId);
		String OrganName = OrganView.getOrganName();
		return OrganName;
	}
	
	/**
	 * 获取当前登录用户 RoleId
	 * @return 
	 */
	public static String[] getRoleId(){
		ISecurityProvider sp = SecurityFactory.getISecurityProvider();
		RoleView[] roleView = sp.getAuthorizedRoles();
		if(roleView==null || roleView.length<=0){
			return null;
		}else{
			String[] roleId = new String[roleView.length];
			for(int i=0;i<roleView.length;i++){
				roleId[i]=roleView[i].getRoleId();
			}
			return roleId;
		}
	}
	
	/**
	 * 获取当前登录用户 RoleName
	 * @return 
	 */
	public static String[] getRoleName(){
		ISecurityProvider sp = SecurityFactory.getISecurityProvider();
		RoleView[] roleView = sp.getAssignedRole(GetBspInfo.getBspInfo().getUserId());
		if(roleView==null || roleView.length<=0){
			return  new String[0];
		}else{
			String[] roleName = new String[roleView.length];
			for(int i=0;i<roleView.length;i++){
				roleName[i]=roleView[i].getRoleName();
			}
			return roleName;
		}
	}
	
	/**
	 * 获取当前登陆人部门的struId
	 * @return
	 */
	public static String getDeptStruId() {
		String departmentOrganId = GetBspInfo.getBspInfo().getCorporationOrganId();
		IOrganProvider op = OrganFactory.getIOrganProvider();
		String [] id= {departmentOrganId};
		String struId = "";
		if(!departmentOrganId.equals("")){
			StruView[] struview = op.batchQueryStruViewByOrganId(id);
			if(struview.length>0){
				 struId = struview[0].getStruId();
			}else if(struview.length>1){
				throw new RuntimeException("根据当前登陆用户的部门id没有查询到多条struId！");
			}else{
				throw new RuntimeException("根据当前登陆用户的部门id没有查询到struId！");
			}
		}
		return struId;
		}
	/**
	 * 根据员工organId获取对应组织机构类型下的该员工部门的organId
	 * @param organId
	 * @param struType
	 * @return
	 */
	public static String getDeptByEmployeeId(String organId,String struType){
		IOrganProvider op = OrganFactory.getIOrganProvider();
		StruView[] struArr = op.getListByOrganId(organId, struType);
		return struArr[0].getDeptId();
	}
	
	/**
	 * 根据员工organId获取对应组织机构类型下的该员工单位的organId
	 * @param organId
	 * @param struType
	 * @return
	 */
	public static String getOrganByEmployeeId(String organId,String struType){
		IOrganProvider op = OrganFactory.getIOrganProvider();
		StruView[] struArr = op.getListByOrganId(organId, struType);
		return struArr[0].getOrganId();
	}

}
