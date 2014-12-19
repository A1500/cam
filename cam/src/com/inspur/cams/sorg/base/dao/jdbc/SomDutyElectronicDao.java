package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import com.inspur.cams.sorg.base.dao.ISomDutyElectronicDao;
import com.inspur.cams.sorg.base.data.SomDutyElectronic;
/**
 * 职务与相关附件中间表Dao层
 * @author yanliangliang
 * @date 2011-12-17
 */
public class SomDutyElectronicDao extends EntityDao<SomDutyElectronic> implements ISomDutyElectronicDao{

	public static String UPDATE_DUTY_ID = "UPDATE SOM_DUTY_ELECTRONIC SET DUTY_ID=? WHERE DUTY_ID=? ";
	
	@Override
	protected Class<SomDutyElectronic> getEntityClass() {
		return SomDutyElectronic.class;
	}
	/**
	 * 通过旧的dutyId更新为新的dutyId
	 */
	public void updateDutyId(String oldDutyId, String newDutyId) {
		int[] types = new int[] {Types.VARCHAR, Types.VARCHAR};
		Object[] objs = new Object[] {newDutyId, oldDutyId};
		executeUpdate(UPDATE_DUTY_ID, types, objs);
	}

}
