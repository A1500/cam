package com.inspur.cams.prs.prsretiredsoldiers.dao;

import org.loushang.next.dao.EntityDao;
import java.sql.Types;

/**
 * @title:SoldiersuploadDao
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
 */
public class SoldiersuploadDao extends EntityDao<SoldiersUpload> implements
		ISoldiersuploadDao {

	@Override
	public Class getEntityClass() {
		return SoldiersUpload.class;
	}
	public void updateFlag(String id) {
		executeUpdate(" UPDATE PRS_CATALOGUE T SET T.INSERT_FLAG = '1' WHERE T.CATALOG_ID = ?",
				new int[]{Types.VARCHAR},new Object[]{id});
	}

}
