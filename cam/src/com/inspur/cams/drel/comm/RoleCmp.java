package com.inspur.cams.drel.comm;
import com.inspur.cams.comm.util.BspUtil;
import org.loushang.bsp.share.permit.bean.RoleView;
import org.loushang.bsp.share.permit.security.SecurityFactory;
import org.loushang.bsp.share.permit.security.provider.ISecurityProvider;

public class RoleCmp {
	public static boolean getIfRoleName(String roleName){
		String[] roleNameArr=BspUtil.getRoleName();
		for(int i=0;i<roleNameArr.length;i++)
		{
			if(roleName.equals(roleNameArr[i])){
				return true;
			}
		}
		return false;
	}
	public static boolean getIfRoleId(String roleId){
		String[] roleIdArr=BspUtil.getRoleId();
		for(int i=0;i<roleIdArr.length;i++)
		{
			if(roleId.equals(roleIdArr[i])){
				return true;
			}
		}
		return false;
	}
	public static boolean getIfRolefromUserId(String roleNameStr,String UserId){
		ISecurityProvider sp = SecurityFactory.getISecurityProvider();
		RoleView[] roleView = sp.getAssignedRole(UserId);
		if(roleView==null || roleView.length<=0){
			return false;
		}else{
			for(int i=0;i<roleView.length;i++){
				if(roleNameStr.equals(roleView[i].getRoleName())){
					return true;
				}
			}
			return false;
		}
	}
}