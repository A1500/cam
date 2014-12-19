package com.inspur.cams.fis.util;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;

public class InformOrganTreeDao extends BaseJdbcDao {

	/***************************************************************************
	 * @说明：根据传入的organCode获取到记录
	 * @param organCode
	 */
	public DataSet query(String organCode) {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT S.ORGAN_CODE AS CODE,S.ORGAN_NAME AS NAME,S.ORGAN_TYPE AS TYPE,REPLACE(S.ORGAN_NAME,'民政局','') AS SHORT_NAME FROM PUB_ORGAN S ");
		sql.append(" WHERE S.ORGAN_ID IN (SELECT T.ORGAN_ID FROM PUB_STRU T, PUB_ORGAN P WHERE T.PARENT_ID = P.ORGAN_ID AND P.ORGAN_CODE = ?)");
		sql.append(" AND S.ORGAN_TYPE in ('12', '13') AND IN_USE = '1' ORDER BY CODE");

		// System.out.println("getOrganSql==="+sql);
		int[] types = new int[1];
		Object[] args = new Object[1];
		types[0]=Types.VARCHAR;
		args[0]=organCode;
		
		return executeDataset(sql.toString(),types,args,true);
	}

	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
	}

}
