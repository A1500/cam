package com.inspur.cams.drel.sam.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import com.inspur.cams.drel.sam.dao.ISamFamilySupportDao;
import com.inspur.cams.drel.sam.data.SamFamilySupport;
/**
 * 赡扶抚养人Dao
 * @author yanliangliang
 *2012年5月2日9:45:43
 */
public class SamFamilySupportDao extends EntityDao<SamFamilySupport> implements ISamFamilySupportDao {

	@SuppressWarnings("unchecked")
	@Override
	protected Class getEntityClass() {
		return SamFamilySupport.class;
	}

	public void deleteByFamilyId(String familyId) {
		executeUpdate("DELETE FROM Sam_Family_Support WHERE FAMILY_ID = ?", new int[] { Types.VARCHAR },
				new Object[] { familyId });
		
	}

}
