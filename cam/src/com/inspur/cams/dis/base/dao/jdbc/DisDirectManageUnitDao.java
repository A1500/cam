package com.inspur.cams.dis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.dis.base.dao.IDisDirectManageUnitDao;
import com.inspur.cams.dis.base.data.DisDirectManageUnit;

/**
 * 直管单位配置表dao
 * @author 
 * @date 2012-11-19
 */
public class DisDirectManageUnitDao extends EntityDao<DisDirectManageUnit> implements IDisDirectManageUnitDao {
	
	@Override
	public Class<DisDirectManageUnit> getEntityClass() {
		return DisDirectManageUnit.class;
	}

	/**
	 * @Description: 查询指定单位下的所有直属单位
	 * @author xuexzh
	 */
	public DataSet queryAllUnit(ParameterSet pset) {
		String organCode = (String) pset.get("organCode");
		String organType = (String) pset.get("organType");
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		DataSet ds = new DataSet();
		if (StringUtils.isNotEmpty(organCode)) {
			if("11".equals(organType)) {
				//省
				sql.append("SELECT A.ID,A.NAME,A.FT,(SYS_GUID()||'') SOURCE_ID FROM (SELECT ID,NAME,LEVE+1 FT FROM DIC_CITY C WHERE C.UPS = ? AND C.IS_SELF=? UNION ");
				sql.append(" SELECT ID,NAME,LEVE+1 FT FROM DIS_DIRECT_MANAGE_UNIT D WHERE D.UPS = ?) A ORDER BY FT,ID");
				typeList.add(Types.VARCHAR);
				objList.add(organCode);
				typeList.add(Types.VARCHAR);
				objList.add("0");
				typeList.add(Types.VARCHAR);
				objList.add(organCode);
			}else if("12".equals(organType)) {
				//市
				sql.append("SELECT A.ID,A.NAME,A.FT,(SYS_GUID()||'') SOURCE_ID FROM (SELECT ID,NAME,LEVE+1 FT FROM DIC_CITY C WHERE C.UPS = ? AND C.IS_SELF=? ");
				sql.append(" ) A ORDER BY FT,ID");
				typeList.add(Types.VARCHAR);
				objList.add(organCode);
				typeList.add(Types.VARCHAR);
				objList.add("0");
			}else if("13".equals(organType)) {
				//县
				String headOrgan = organCode.substring(0, 6);
				sql.append("SELECT A.ID,A.NAME,A.FT,(SYS_GUID()||'') SOURCE_ID FROM (SELECT ID,NAME,LEVE+1 FT FROM DIC_CITY C WHERE C.UPS = ? AND C.IS_SELF=? ");
				sql.append(" AND C.ID<?) A ORDER BY FT,ID");
				typeList.add(Types.VARCHAR);
				objList.add(organCode);
				typeList.add(Types.VARCHAR);
				objList.add("0");
				typeList.add(Types.VARCHAR);
				objList.add(headOrgan+"400000");
			}else {
				throw new RuntimeException("未知登录用户等级！");
			}
			
			if(typeList.size()>0&&objList.size()>0){
				int[] types = new int[typeList.size()];
				for (int i = 0; i < types.length; i++) {
					types[i]=typeList.get(i);
				}
				Object[] objs = objList.toArray(new Object[objList.size()]);
				ds = this.executeDataset(sql.toString(), types, objs, true);
			}
		}
		return ds;
	}

}