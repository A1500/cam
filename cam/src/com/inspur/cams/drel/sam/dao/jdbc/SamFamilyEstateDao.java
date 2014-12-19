package com.inspur.cams.drel.sam.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamFamilyEstateDao;
import com.inspur.cams.drel.sam.data.SamFamilyEstate;
/**
 * 家庭财产信息Dao
 * @author yanliangliang
 *2012年5月2日9:45:43
 */
public class SamFamilyEstateDao extends EntityDao<SamFamilyEstate> implements ISamFamilyEstateDao {

	@SuppressWarnings("unchecked")
	@Override
	protected Class getEntityClass() {
		return SamFamilyEstate.class;
	}

	public void deleteByFamilyId(String familyId) {
		executeUpdate("DELETE FROM SAM_FAMILY_ESTATE WHERE FAMILY_ID = ?", new int[] { Types.VARCHAR },
				new Object[] { familyId });
		
	}

}
