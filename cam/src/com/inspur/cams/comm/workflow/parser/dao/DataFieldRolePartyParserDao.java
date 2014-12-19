package com.inspur.cams.comm.workflow.parser.dao;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.organization.data.Stru;
import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.bsp.util.RecordUtil;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.check.balancesheet.data.SomCheckBalanceSheet;

public class DataFieldRolePartyParserDao extends EntityDao<Stru>{
	/**
	 * 根据struid和roleid获取相应的员工
	 * @param struId
	 * @param roleId
	 * @param isIncludeSubCorporation true则向下递归，false则不递归 如省厅的struId，递归的话包括省厅下的单位，不递归只包含省厅下的部门
	 * @return
	 */
	public StruView[] getUnderlingEmployeeByStruIdAndRoleId(String struId,
			String roleId,boolean isIncludeSubCorporation) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT DISTINCT SS.*,O.ORGAN_NAME ");
		sql.append("FROM PUB_ROLES R,PUB_USER_ROLE UR,PUB_USER_EMPLOYEE E,PUB_STRU SR ,PUB_STRU SS,PUB_ORGAN O,PUB_STRU_EXT SE ");
		sql.append("WHERE R.ROLE_ID=UR.ROLE_ID ");
		sql.append("AND UR.TARGET=E.USER_ID ");
		sql.append("AND E.EMPLOYEE_ID=SR.STRU_ID ");
		sql.append("AND SR.STRU_PATH LIKE ? ");
		sql.append("AND E.EMPLOYEE_ID=SS.STRU_ID ");
		sql.append("AND SS.ORGAN_ID=O.ORGAN_ID ");
		sql.append("AND R.ROLE_ID=? ");
		if(!isIncludeSubCorporation){
			sql.append("AND SS.ORGAN_ID=SE.SRC_ID ");
			sql.append("AND SE.TARGET_ID=?");
		}
		int[] types = { Types.VARCHAR,Types.VARCHAR ,Types.VARCHAR };
		Object[] obj = {  "%#"+struId+"%",roleId ,getOrganIdByStruId(struId)};
		List<Map> list = executeQuery(sql.toString(), types, obj);
		StruView[] views = new StruView[list.size()];
		for (int i = 0; i < list.size(); i++) {
			Map map = list.get(i);
			StruView struView = (StruView) RecordUtil.getInstance()
					.getBeanFromDB((map), StruView.class);
			views[i] = struView;
		}
		return views;
	}
	
	private static final String  queryOrganIdByStruId = "SELECT ORGAN_ID FROM PUB_STRU WHERE STRU_ID=?";

	public String getOrganIdByStruId(String struId) {
		int[] types = { Types.VARCHAR };
		List<Map> tempList=executeQuery(queryOrganIdByStruId, types, new String[]{struId});
		if(tempList.size()==0)
			return null;
		else
			return (String)(tempList.get(0).get("ORGAN_ID"));
	}
	
	@Override
	public Class getEntityClass() {
		return SomCheckBalanceSheet.class;
	}

}
